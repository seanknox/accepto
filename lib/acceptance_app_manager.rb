require 'sinatra'
require 'json'
require 'platform-api'
require 'octokit'
require 'git'

module AcceptanceAppManager
  class DeployException < StandardError; end
end

Dir[File.join(File.dirname(__FILE__), '**/*.rb')].each { |f| require f }
