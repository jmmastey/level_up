source 'https://rubygems.org'

gem 'rails', '~> 5.0.0'

gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'jbuilder'
gem 'bootstrap-sass'
gem 'devise', '~> 4.1'
gem 'haml-rails'
gem 'pg'
gem 'rolify'
gem 'state_machine'
gem 'gravatar_image_tag'
gem 'puma', ">= 2.0"
gem 'omniauth-github'
gem 'will_paginate'
gem 'will_paginate-bootstrap'
gem 'dotenv'

group :development do
  gem 'foreman'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'pry-rails', require: false
  gem 'rb-readline'
  gem 'rspec-rails'
  gem 'rspec-pride', '3.1.1'
  gem 'poltergeist'

  # other test deps
  gem 'rake'
  gem 'capybara'
  gem 'cucumber'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'spring'
  gem 'spring-commands-rspec' # since we're using rspec

  # guard stuff
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'rb-fchange', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-inotify', require: false

  # more code checking!
  gem 'pronto'
  gem 'pronto-rubocop'
  gem 'pronto-flay'
  gem 'rubocop'
  gem 'rubocop-rspec'

  gem 'rspec-activerecord-formatter'
end

group :production do
  gem 'rails_12factor'
  gem 'newrelic_rpm'
end
