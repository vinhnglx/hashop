source 'https://rubygems.org'

gem 'rails', '>= 5.0.2.rc1', '< 5.1'

### Database
gem 'pg', '~> 0.18'

### App server
gem 'puma', '~> 3.0'

### Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

### JSON generation
gem 'active_model_serializers', '~> 0.10.0'

### Environment variables management
gem 'figaro'

### Coding style
gem 'brakeman'
gem 'bullet'
gem 'rails_best_practices'
gem 'rubocop'

group :development, :test do
  ### Debugging
  gem 'byebug'
  gem 'awesome_print'

  ### Annotate schema
  gem 'annotate'

  ### Unit Test
  gem 'rspec-rails'
end

group :test do
  gem 'database_cleaner'
  gem 'simplecov', require: false
end

