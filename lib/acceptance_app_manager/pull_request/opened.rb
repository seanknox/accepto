module AcceptanceAppManager
  module PullRequest
    # Creates a heroku acceptance app and comments on the Github PR
    # with a link to the app
    Opened = Struct.new(:options) do
      def self.call(*args)
        new(*args).call
      end

      def call
        platform_api_client.create_app(app_schema_data)
        GithubComment.call(comment: comment, pr_number: pr_number)
      end

      private

      def app_schema_data
        AcceptanceAppManager::GetAppSchemaData.call(
          branch_name: branch_name,
          app_name: app_name,
          platform_api_client: platform_api_client,
        )
      end

      def branch_name
        options.fetch(:branch_name)
      end

      def app_name
        options.fetch(:app_name)
      end

      def platform_api_client
        options.fetch(:platform_api_client)
      end

      def comment
        "Test URL: https://#{app_name}.herokuapp.com"
      end

      def pr_number
        options.fetch(:pr_number)
      end
    end
  end
end
