module Search
  extend ActiveSupport::Concern
  module Music
    def self.included(base)
      base.class_eval do
        include Elasticsearch::Model
        include Elasticsearch::Model::Callbacks
        index_name [model_name.singular, Rails.env].join('_')
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

    def self.search_published(query, sort = 'accuracy', started_at = nil, ended_at = nil)
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

      Elasticsearch::Model.search(
        { sort: sorting(sort.to_sym),
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
      sorting = {
        accuracy: [{ _score: 'desc' }, { id: 'desc' }],
        recency: [{ created_at: 'desc' }],
        popularity: [{ like_count: 'desc' }, { id: 'desc' }]
      }
      sorting[type]
    end

    def self.update_album(album, options = {})
      options[:index] ||= album.searchable_type.index_name
      options[:type] ||= album.searchable_type.document_type
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
      Elasticsearch::Model.client.update_by_query(options)
    end

    def self.update_to_elasticsearch(musics)
      musics.each do |model|
        model.__elasticsearch__.update_document({ type: model.class.document_type })
      end
    end
  end
end
