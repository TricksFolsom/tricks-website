source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.2.1'
# Use postgresql as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '>= 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 5'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '>= 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '>= 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'
# Allows use of validators on active storage uploads
gem 'activestorage-validator'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
	# Sets a specific timeout for some actions so they don't cause the server to hang until crash
	# gem "rack-timeout" # causing problems locally
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
	gem 'awesome_print'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Adds use of jQuery
gem 'jquery-rails'
# Adds jQuery-UI. Used for a few different visual effects accross the site
gem 'jquery-ui-rails'
# Adds jQuery.minicolors. Used for creating color pickers to forms
gem 'jquery-minicolors-rails'

# Role specific permissions definied in Ability.rb
gem 'cancancan'

#pagination - https://github.com/kaminari/kaminari
gem 'kaminari'

# File uploads
gem "carrierwave"
# Image manipulation (resize, rotate, scale)
gem 'mini_magick', ">= 4.9.4"
# File storage solution
gem 'fog-google'
gem 'google-cloud-storage'

# Used to integrate with stripe.com for payment handling
gem "stripe"

# Google Analytics
gem 'google-analytics-rails'

# reCAPTCHA https://github.com/ambethia/recaptcha
gem "recaptcha"

# Service used for sending email
gem 'mailgun-ruby', '~>1.1.6'

# Allows for CSS styling to be applied to emails from <style> tags or other files
# instead of only in style="" attr
gem 'premailer-rails' 

# CSS Framework
gem 'foundation-rails'

# Allows making http requests and waiting for responses. Needed to get json class infor from jackrabbit
gem 'httparty'