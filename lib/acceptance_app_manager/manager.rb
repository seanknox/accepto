class AcceptanceAppManager::Manager
  def initialize(params)
    @params = params
    @heroku = AcceptanceAppManager::Heroku.new(
      app_name: app_name,
      tarball_url: tarball_url
    )
  end

  def create
    @heroku.create(app_name, tarball_url)
    comment_pr
  end

  def update
  end

  def destroy
    @heroku.destroy
  end

  private

  def app_name
    "#{ENV['APP_PREFIX']}-PR-#{pr_number}".downcase
  end

  def comment_pr
    AcceptanceAppManager::GithubComment.new(
      comment: "Test URL #{app_url}",
      pr_number: pr_number
    )
  end

  def app_url
    @heroku.client.app.info(app_name).fetch(:web_url)
  end

  def pr_number
    @params.fetch(:pull_request).fetch(:number)
  end

  def tarball_url
    AcceptanceAppManager::GithubTarball.new(
      branch_name: branch_name
    )
  end

  def branch_name
    @params.fetch(:pull_request).fetch(:head).fetch(:ref)
  end
end
