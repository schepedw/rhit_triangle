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
gem 'therubyrhino'
gem 'figgy'

group :production do
  gem 'unicorn-rails'
  gem 'eye'
end

group :development, :test do
  gem 'pry'
  gem 'faker'
end

group :development do
  gem 'spring'
end

group :test do
  # NOTE: None of the test gems have been properly initialized
  gem 'rspec-rails'
  gem 'cucumber-rails', :require => false
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
  gem 'factory_girl_rails'
end
