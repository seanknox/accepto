require 'spec_helper'
require 'rack/test'
include Rack::Test::Methods

describe 'Github web hooks receiver' do
  it 'receives hook and inititates a pull request task accordingly' do
    params = { 'something' => 'ok' }
    expect(AcceptanceAppManager::RespondToPullRequestEvent)
      .to receive(:call).with(params)

    post '/hooks',
         params.to_json,
         'CONTENT_TYPE' => 'application/json'
  end
end
