require 'grape-swagger'

class ApplicationApi < Grape::API
  format :json
  helpers Pundit
  helpers do
    def current_user
      @current_user ||= User.find_by!(id: headers['Access-Token'])
    end
  end

  mount Searches
  mount UserPlaylists
  mount Groups

  add_swagger_documentation hide_documentation_path: true,
                            info: { title: 'Ring Project' },
                            security_definitions: {
                              'access-token': {
                                type: 'integer',
                                name: 'access-token',
                                in: 'header'
                              }
                            }
end
