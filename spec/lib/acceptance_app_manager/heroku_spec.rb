require 'spec_helper'
require 'pry'

describe AcceptanceAppManager::Heroku do
  let(:app_name) { 'fake-app-name' }
  let(:tarball_url) { 'example.com/tarball.gz' }
  let(:heroku) do
    described_class.new(
      app_name: app_name,
      tarball_url: tarball_url
    )
  end

  describe '#create' do
    before do
      stub_const('ENV', 'HEROKU_API_KEY' => 'fakekey')
    end

    it 'creates an app on Heroku' do
      expect_any_instance_of(PlatformAPI::Client).to receive(:post).with(
        'https://api.heroku.com/app-setups',
        data: {
          source_blob: {
            url: tarball_url
          },
          app: {
            name: app_name
          }
        }
      )

      heroku.create
    end
  end

  describe '#destroy' do
    it 'calls delete on the Heroku client' do
      expect(heroku.client.app).to receive(:delete).with(app_name)
      heroku.destroy
    end
  end
end
