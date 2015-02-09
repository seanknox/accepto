OptionsFromParams = Struct.new(:params) do
  def self.call(*args)
    new(*args).call
  end

  def call
    {
      pr_class: pr_class,
      pr_class_options: pr_class_options,
    }
  end

  private

  def pr_class
    PullRequest.const_get(pr_action.capitalize)
  end

  def pr_action
    params.fetch('action')
  end

  def pr_class_options
    {
      app_name: app_name,
      branch_name: branch_name,
      heroku_client: heroku_client,
      pr_number: pr_number,
    }
  end

  def app_name
    "#{ENV.fetch('HEROKU_APP_PREFIX')}-pr-#{pr_number}"
  end

  def pr_number
    pull_request.fetch('number')
  end

  def pull_request
    params.fetch('pull_request')
  end

  def branch_name
    pull_request.fetch('head').fetch('ref')
  end

  def heroku_client
    HerokuClient.new
  end
end
