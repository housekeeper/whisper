source "http://rubygems.org"

# Declare your gem's dependencies in whisper.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

gem "jquery-rails"
gem "pg"

group :assets do
  gem 'haml-rails',   '>= 0.4'
  gem 'sass-rails',   "~> 3.2"
  gem 'coffee-rails', "~> 3.2"
  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
  gem "rspec-rails", ">= 2.6.1"
  gem 'haml-rails', '>= 0.4'
  gem 'factory_girl_rails', '>= 4.2.0'
  gem "database_cleaner", ">= 0.9.1"
end
