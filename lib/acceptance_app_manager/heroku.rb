Heroku = Struct.new(:options) do
  def create
    client.post(heroku_app_setup_url, data: data)
  end

  def destroy
    client.app.delete(app_name)
  end

  private

  def client
    @heroku_client ||= PlatformAPI.connect(
      api_key,
      default_headers: default_headers
    )
  end

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

  def default_headers
    {
      'Content-Type': 'application/json',
      'Accept': 'application/vnd.heroku+json; version=3'
    }
  end
end
