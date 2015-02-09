module PullRequest
  # Deletes an heroku acceptance app and comments on the pr.
  Closed = Struct.new(:options) do
    def self.call(*args)
      new(*args).call
    end

    def call
      heroku_result = heroku_client.delete_app(app_name)
      github_result = GithubComment.call(
        comment: 'Test app deleted!',
        pr_number: pr_number,
      )
      {
        heroku_id: heroku_result.fetch('id'),
        github_comment_url: github_result.html_url,
      }
    end

    def heroku_client
      options.fetch(:heroku_client)
    end

    def app_name
      options.fetch(:app_name)
    end

    def pr_number
      options.fetch(:pr_number)
    end
  end
end
