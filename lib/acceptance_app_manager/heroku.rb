# Uses PlatformAPI to create and destroy Heroku apps
module AcceptanceAppManager
  Heroku = Struct.new(:options) do
    def create
      app_setup.create(data)
    end

    def destroy
      app.delete(app_name)
    end

    def app_url
      app.info(app_name).fetch('web_url')
    end

    private

    def app_setup
      client.app_setup
    end

    def app
      client.app
    end

    def client
      @client ||= PlatformAPI.connect(api_key)
    end

    def data
      {  source_blob: { url: tarball_url },
         app: { name: app_name },
         overrides: { env: {
           'MAILTRAP_API_TOKEN': ENV.fetch('MAILTRAP_API_TOKEN'),
           'MAILTRAP_PASSWORD': ENV.fetch('MAILTRAP_PASSWORD'),
           'MAILTRAP_USERNAME': ENV.fetch('MAILTRAP_USERNAME') } } }
    end

    def api_key
      ENV.fetch('HEROKU_API_KEY')
    end

    def tarball_url
      options.fetch(:tarball_url)
    end

    def app_name
      options.fetch(:app_name)
    end
  end
end
