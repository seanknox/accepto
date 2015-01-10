require 'sinatra'
require 'json'
require 'platform-api'
require 'octokit'
require 'git'

module AcceptanceAppManager
  class DeployException < StandardError; end
end

require_relative 'acceptance_app_manager/manager'
require_relative 'acceptance_app_manager/github_comment'
require_relative 'acceptance_app_manager/github_tarball'
require_relative 'acceptance_app_manager/heroku'
require_relative 'acceptance_app_manager/pull_request'
require_relative 'acceptance_app_manager/web'
