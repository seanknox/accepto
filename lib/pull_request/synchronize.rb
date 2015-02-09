module PullRequest
  # Deletes an acceptance app and then re-creates it. There will be a comment
  # for the deletion and creation of the app.
  Synchronize = Struct.new(:options) do
    def self.call(*args)
      new(*args).call
    end

    def call
      Closed.call(
        pr_number: pr_number,
        heroku_client: heroku_client,
        app_name: app_name,
      )
      Opened.call(
        pr_number: pr_number,
        heroku_client: heroku_client,
        app_name: app_name,
        branch_name: branch_name,
      )
    end

    private

    def pr_number
      options.fetch(:pr_number)
    end

    def heroku_client
      options.fetch(:heroku_client)
    end

    def app_name
      options.fetch(:app_name)
    end

    def branch_name
      options.fetch(:branch_name)
    end
  end
end
