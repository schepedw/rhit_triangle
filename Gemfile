source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.2'
# Use postgres as the database for Active Record
gem 'pg'

gem 'capistrano', '2.15.4'
# Frontend things
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'twitter-bootstrap-rails'
gem 'font-awesome-rails'
gem 'twitter'
gem 'twitter-text'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'therubyracer'

gem 'figgy'

gem 'google-api-client', require: false

# Authentication + Authorization
gem 'devise'
gem 'rolify'

group :production do
  gem 'unicorn-rails'
  gem 'eye'
end

group :development, :test do
  gem 'pry'
  gem 'pry-byebug'
  gem 'rubocop', '~> 0.39.0', require: false
end

group :development do
  gem 'spring'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'cucumber-rails', require: false # NOTE: Cucumber has not been properly initialized
  gem 'database_cleaner'
end
