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
  let(:app_setup) { instance_double(PlatformAPI::AppSetup) }
  let(:app) { instance_double(PlatformAPI::App) }
  let(:mailtrap_api_token) { 'fake_mailtrap_api_token' }
  let(:mailtrap_password) { 'fake_mailtrap_password' }
  let(:mailtrap_username) { 'fake_mailtrap_username' }

  before do
    stub_const(
      'ENV',
      'HEROKU_API_KEY' => 'fakekey',
      'MAILTRAP_API_TOKEN' => :mailtrap_api_token,
      'MAILTRAP_PASSWORD' => :mailtrap_password,
      'MAILTRAP_USERNAME' => :mailtrap_username
    )
    allow(subject).to receive(:app_setup).and_return(app_setup)
    allow(subject).to receive(:app).and_return(app)
  end

  describe '#create' do
    it 'calls create on Heroku app setup' do
      expect(app_setup).to receive(
        :create
      ).with(
        source_blob: {
          url: tarball_url
        },
        app: {
          name: app_name
        },
        overrides: {
          env: { 'MAILTRAP_API_TOKEN': ENV.fetch('MAILTRAP_API_TOKEN'),
                 'MAILTRAP_PASSWORD': ENV.fetch('MAILTRAP_PASSWORD'),
                 'MAILTRAP_USERNAME': ENV.fetch('MAILTRAP_USERNAME')
               }
        }
      )

      subject.create
    end
  end

  describe '#destroy' do
    it 'calls delete on the Heroku app' do
      expect(app).to receive(:delete).with(app_name)
      subject.destroy
    end
  end
end
