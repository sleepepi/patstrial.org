# frozen_string_literal: true

source "https://rubygems.org"

gem "rails",                "5.2.0.rc1"

# Database Adapter
gem "pg",                   "1.0.0"

# Gems used by project
gem "autoprefixer-rails"
gem "bootstrap-sass",       "~> 3.3.7"
gem "carrierwave",          "~> 1.2.2"
gem "devise",               "~> 4.4.1"
gem "figaro",               "~> 1.1.1"
gem "haml",                 "~> 5.0.1"
gem "kaminari",             "~> 1.0.1"

# Rails Defaults
gem "coffee-rails",         "~> 4.2"
gem "sass-rails",           "~> 5.0"
gem "uglifier",             ">= 1.3.0"

gem "jbuilder",             "~> 2.5"
gem "jquery-rails",         "~> 4.3.1"
gem "turbolinks",           "~> 5"

# Testing
group :test do
  gem "minitest"
  gem "rails-controller-testing"
  gem "simplecov",          "~> 0.14.1", require: false
end

group :development do
  gem "web-console", "~> 3.0"
end
