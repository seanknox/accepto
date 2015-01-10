module AcceptanceAppManager
  # This creates, updates or destroys Heroku apps triggered by
  # pull request events
  class Manager
    def initialize(params)
      @params = params
      @heroku = AcceptanceAppManager::Heroku.new(
        app_name: app_name,
        tarball_url: tarball_url
      )
    end

    def create
      @heroku.create
      comment_pr("Test URL: #{app_url}")
    end

    def update
      # TODO: Delete exisiting app and recreate it
    end

    def destroy
      @heroku.destroy
      comment_pr('Test app deleted!')
    end

    private

    def app_name
      "#{ENV['HEROKU_APP_PREFIX']}-PR-#{pr_number}".downcase
    end

    def comment_pr(comment)
      AcceptanceAppManager::GithubComment.call(
        comment: comment,
        pr_number: pr_number
      )
    end

    def app_url
      @heroku.client.app.info(app_name).fetch('web_url')
    end

    def pr_number
      @params.fetch(:pull_request).fetch(:number)
    end

    def tarball_url
      AcceptanceAppManager::GithubTarball.call(
        branch_name: branch_name
      )
    end

    def branch_name
      @params.fetch(:pull_request).fetch(:head).fetch(:ref)
    end
  end
end
