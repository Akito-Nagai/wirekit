source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.0'
gem 'sqlite3'
gem 'puma'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'config'
gem 'devise'
gem 'cancancan'
gem 'breadcrumbs_on_rails'
gem 'kaminari'
gem 'mail-iso-2022-jp'
gem 'slim-rails'
gem 'pg'
gem 'redis-rails'
gem 'paperclip'
gem 'friendly_id'
gem 'faraday'
gem 'faraday_middleware'
gem 'doorkeeper'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'factory_girl_rails'
  gem 'rspec-rails'
end

group :development do
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'bullet'
  gem 'rack-mini-profiler'
  gem 'annotate'
  gem 'foreman'
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'
  gem 'hirb-unicode'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'debug_exceptions_json'
  gem 'letter_opener'
  gem 'letter_opener-iso-2022-jp'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
