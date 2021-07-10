source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.0.4'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'

# Serializer
gem 'jsonapi-serializer'

# Authentication
gem 'devise'
gem 'devise_invitable'
gem 'jwt'

# Backgound jobs 
gem 'delayed_job_active_record'
gem "daemons"

# Rack cors
gem 'rack-cors'

# Pagination
gem 'will_paginate'

# File uploading
gem "kt-paperclip", "~> 6.4", ">= 6.4.1"
gem 'aws-sdk-s3'

# Security
gem 'secure_headers'
gem "figaro"

# Searching
gem 'pg_search'

# Event tracking
gem 'paper_trail'

# Dummy data
gem 'faker'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]


