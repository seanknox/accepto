# This is the entry point in Pull Request hook actions.
module AcceptanceAppManager
  # Parses the pull_request_action from the GitHub webhook params and calls the
  # appropiate class. E.g. An Opened pr_action will result in the Opened class
  # being called.
  RespondToPullRequestEvent = Struct.new(:options) do
    SUPPORTED_PR_ACTIONS = %w(
      synchronize
      opened
      reopened
      closed
    )

    def self.call(*args)
      new(*args).call
    end

    def call
      return if skip? || unsupported_pull_request_action?
      pr_class_name.public_send(
        :call,
        {
          pr_number: pr_number,
          platform_api_client: platform_api_client,
          app_name: app_name,
          branch_name: branch_name,
        }
      )
    end

    private

    def skip?
      pr_title.include?('wip')
    end

    def unsupported_pull_request_action?
      !SUPPORTED_PR_ACTIONS.include?(pull_request_action)
    end

    def pr_class_name
      Object.const_get(
        "AcceptanceAppManager::PullRequest::#{pull_request_action.capitalize}"
      )
    end

    def platform_api_client
      PlatformApiFacade.new
    end

    def app_name
      "#{ENV.fetch('HEROKU_APP_PREFIX')}-PR-#{pr_number}".downcase
    end

    def pull_request
      options.fetch('pull_request')
    end

    def branch_name
      pull_request.fetch('head').fetch('ref')
    end

    def pull_request_action
      options.fetch('action')
    end

    def pr_title
      pull_request.fetch('title').downcase
    end

    def pr_number
      pull_request.fetch('number')
    end
  end
end
