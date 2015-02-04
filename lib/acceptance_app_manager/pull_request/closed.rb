module AcceptanceAppManager
  module PullRequest
    # Deletes an heroku acceptance app and comments on the pr.
    Closed = Struct.new(:options) do
      def self.call(*args)
        new(*args).call
      end

      def call
        platform_api_client.delete_app(app_name)
        GithubComment.call(comment: 'Test app deleted!', pr_number: pr_number)
      end

      def platform_api_client
        options.fetch(:platform_api_client)
      end

      def app_name
        options.fetch(:app_name)
      end

      def pr_number
        options.fetch(:pr_number)
      end
    end
  end
end
