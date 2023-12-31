source "https://rubygems.org"

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.1"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
# gem "rack-cors"

gem 'jwt', '~> 2.7', '>= 2.7.1'
gem 'bcrypt'
gem 'rswag-api'
gem 'rswag-ui'
gem "discard", "~> 1.2"
gem 'openssl', '~> 3.2'
gem "kaminari", "~> 1.2"
gem 'ransack'
gem "rack-cors", "~> 2.0"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "rspec-rails"
  gem "factory_bot_rails", "~> 6.2"
  gem "rubocop", "~> 1.57", require: false
  gem "brakeman", "~> 6.0", require: false
  gem "bundler-audit", "~> 0.9.1", require: false
  gem "rubocop-rspec", "~> 2.25", require: false
  gem "rubocop-rails", "~> 2.22", require: false
  gem "rubocop-factory_bot", "~> 2.23", require: false
  gem "rswag-specs"
  gem "rails-erd"
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  gem "vcr"
  gem "webmock", require: "webmock/rspec"
  gem 'shoulda-matchers', '~> 5.0'
  gem "timecop", "~> 0.9.8"
  gem "rspec"
  gem "simplecov", require: false
end
