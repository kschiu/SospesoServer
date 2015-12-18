source 'https://rubygems.org'

gem 'rails', '4.2.4'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jquery-ui-rails'

gem 'hairtrigger'
gem 'validates_timeliness', '~> 3.0'

gem 'turbolinks', '~> 2.5.3'
gem "font-awesome-rails", '~> 4.4.0.0'
gem 'foundation-rails', '~> 5.5.3.2'

#Gem for CORS
gem 'rack-cors', :require => 'rack/cors'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'puma'
gem 'pg', '~> 0.18.3', group: [:production, :development]

gem 'populator3'
gem 'faker'
gem 'hirb'

# Gems used only in testing
group :test do
  gem 'factory_girl_rails'
  gem "minitest-reporters"
#  gem 'tconsole', git: 'git@github.com:ulmic/tconsole.git', branch: 'rails4'
  gem 'shoulda'
end

group :development, :test do
  gem 'sqlite3'
  gem 'colored'
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'meta_request'
  gem 'wirble'
  gem 'thin'
  gem 'spring'
  gem 'factory_girl'
  gem 'capistrano'
  gem 'capistrano-rvm'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano3-puma'
  # gem 'rails-erd' # requires Graphviz library to be installed
end

group :production do
  gem 'sqlite3'
end