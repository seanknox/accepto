GithubComment = Struct.new(:options) do
  def self.call(*args)
    new(*args).call
  end

  def call
    octokit.add_comment(ENV['GITHUB_PROJECT'], pr_number, comment)
  end

  private

  def octokit
    @octokit_client ||= Octokit::Client.new(
      login: ENV['GITHUB_USERNAME'],
      password: ENV['GITHUB_PERSONAL_TOKEN']
    )
  end

  def pr_number
    options.fetch(:pr_number)
  end

  def comment
    options.fetch(:comment)
  end
end
