require 'grape-swagger'

class ApplicationApi < Grape::API
  format :json

  mount Search
end
