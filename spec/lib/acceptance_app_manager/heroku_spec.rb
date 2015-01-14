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

  before do
    stub_const('ENV', 'HEROKU_API_KEY' => 'fakekey')
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
