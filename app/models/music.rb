# == Schema Information
#
# Table name: musics
#
#  id         :bigint           not null, primary key
#  like_count :integer          default(0)
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  album_id   :bigint           not null
#
# Indexes
#
#  index_musics_on_album_id  (album_id)
#
# Foreign Keys
#
#  fk_rails_...  (album_id => albums.id)
#
class Music < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  index_name [model_name.singular, Rails.env].join('_')

  belongs_to :album
  has_many :music_artists
  has_many :artists, through: :music_artists

  settings index: {
    analysis: {
      analyzer: {
        korean: {
          type: 'custom',
          tokenizer: 'nori_tokenizer'
        }
      },
      tokenizer: {
        nori_tokenizer: {
          type: 'nori_tokenizer',
          index_eojeol: false
        }
      }
    }
  } do
    # dynamic: :strict means an error will be raised when an unknown column is given while indexing.
    # dynamic options should be string or symbol
    mapping dynamic: 'strict' do
      indexes :id, type: 'integer' # Integer field allows array of integers.
      indexes :title, type: 'text', analyzer: 'korean'
      indexes :created_at, type: 'date'
      indexes :album_id, type: 'integer'
      indexes :like_count, type: 'integer'

      indexes :album do
        indexes :id, type: 'integer'
        indexes :title, type: 'text', analyzer: 'korean'
      end
      indexes :artists do
        indexes :id, type: 'integer'
        indexes :name, type: 'text', analyzer: 'korean'
      end
    end
  end

  def as_indexed_json(_options = {})
    as_json(
      only: %i[id title like_count],
      include: {
        album: {
          only: %i[id title]
        },
        artists: {
          only: %i[id name]
        }
      }
    )
  end

  def self.search_published(query_string)
    return [] if query_string.empty?

    search(
      { sort: [
        { _score: 'desc' },
        { id: 'desc' }
      ],
        query: {
          bool: {
            must: [
              {
                bool: {
                  minimum_should_match: 1,
                  should: [
                    {
                      multi_match: {
                        query: query_string,
                        operator: 'and'
                      }
                    }
                  ]
                }
              }
            ]
          }
        } }
    )
  end
end
