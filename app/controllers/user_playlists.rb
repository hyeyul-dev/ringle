class UserPlaylists < Grape::API
  helpers do
    attr_writer :user_playlist

    def user_playlist
      @user_playlist ||= current_user.playlist
    end
  end

  resource :user_playlists do
    desc '재생목록 추가' do
      summary '재생목록 추가'
      tags ['UserPlayList']
      failure [
        { code: 404, message: 'Not found' }
      ]
    end

    params do
      requires :music_id, types: [Integer, Array[Integer]], desc: '노래 id', documentation: { param_type: 'body' }
    end
    post do
      current_user.playlist.create! if current_user.playlist.nil?
      count = (user_playlist.music_user_playlists.size - 100)
      if params[:music_id].instance_of?(Integer)
        user_playlist.music_user_playlists.create!(music_id: params[:music_id])
      else
        music_playlists = params[:music_id].each_with_object([]) do |music_id, arr|
          arr << user_playlist.music_user_playlists.new(music_id: music_id, created_at: DateTime.now.in_time_zone,
                                                        updated_at: DateTime.now.in_time_zone)
        end
        user_playlist.music_user_playlists.order(:id).limit(count).destroy_all if count.positive?
        MusicUserPlaylist.insert_all!(music_playlists.as_json)
      end

      status :ok
    end

    desc '재생목록 노래 삭제' do
      summary '재생목록 노래 삭제'
      tags ['UserPlayList']
      failure [
        { code: 404, message: 'Not found' }
      ]
    end

    params do
      requires :music_id, types: [Integer, Array[Integer]], desc: '추가할 노래 id', documentation: { param_type: 'body' }
    end
    delete do
      if params[:music_id].instance_of?(Integer)
        user_playlist.music_user_playlists.find_by(music_id: params[:music_id])&.destroy
      else
        user_playlist.music_user_playlists.where(music_id: params[:music_id]).destroy_all
      end

      body nil
    end
  end
end
