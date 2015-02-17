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
    config_var.info(ENV.fetch('SOURCE_APP_FOR_CONFIG_VARS'))
  end

  def collaborator_resource
    client.collaborator
  end

  private

  def app
    client.app
  end

  def app_setup
    client.app_setup
  end

  def config_var
    client.config_var
  end

  def client
    @client ||= PlatformAPI.connect(ENV.fetch('HEROKU_API_KEY'))
  end
end
