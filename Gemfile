source 'https://rubygems.org'

ruby '2.6.2'

gem 'activerecord-session_store', '~> 1.0'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'caxlsx'
gem 'caxlsx_rails'
gem 'chartkick'
gem 'cloudinary'
gem "devise", '>= 4.7.1'
gem 'foundation-rails', '6.2.3.0'
gem 'groupdate'
gem 'jbuilder', '~> 2.7'
gem 'omniauth-facebook', '~> 4.0'
gem 'omniauth-google-oauth2', '~> 0.8.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'pickadate-rails'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.2', '>= 6.0.2.2'
gem 'sass-rails', '>= 6'
gem 'travis'
gem 'turbolinks', '~> 5'
gem 'validates_overlap'
gem 'webpacker', '~> 4.0'
gem 'will_paginate', '~> 3.3'

group :development, :test do
  gem 'rubocop'
end

group :development do
  gem 'dotenv', '~> 2.2.1'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'coveralls'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'simplecov-console'
  %w[rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
    gem lib, git: "https://github.com/rspec/#{lib}.git", branch: 'main'
  end
end
