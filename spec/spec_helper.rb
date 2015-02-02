require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'rubygems'
require 'rack/test'

require 'support/vcr_setup'
require_relative '../lib/acceptance_app_manager'

support_include_path = "#{Dir.pwd}/spec/support/**/*.rb"
Dir[support_include_path].each { |f| require f }
