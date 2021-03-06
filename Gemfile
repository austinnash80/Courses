source 'https://rubygems.org'

ruby '2.7.1'
# ruby '2.6.2'
# ruby '3.0.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

group :assets do
  gem 'jquery-ui-rails', '~> 6.0'
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.6'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

gem 'bootstrap-sass'

gem 'bootstrap-datepicker-rails', '~> 1.6', '>= 1.6.1.1'

gem 'jquery-rails'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'rack-cors', '~> 0.4.0'

gem 'devise'

gem 'cancancan' #restrict access to some parts of app for users with specific roles

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'smarter_csv'

gem 'rails_12factor', group: :production

gem "chartkick" #graphs

gem "groupdate" #makes dates easier for chartkick

gem 'activerecord-import' #has not worked - should make imports faster

gem 'remotipart', github: 'mshibuya/remotipart' #part of the rails admin below - tutorial = https://codepany.com/blog/rails-5-user-accounts-with-3-types-of-roles-devise-rails_admin-cancancan/

gem 'rails_admin', '>= 1.0.0.rc' #to create an admin users - tutorial above

# gem 'vuejs-rails'

gem "figaro" #for aws - may not have been needed

gem "paperclip" #upload images

# gem 'aws-sdk', '~> 2.3' # file storage

gem 'aws-sdk-s3'

gem 'pdfkit' # generate pdfs

gem 'wkhtmltopdf-binary' #need for pdfkit gem

gem 'simple_form'

gem 'json'

gem 'derailed', group: :development

gem 'rearmed' #not using

gem 'mimemagic', github: 'mimemagicrb/mimemagic', ref: '3543363026121ee28d98dfce4cb6366980c055ee'
