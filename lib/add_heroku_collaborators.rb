AddHerokuCollaborators = Struct.new(:options) do
  def self.call(*args)
    new(*args).call
  end

  def call
    added_collaborators = []

    heroku_client.source_app_collaborators.each do |collaborator|
      result = heroku_client.add_collaborator(
        app_name,
        user_params(collaborator)
      )
      added_collaborators << result.to_h.fetch('user').fetch('email')
    end

    added_collaborators
  end

  private

  def user_params(collaborator)
    {
      'silent': true,
      'user': collaborator.to_h.fetch('user').fetch('email')
    }
  end

  def heroku_client
    options.fetch(:heroku_client)
  end

  def app_name
    options.fetch(:app_name)
  end
end
