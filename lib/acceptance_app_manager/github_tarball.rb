module AcceptanceAppManager
  GithubTarball = Struct.new(:options) do
    def self.call(*args)
      new(*args).call
    end

    def call
      octokit.archive_link(ENV['GITHUB_PROJECT'], :ref => branch_name)
    end

    private

    def octokit
      @octokit_client ||= Octokit::Client.new(
        login: ENV['GITHUB_USERNAME'],
        password: ENV['GITHUB_PERSONAL_TOKEN']
      )
    end

    def branch_name
      options.fetch(:branch_name)
    end
  end
end
