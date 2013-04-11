require "rubygems"
require "bundler/setup"

require "simplecov"
SimpleCov.start do
  add_filter "spec"
  add_filter "test_app"
  add_filter "vendor"
end

$: << File.join(File.dirname(__FILE__), "..", "lib")

ENV["RAILS_ENV"] ||= "test"
require "#{File.dirname(__FILE__)}/../test_app/config/environment"
require "rspec/rails"
require "rspec/autorun"

RSpec.configure do |config|
  config.use_transactional_fixtures = true
end
