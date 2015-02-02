module AcceptanceAppManager
  GetAppSchemaData = Struct.new(:options) do
    def self.call(*args)
      new(*args).call
    end

    def call
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

    def source_app_config_vars
      @integration_config_vars ||= platform_api_client.source_app_config_vars(
        ENV.fetch('SOURCE_APP_FOR_CONFIG_VALUES')
      )
    end

    def platform_api_client
      options.fetch(:platform_api_client)
    end

    def mailtrap_config_vars
      mailtrap_keys = %w(
        MAILTRAP_API_TOKEN
        MAILTRAP_USERNAME
        MAILTRAP_PASSWORD
      )
      source_app_config_vars.select { |key, _| mailtrap_keys.include?(key) }
    end

    def tarball_url
      AcceptanceAppManager::GithubTarball.call(
        branch_name: branch_name
      )
    end

    def app_name
      options.fetch(:app_name)
    end

    def branch_name
      options.fetch(:branch_name)
    end
  end
end
