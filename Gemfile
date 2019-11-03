source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# rails
gem 'rails', '~> 5.2.3'

# db
gem 'sqlite3'
gem 'mysql2'

# auth
gem 'devise'
gem 'cancancan'
gem 'omniauth-facebook'
gem 'omniauth-naver'
gem "omniauth-kakao", :path => "vendor/gems/omniauth-kakao"

# tools
gem 'acts-as-taggable-on', '~> 6.0'

# activestorage
gem 'mini_magick', '~> 4.8'
gem 'image_processing', '~> 1.2'

# js
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'sass-rails', '~> 5.0'
gem 'haml-rails', '~> 1.0'
gem 'kaminari', '~> 0.17.0'
gem 'jbuilder', '~> 2.5'
gem 'bootstrap', '~> 4.3.1'
gem 'bootstrap_autocomplete_input'
gem 'simple_form'
gem 'summernote-rails'
gem 'cocoon'

# excel
gem 'axlsx', '2.1.0.pre'
gem 'axlsx_rails'

# Use Capistrano for deployment
gem 'unicorn'
gem 'capistrano', '~> 3.6'
gem 'capistrano-bundler', '~> 1.6'
gem 'capistrano-rails', '~> 1.1'
gem 'capistrano-rbenv', '~> 2.0'
gem 'capistrano-unicorn-nginx', '~> 4.1.0'

# Use Puma as the app server
gem 'puma', '~> 3.11'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'dotenv-rails'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
