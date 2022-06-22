source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.6'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'
gem 'active_model_serializers', '~> 0.10'
gem 'discard' # for soft delete
gem 'grape'
gem 'grape_on_rails_routes'
gem 'grape-swagger'
gem 'grape-swagger-entity'
gem 'grape-swagger-representable'
gem 'kaminari' # for pagenation
gem 'mysql2'
gem 'ranked-model' # for sorting

gem 'elasticsearch-model', '~> 7'
gem 'elasticsearch-rails', '~> 7'
gem 'nokogiri'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'active_record_query_trace'
  gem 'annotate'
  gem 'bullet'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', require: false
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'simplecov'
end

group :development do
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'awesome_print'
  gem 'spring'
  gem 'spring-watcher-listen'
end
group :test do
  gem 'database_cleaner'
  gem 'test-prof'
  gem 'webmock'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
