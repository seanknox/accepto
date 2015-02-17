AddHerokuCollaborators = Struct.new(:options) do
  def self.call(*args)
    new(*args).call
  end

  def call
    add_collaborators
  end

  private

  def add_collaborators
    collaborators_to_add.each do |collaborator|
      collaborator_resource.create(app_name, params(collaborator))
    end
  end

  def params(collaborator)
    {
      'silent': true,
      'user': collaborator.to_h.fetch('user').fetch('email')
    }
  end

  def collaborators_to_add
    collaborator_resource.list(
      ENV.fetch('SOURCE_APP_FOR_CONFIG_VARS')
    )
  end

  def collaborator_resource
    options.fetch(:collaborator_resource)
  end

  def app_name
    options.fetch(:app_name)
  end
end
