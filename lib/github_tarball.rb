# Fetches a temporary url for a specified branch which is used by Heroku's
# app.json feature.
GithubTarballUrl = Struct.new(:options) do
  def self.call(*args)
    new(*args).call
  end

  def call
    octokit_client.archive_link(github_project, ref: branch_name)
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

  def branch_name
    options.fetch(:branch_name)
  end
end
