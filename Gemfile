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

### Travis
gem 'travis'

### Coverall
gem 'coveralls', require: false

### Pagination
gem 'will_paginate'

### Caching
gem 'dalli'

group :development, :test do
  ### Debugging
  gem 'awesome_print'
  gem 'byebug'

  ### Annotate schema
  gem 'annotate'

  ### Unit Test
  gem 'factory_girl_rails'
  gem 'listen'
  gem 'rspec-rails'
end

group :test do
  gem 'database_cleaner'
  gem 'simplecov', require: false
end

group :production do
  gem 'rails_12factor'
end
