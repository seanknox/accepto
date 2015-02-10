# Assembles the data needed to create an app using Heroku's app.json feature.
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
        env: {
          'APP_NAME': app_name,
          'MAILTRAP_API_TOKEN': source_app_env.fetch('MAILTRAP_API_TOKEN'),
          'MAILTRAP_USERNAME': source_app_env.fetch('MAILTRAP_USERNAME'),
          'MAILTRAP_PASSWORD': source_app_env.fetch('MAILTRAP_PASSWORD'),
        }
      }
    }
  end

  def source_app_env
    options.fetch(:source_app_env)
  end

  def tarball_url
    GithubTarballUrl.call(
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
