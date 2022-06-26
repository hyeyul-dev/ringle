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
  has_many :music_playlists, dependent: :destroy, inverse_of: :music
  has_many :music_artists, dependent: :destroy, inverse_of: :music
  has_many :artists, through: :music_artists

  settings index: {
    analysis: {
      analyzer: {
        korean: {
          type: 'custom',
          tokenizer: 'nori_tokenizer',
          filter: %w[lowercase asciifolding]
        }
      },
      tokenizer: {
        nori_tokenizer: {
          type: 'nori_tokenizer',
          filter: %w[lowercase asciifolding],
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
        indexes :created_at, type: 'date'
      end
      indexes :artists do
        indexes :id, type: 'integer'
        indexes :name, type: 'text', analyzer: 'korean'
      end
    end
  end

  def as_indexed_json(_options = {})
    as_json(
      only: %i[id title like_count created_at],
      include: {
        album: {
          only: %i[id title created_at]
        },
        artists: {
          only: %i[id name]
        }
      }
    )
  end

  def self.search_published(query, sort='accuracy', started_at = nil, ended_at = nil)
    return [] if query.empty?

    if started_at && ended_at
      filtered_date = {
        range: {
          created_at: {
            gte: started_at, # Greater than or equal to
            lte: ended_at # Less than or equal to
          }
        }
      }
    end

    search(
      { sort: sorting(sort),
        query: {
          bool: {
            must: [
              filtered_date,
              {
                bool: {
                  minimum_should_match: 1,
                  should: [
                    {
                      multi_match: {
                        query: query,
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

  def self.sorting(type)
    case type
    when 'accuracy' # 정확도순
      [
        { _score: 'desc' },
        { id: 'desc' }
      ]
    when 'recency' # 최신순
      [
        { created_at: 'desc' }
      ]
    when 'popularity' # 인기순
      [
        { like_count: 'desc' },
        { id: 'desc' }
      ]
    end
  end

  def self.update_album(album, options = {})
    options[:index] ||= index_name
    options[:type] ||= document_type
    options[:wait_for_completion] ||= false
    options[:body] = {
      conflicts: :proceed,
      query: {
        match: {
          'album.id': album.id
        }
      },
      script: {
        lang: :painless,
        source: 'ctx._source.album.title = params.album.title',
        params: { album: { title: album.title } }
      }
    }
    __elasticsearch__.client.update_by_query(options)
  end

  def self.update_music(musics)
    musics.each do |music|
      music.__elasticsearch__.update_document({ type: document_type })
    end
  end
end
