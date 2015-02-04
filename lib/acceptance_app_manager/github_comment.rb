module AcceptanceAppManager
  # Comments on a pull request.
  GithubComment = Struct.new(:options) do
    def self.call(*args)
      new(*args).call
    end

    def call
      octokit_client.add_comment(github_project, pr_number, comment)
    end

    private

    def octokit_client
      @octokit_client ||= Octokit::Client.new(
        login: ENV.fetch('GITHUB_USERNAME'),
        password: ENV.fetch('GITHUB_PERSONAL_TOKEN')
      )
    end

    def github_project
      ENV.fetch('GITHUB_PROJECT')
    end

    def pr_number
      options.fetch(:pr_number)
    end

    def comment
      options.fetch(:comment)
    end
  end
end
