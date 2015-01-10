# This is the entry point in Pull Request hook actions.
module AcceptanceAppManager
  PullRequest = Struct.new(:options) do
    def self.call(*args)
      new(*args).call
    end

    def call
      return if skip?

      manager = AcceptanceAppManager::Manager.new(pull_request)

      case pull_request_action
      when 'synchronize' # new push against the PR (updating code, basically)
        manager.update
      when 'closed'
        manager.delete
      when 'reopened', 'opened'
        manager.create
      end
    end

    private

    def pull_request
      options.fetch(:pull_request)
    end

    def pull_request_action
      options.fetch(:action)
    end

    def skip?
      pr_title.include?('WIP')
    end

    def pr_title
      pull_request.fetch(:title).downcase
    end
  end
end
