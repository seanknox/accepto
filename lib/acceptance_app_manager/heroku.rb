# Uses PlatformAPI to create and destroy Heroku apps
module AcceptanceAppManager
  Heroku = Struct.new(:options) do
    def create
      client.post(heroku_app_setup_url, data: data)
    end

    def destroy
      client.app.delete(app_name)
    end

    def client
      @client ||= PlatformAPI.connect(
        api_key
      )
    end

    private

    def api_key
      ENV['HEROKU_API_KEY']
    end

    def data
      {
        source_blob: {
          url: tarball_url
        },
        app: {
          name: app_name
        }
      }
    end

    def tarball_url
      options.fetch(:tarball_url)
    end

    def app_name
      options.fetch(:app_name)
    end

    def heroku_app_setup_url
      'https://api.heroku.com/app-setups'
    end
  end
end
