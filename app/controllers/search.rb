class Search < Grape::API
  resource :search do
    desc '음원 검색' do
      summary '음원 검색'
      tags ['search']
      success model: Entities::Search::BaseEntity, is_array: true
      failure [
        { code: 404, message: 'Not found' }
      ]
    end

    params do
      requires :q, desc: '검색어', documentation: { param_type: 'query' }
      optional :page, type: Integer, desc: '페이지 순서', default: 1, documentation: { param_type: 'query' }
      optional :size, type: Integer, desc: '페이지 크기', default: 50, documentation: { param_type: 'query' }
      optional :sort_type, type: String, desc: '정렬 기준', documentation: { param_type: 'query' }
      optional :started_at, type: Date, desc: '시작 시점', documentation: { param_type: 'query' }
      optional :ended_at, type: Date, desc: '종료 시점', documentation: { param_type: 'query' }
    end
    get do
      search_results = Music.search_published(params[:q]).pluck(:_source)

      present :data, search_results, with: Entities::Search::BaseEntity
    end
  end
end
