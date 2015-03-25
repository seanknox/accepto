require 'platform-api'

# Provides a simple interface to the PlatformApi that is easy to use and test.
class HerokuClient
  def create_app(app_json_schema_data)
    app_setup.create(app_json_schema_data)
  end

  def delete_app(app_name)
    app.delete(app_name)
  end

  def source_app_config_vars
    config_var.info(source_app)
  end

  def add_collaborator(app_name, user_params)
    collaborator.create(app_name, user_params)
  end

  def source_app_collaborators
    collaborator.list(source_app)
  end

  def app_setup_status(app_setup_id)
    app_setup.info(app_setup_id)
  end

  private

  def app_setup
    client.app_setup
  end

  def app
    client.app
  end

  def collaborator
    client.collaborator
  end

  def config_var
    client.config_var
  end

  def client
    @client ||= PlatformAPI.connect(ENV.fetch('HEROKU_API_KEY'))
  end

  def source_app
    @source_app ||= ENV.fetch('SOURCE_APP_FOR_CONFIG_VARS')
  end
end
