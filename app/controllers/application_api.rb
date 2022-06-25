require 'grape-swagger'

class ApplicationApi < Grape::API
  format :json
  helpers Pundit
  helpers do
    def current_user
      @current_user ||= User.find_by!(id: headers['Access-Token'])
    end
  end

  mount Search
  mount UserPlaylists
  mount Groups
end
