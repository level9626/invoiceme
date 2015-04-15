source 'https://rubygems.org'
ruby '2.2.1'

gem 'rails',        '4.1.6'

# Assets
gem 'sass-rails',   '~> 4.0.3'
gem 'uglifier',     '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jquery-turbolinks', '~> 2.1.0'
gem 'turbolinks'
gem 'bootstrap-sass'
gem 'bootstrap-wysihtml5-rails'
gem 'bootstrap-datepicker-rails'
gem 'cocoon'

# db
gem 'pg'
gem 'composite_primary_keys'
gem 'slim-rails'

# Authentication, autorization
gem 'devise'
gem 'pundit'
gem 'upmin-admin'

# Json builder
gem 'jbuilder',     '~> 2.0'

# Server
gem 'puma'

# Form builder
gem 'simple_form'
gem 'carrierwave'
gem 'mini_magick'

gem 'figaro',       '>= 1.0.0.rc1'
gem 'high_voltage'

group :production do
  gem 'therubyracer', :platforms => :ruby
end

group :development do
  gem 'annotate'
  gem 'spring'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'capistrano', '~> 3.3.0'
  gem 'capistrano-bundler'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-rails-console'
  gem 'capistrano-rbenv', '~> 2.0'
  gem 'capistrano3-puma',   require: false
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
  gem 'spring-commands-rspec'
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'rspec-rails'
  gem 'rubocop'
end
group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
end
group :doc do
  gem 'sdoc', '~> 0.4.0'
end
