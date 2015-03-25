module PullRequest
  # Creates a heroku acceptance app and comments on the Github PR
  # with a link to the app.
  Opened = Struct.new(:options) do
    def self.call(*args)
      new(*args).call
    end

    def call
      {
        heroku_status: heroku_app.fetch('status'),
        collaborator_emails: add_collaborators,
        github_comment_url: add_github_comment.to_h.fetch(:html_url),
        app_setup_id: app_setup_id,
      }
    end

    private

    def heroku_app
      @heroku_app ||= heroku_client.create_app(app_schema_data)
    end

    def add_collaborators
      AddHerokuCollaborators.call(
        heroku_client: heroku_client,
        app_name: app_name,
      )
    end

    def add_github_comment
      GithubComment.call(
        comment: comment,
        pr_number: pr_number,
      )
    end

    def app_setup_id
      heroku_app.fetch('id')
    end

    def app_schema_data
      GetAppSchemaData.call(
        branch_name: branch_name,
        app_name: app_name,
        source_app_env: heroku_client.source_app_config_vars,
      )
    end

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
      "Test URL: https://#{app_name}.herokuapp.com \n" \
      "App setup status: #{status_url}"
    end

    def pr_number
      options.fetch(:pr_number)
    end

    def status_url
      "#{ENV.fetch('APP_URL')}/status/#{app_setup_id}"
    end
  end
end
