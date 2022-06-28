class Searches < Grape::API
  resource :search do
    desc '음원 데이터 검색' do
      summary '음원 검색'
      tags ['search']
      success model: Entities::Searches::BaseEntity, is_array: true
      failure [
        { code: 404, message: 'Not found' }
      ]
    end

    params do
      requires :q, type: String, desc: '검색어', documentation: { param_type: 'query' }
      optional :page, type: Integer, desc: '페이지 순서', default: 1, documentation: { param_type: 'query' }
      optional :size, type: Integer, desc: '페이지 크기', default: 50, documentation: { param_type: 'query' }
      optional :sort, type: String,  desc: '정렬 기준', default: 'accuracy', values: %w[accuracy recency popularity],
                      documentation: { param_type: 'query' }
      optional :started_at, type: Date, desc: '시작 시점', documentation: { param_type: 'query' }
      optional :ended_at, type: Date, desc: '종료 시점', documentation: { param_type: 'query' }
    end
    get do
      search_results = Search::Music.search_published(params[:q], params[:sort], params[:started_at],
                                                      params[:ended_at])
                                    .page(params[:page]).per(params[:size]).pluck(:_source)

      present :data, search_results, with: Entities::Searches::BaseEntity
    end
  end
end
