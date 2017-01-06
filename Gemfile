source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.0'
gem 'sqlite3'
gem 'puma'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'devise'
gem 'cancancan'
gem 'breadcrumbs_on_rails'
gem 'kaminari'
gem 'compass-rails'
gem 'bootstrap-sass'
gem 'mail-iso-2022-jp'
gem 'newrelic_rpm'
gem 'exception_notification'
gem 'slack-notifier'
gem 'activerecord-session_store'
gem 'slim-rails'
gem 'whenever'
gem 'pg'
gem 'redis-rails'
gem 'sidekiq'

group :development, :test do
  gem 'byebug', platform: :mri
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
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
