require 'dotenv'
Dotenv.load
require 'sinatra'
require 'json'
require 'platform-api'
require 'octokit'
require 'git'

module AcceptanceAppManager
  class DeployException < StandardError; end
end

require_relative 'acceptance_app_manager/respond_to_pull_request_event'
require_relative 'acceptance_app_manager/github_comment'
require_relative 'acceptance_app_manager/github_tarball'
require_relative 'acceptance_app_manager/get_app_schema_data'
require_relative 'acceptance_app_manager/web'
require_relative 'acceptance_app_manager/platform_api_facade'
require_relative 'acceptance_app_manager/pull_request/closed'
require_relative 'acceptance_app_manager/pull_request/synchronize'
require_relative 'acceptance_app_manager/pull_request/opened'
require_relative 'acceptance_app_manager/pull_request/reopened'
