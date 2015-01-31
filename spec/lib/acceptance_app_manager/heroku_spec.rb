require 'spec_helper'

describe AcceptanceAppManager::Heroku do
  subject do
    described_class.new(
      app_name: app_name,
      tarball_url: tarball_url
    )
  end
  let(:app_name) { 'fake-app-name' }
  let(:tarball_url) { 'example.com/tarball.gz' }
  let(:heroku_api_client) do
    instance_double(AcceptanceAppManager::PlatformApiFacade)
  end
  let(:mailtrap_config_vars) do
    {
      'MAILTRAP_API_TOKEN' =>  'mailtrap_api_token',
      'MAILTRAP_PASSWORD'  =>  'mailtrap_password',
      'MAILTRAP_USERNAME'  =>  'mailtrap_username',
    }
  end
  let(:source_app_config_vars) do
    {
      'GITHUB_PROJECT'           =>  'dabohealth/iris',
      'HEROKU_APP_PREFIX'        =>  'iris-acceptance',
    }.merge(mailtrap_config_vars)
  end

  before do
    allow(AcceptanceAppManager::PlatformApiFacade).to receive(:new)
      .with(app_name).and_return(heroku_api_client)
  end

  describe '#create' do
    let(:source_app_name) { 'dabo-iris-integration' }
    let(:env) { { 'SOURCE_APP_FOR_CONFIG_VALUES' => 'dabo-iris-integration' } }
    before do
      allow(heroku_api_client).to receive(:source_app_config_vars)
        .with(source_app_name).and_return(source_app_config_vars)
      stub_const('ENV', env)
    end

    it 'calls create on Heroku app setup' do
      expect(heroku_api_client).to receive(
        :create
      ).with(
        source_blob: {
          url: tarball_url
        },
        app: {
          name: app_name
        },
        overrides: {
          env: mailtrap_config_vars
        }
      )
      subject.create
    end
  end

  describe '#destroy' do
    it 'calls delete on the Heroku app' do
      expect(heroku_api_client).to receive(:delete)
      subject.delete
    end
  end
end
