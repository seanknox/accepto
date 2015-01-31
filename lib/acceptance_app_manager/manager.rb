module AcceptanceAppManager
  # This creates, updates or destroys Heroku apps triggered by
  # pull request events
  class Manager
    def initialize(params)
      @params = params
    end

    def create
      heroku.create
      comment_pr("Test URL: #{app_url}")
    end

    def update
      heroku.delete
      heroku.create
    end

    def destroy
      heroku.delete
      comment_pr('Test app deleted!')
    end

    private

    def heroku
      @heroku ||= AcceptanceAppManager::Heroku.new(
        app_name: app_name,
        tarball_url: tarball_url
      )
    end

    def app_name
      "#{ENV.fetch('HEROKU_APP_PREFIX')}-PR-#{pr_number}".downcase
    end

    def comment_pr(comment)
      AcceptanceAppManager::GithubComment.call(
        comment: comment,
        pr_number: pr_number
      )
    end

    def app_url
      heroku.app_url
    end

    def pr_number
      @params.fetch(:pr_number)
    end

    def tarball_url
      AcceptanceAppManager::GithubTarball.call(
        branch_name: branch_name
      )
    end

    def branch_name
      @params.fetch(:branch_name)
    end
  end
end
