# Provides a simple interface (facade) to interact with PlatformAPI
module AcceptanceAppManager
  PlatformApiFacade = Struct.new(:app_name) do
    def create(app_json_schema_data)
      app_setup.create(app_json_schema_data)
    end

    def delete
      app.delete(app_name)
    end

    def app_url
      app.info(app_name).fetch('web_url')
    end

    def source_app_config_vars(source_app_name)
      config_var.info(source_app_name)
    end

    private

    def app_setup
      client.app_setup
    end

    def app
      client.app
    end

    def config_var
      client.config_var
    end

    def client
      @client ||= PlatformAPI.connect(ENV.fetch('HEROKU_API_KEY'))
    end
  end
end
