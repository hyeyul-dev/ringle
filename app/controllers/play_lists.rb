class PlayLists < Grape::API
  helpers do
    def play_list
      @play_list ||= current_user.play_list
    end
  end

  resource :play_lists do
    desc '재생목록 추가' do
      summary '재생목록 추가'
      tags ['PlayList']
      failure [
        { code: 404, message: 'Not found' }
      ]
    end

    params do
      requires :music_id, types: [Integer, Array[Integer]], desc: '추가할 노래 id', documentation: { param_type: 'body' }
    end
    post do
      if params[:music_id].instance_of?(Integer)
        play_list.music_play_lists.create!(music_id: music_id)
      else
        music_play_lists = params[:music_ids].each_with_object([]) do |music_id, arr|
          arr << play_list.music_play_lists.new(music_id: music_id, created_at: DateTime.now.in_time_zone,
                                                updated_at: DateTime.now.in_time_zone)
        end
        MusicPlayList.insert_all!(music_play_lists.as_json)
      end

      status :ok
    end

    desc '재생목록 삭제' do
      summary '재생목록 삭제'
      tags ['PlayList']
      failure [
        { code: 404, message: 'Not found' }
      ]
    end

    params do
      requires :music_id, types: [Integer, Array[Integer]], desc: '추가할 노래 id', documentation: { param_type: 'body' }
    end
    delete do
      if params[:music_id].instance_of?(Integer)
        MusicPlayList.find_by(music_id: music_id, play_list_id: play_list.id)&.destroy
      else
        play_list.music_play_lists.where(music_id: params[:music_id]).destroy_all
      end

      body nil
    end
  end
end
