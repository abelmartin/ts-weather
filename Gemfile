# 667-207-6520/$1,720/13438881
# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.3'

gem 'importmap-rails'
gem 'openweathermap'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.3', '>= 7.1.3.2'
gem 'raygun4ruby'
gem 'sprockets-rails'
gem 'sqlite3', '~> 1.4'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

gem 'bootsnap', require: false
gem 'jbuilder'
gem 'redis', '>= 4.0.1'
gem 'tzinfo-data', platforms: %i[mswin mswin64 mingw x64_mingw jruby]

# spinning up our server locally and on Heroku
gem 'foreman'

# 'for validation of addresses'
gem 'geocoder'

group :development, :test do
  # for environment variables
  gem 'dotenv-rails'

  # ensure our tests don't make real requests
  gem 'webmock'

  # debugger
  gem 'pry-byebug'

  # for testing
  gem 'rspec-rails'
end

group :development do
  gem 'error_highlight', '>= 0.4.0', platforms: [:ruby]
  gem 'rubocop', require: false
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'
end
