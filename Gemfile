# frozen_string_literal: true

source 'https://rubygems.org'
require 'rubygems'
# place all development, system_test, etc dependencies here

def location_for(place, fake_version = nil)
  if place =~ /^(git:[^#]*)#(.*)/
    [fake_version, { git: Regexp.last_match(1), branch: Regexp.last_match(2),
                     require: false }].compact
  elsif place =~ %r{^file://(.*)}
    ['>= 0', { path: File.expand_path(Regexp.last_match(1)), require: false }]
  else
    [place, { require: false }]
  end
end

# lint/unit tests: --without system_tests development
gem 'rake'
gem 'rspec'
gem 'rubocop', '~> 0.49.1', require: false # used in tests. pinned
# Documentation dependencies
gem 'yard', '~> 0'

group :system_tests do
end

group :development do
  gem 'bundler' # bundler rake tasks
end

local_gemfile = "#{__FILE__}.local"
eval_gemfile(local_gemfile) if File.exist? local_gemfile

user_gemfile = File.join(Dir.home, '.Gemfile')
eval_gemfile(user_gemfile) if File.exist? user_gemfile

gemspec
