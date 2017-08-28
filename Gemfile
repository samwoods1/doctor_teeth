source 'https://rubygems.org'
require 'rubygems'
# place all development, system_test, etc dependencies here

def location_for(place, fake_version = nil)
  if place =~ /^(git:[^#]*)#(.*)/
    [fake_version, { :git => $1, :branch => $2, :require => false }].compact
  elsif place =~ /^file:\/\/(.*)/
    ['>= 0', { :path => File.expand_path($1), :require => false }]
  else
    [place, { :require => false }]
  end
end

# unit tests: --without system_tests development
gem 'rspec'
gem 'rake'

group :system_tests do
end

group :development do
  gem 'bundler' # bundler rake tasks
  gem 'rubocop', '~> 0.49.1', require: false # used in tests. pinned
  gem 'simplecov'
  #Documentation dependencies
  gem 'yard'                 ,'~> 0'
  gem 'markdown'             ,'~> 0'
end

local_gemfile = "#{__FILE__}.local"
if File.exists? local_gemfile
  eval(File.read(local_gemfile), binding)
end

user_gemfile = File.join(Dir.home,'.Gemfile')
if File.exists? user_gemfile
  eval(File.read(user_gemfile), binding)
end
