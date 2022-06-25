class Groups < Grape::API
  helpers do
    attr_writer :group, :group_playlist

    def group
      @group ||= Group.find(params[:id])
    end

    def group_playlist
      @group_playlist ||= GroupPlaylist.find(params[:group_id])
    end
  end

  resource :groups do
    desc '그룹만들기' do
      summary '그룹만들기'
      tags ['Group']
      failure [
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

      present :data, group,
              with: Entities::Groups::BaseEntity
    end

    desc '그룹 수정 및 유저 추가 및 삭제' do
      summary '그룹 수정 및 유저 추가'
      tags ['Group']
      failure [
        { code: 404, message: 'Not found' }
      ]
    end

    params do
      optional :name, type: String, desc: '그룹 이름', documentation: { param_type: 'body' }
      optional :user_groups_attributes, type: Array[JSON], desc: '유저 그룹' do
        optional :id, type: Integer, desc: '유저 id', documentation: { param_type: 'body' }
        optional :user_id, type: Integer, desc: '유저 id', documentation: { param_type: 'body' }
        optional :_destroy, type: Boolean, desc: '삭제여부'
      end
    end

    put ':id' do
      authorize group, :update?
      update_params = declared(params, include_missing: false)

      if params['user_groups_attributes'].present?

        destroy_user_group_ids = group.user_group_ids - params[:user_groups_attributes].map do |user_group|
                                                          user_group[:id]
                                                        end

        destroy_user_groups = destroy_user_group_ids&.map { |id| { id: id, _destroy: true } }
        update_params[:user_groups_attributes] += destroy_user_groups
      end
      group.update!(update_params)

      present :data, group,
              with: Entities::Groups::BaseEntity
    end

    resource ':group_id/:group_playlists' do
      desc '그룹 재생목록 추가' do
        summary '재생목록 추가'
        tags ['GroupPlaylist']
        failure [
          { code: 404, message: 'Not found' }
        ]
      end

      params do
        requires :creator_id, type: Integer, desc: '추가한 유저 id', documentation: { param_type: 'body' }
        requires :music_id, types: [Integer, Array[Integer]], desc: '노래 id', documentation: { param_type: 'body' }
      end
      post do
        authorize group_play_list, create?

        count = (group_playlist.music_group_playlists.size - 100)
        if params[:music_id].instance_of?(Integer)
          group_playlist.music_group_playlists.create!(declared(params))
        else
          music_playlist = params[:music_id].each_with_object([]) do |music_id, arr|
            arr << group_playlist.music_group_playlists.new(music_id: music_id, created_at: DateTime.now.in_time_zone,
                                                            updated_at: DateTime.now.in_time_zone)
          end
          MusicGroupPlaylist.transaction do
            group_playlist.music_group_playlists.order(:id).limit(count).destroy_all if count.positive?
            MusicGroupPlaylist.insert_all!(music_playlist.as_json)
          end
        end
        status :ok
      end

      desc '그룹 재생목록 노래 삭제' do
        summary '재생목록 노래 삭제'
        tags ['UserPlayList']
        failure [
          { code: 404, message: 'Not found' }
        ]
      end

      params do
        requires :music_group_playlist_id, types: [Integer, Array[Integer]], desc: '추가할 노래 id',
                                           documentation: { param_type: 'body' }
      end
      delete do
        authorize group_playlist, delete?

        if params[:music_group_playlist_id].instance_of?(Integer)
          group_playlist.music_group_playlists.find_by(music_id: params[:music_group_playlist_id])&.destroy
        else
          group_play_list.music_group_playlists.where(music_id: params[:music_group_playlist_id]).destroy_all
        end

        body nil
      end
    end
  end
end
