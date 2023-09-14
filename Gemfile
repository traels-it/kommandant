source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in kommandant.gemspec.
gemspec

gem "puma"

gem "sqlite3"

gem "sprockets-rails"
gem "turbo-rails", "~> 1.4"
group :development do
end
group :test do
  gem "kredis", "~> 1.5"
  gem "pagy", "~> 6.0"
  gem "minitest-spec-rails", "~> 7.2"
end

# Start debugger with binding.b [https://github.com/ruby/debug]
# gem "debug", ">= 1.0.0"
