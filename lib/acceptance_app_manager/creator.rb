class AcceptanceAppManager::Creator
  def initialize(params)
    @params = params
    @heroku = AcceptanceAppManager::Heroku.new
    @github = AcceptanceAppManager::GitHub.new
  end
end
