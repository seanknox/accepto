module PullRequest
  # Creates a heroku acceptance app and comments on the Github PR
  # with a link to the app.
  Opened = Struct.new(:options) do
    def self.call(*args)
      new(*args).call
    end

    def call
      heroku_result = heroku_client.create_app(app_schema_data)
      github_result = GithubComment.call(comment: comment, pr_number: pr_number)
      {
        heroku_status: heroku_result.fetch('status'),
        github_comment_url: github_result.to_h.fetch(:html_url)
      }
    end

    private

    def app_schema_data
      GetAppSchemaData.call(
        branch_name: branch_name,
        app_name: app_name,
        source_app_env: heroku_client.source_app_config_vars,
      )
    end

    def branch_name
      options.fetch(:branch_name)
    end

    def app_name
      options.fetch(:app_name)
    end

    def heroku_client
      options.fetch(:heroku_client)
    end

    def comment
      "Test URL: https://#{app_name}.herokuapp.com"
    end

    def pr_number
      options.fetch(:pr_number)
    end
  end
end
