class Groups < Grape::API
  helpers do
    attr_writer :group, :group_playlist

    def group
      @group ||= Group.find(params[:id])
    end

    def group_playlist
      @group_playlist ||= GroupPlaylist.find_by(group_id: params[:group_id])
    end
  end

  resource :groups do
    desc '그룹만들기' do
      summary '그룹만들기'
      tags ['Group']
      success model: Entities::Groups::BaseEntity
      failure [
        { code: 400, message: 'Bad Request' },
        { code: 403, message: 'Forbidden' },
        { code: 404, message: 'Not found' }
      ]
    end

    params do
      requires :name, type: String, documentation: { param_type: 'body' }
      requires :user_groups, as: :user_groups_attributes, type: Array[JSON], desc: '유저 그룹' do
        requires :user_id, type: Integer, desc: '유저 id', documentation: { param_type: 'body' }
      end
    end

    post do
      group = Group.new(declared(params))
      group.save!

      present :data,
              group,
              with: Entities::Groups::BaseEntity
    end

    desc '그룹 수정 및 유저 추가' do
      summary '그룹 수정 및 유저 추가'
      tags ['Group']
      success model: Entities::Groups::BaseEntity
      failure [
        { code: 400, message: 'Bad Request' },
        { code: 403, message: 'Forbidden' },
        { code: 404, message: 'Not found' }
      ]
    end

    params do
      optional :name, type: String, desc: '그룹 이름', documentation: { param_type: 'body' }
      optional :user_groups, as: :user_groups_attributes, type: Array[JSON], desc: '유저 그룹' do
        optional :user_id, type: Integer, desc: '유저 id', documentation: { param_type: 'body' }
      end
    end

    put ':id' do
      authorize group, :update?

      group.update!(declared(params, include_missing: false))

      present :data,
              group,
              with: Entities::Groups::BaseEntity
    end

    resource ':group_id/playlists' do
      desc '그룹 재생목록 추가' do
        summary '재생목록 추가'
        tags ['GroupPlaylist']
        failure [
          { code: 400, message: 'Bad Request' },
          { code: 403, message: 'Forbidden' },
          { code: 404, message: 'Not found' }
        ]
      end

      params do
        requires :music_id, types: [Integer, Array[Integer]], desc: '노래 id', documentation: { param_type: 'body' }
      end
      post do
        authorize group_playlist, :create?

        destroy_count = (group_playlist.music_group_playlists.size - 100)
        if params[:music_id].instance_of?(Integer)
          group_playlist.music_group_playlists.create!(declared(params))
        else
          music_playlist = params[:music_id].each_with_object([]) do |music_id, arr|
            arr << group_playlist.music_group_playlists.new(music_id: music_id, creator_id: current_user.id,
                                                            created_at: DateTime.now.in_time_zone,
                                                            updated_at: DateTime.now.in_time_zone)
          end
          MusicGroupPlaylist.transaction do
            group_playlist.music_group_playlists.order(:id).limit(destroy_count).destroy_all if destroy_count.positive?
            MusicGroupPlaylist.insert_all!(music_playlist.as_json)
          end
        end
        status :ok
      end

      desc '그룹 재생목록 노래 삭제' do
        summary '재생목록 노래 삭제'
        tags ['UserPlayList']
        failure [
          { code: 400, message: 'Bad Request' },
          { code: 403, message: 'Forbidden' },
          { code: 404, message: 'Not found' }
        ]
      end

      params do
        requires :music_group_playlist_id, types: [Integer, Array[Integer]], desc: '추가할 노래 id',
                                           documentation: { param_type: 'body' }
      end
      delete do
        authorize group_playlist, :delete?

        group_playlist.music_group_playlists.destroy_by(id: params[:music_group_playlist_id])

        body nil
      end
    end
  end
end
