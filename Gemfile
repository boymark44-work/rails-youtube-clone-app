source "https://rubygems.org"

ruby "3.3.5"

gem "rails", "~> 7.1.2"
gem "sprockets-rails"
gem "pg", '~> 1.5', '>= 1.5.9'
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[windows jruby]
gem "bootsnap", require: false

# Custom Gems: 
gem "devise", '~> 4.9', '>= 4.9.4'
gem 'ostruct', '~> 0.6.1' # To silence a particular error. 
gem "ancestry"
gem "kaminari"
gem "slim-rails"

group :development, :test do
  gem "debug", platforms: %i[mri windows]
  gem 'faker'
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end