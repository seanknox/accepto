# Uses PlatformAPI to create and destroy Heroku apps
module AcceptanceAppManager
  Heroku = Struct.new(:options) do
    def create
      platform_api_client.create(app_json_schema_data)
    end

    def delete
      platform_api_client.delete
    end

    def app_url
      platform_api_client.app_url
    end

    private

    def platform_api_client
      @client ||= PlatformApiFacade.new(app_name)
    end

    def source_app_config_vars
      @integration_config_vars ||= platform_api_client.source_app_config_vars(
        ENV.fetch('SOURCE_APP_FOR_CONFIG_VALUES')
      )
    end

    def mailtrap_config_vars
      mailtrap_keys = %w(
        MAILTRAP_API_TOKEN
        MAILTRAP_USERNAME
        MAILTRAP_PASSWORD
      )
      source_app_config_vars.select { |key, _| mailtrap_keys.include?(key) }
    end

    def app_json_schema_data
      {
        source_blob: {
          url: tarball_url,
        },
        app: {
          name: app_name,
        },
        overrides: {
          env: mailtrap_config_vars,
        }
      }
    end

    def tarball_url
      options.fetch(:tarball_url)
    end

    def app_name
      options.fetch(:app_name)
    end
  end
end
