require 'spec_helper'

describe 'Github web hooks receiver' do
  it 'receives hook and inititates a pull request task accordingly' do
    params = { 'something' => 'ok' }
    expect(AcceptanceAppManager::PullRequest).to receive(:call).with(params)

    post '/hooks',
         params.to_json,
         'CONTENT_TYPE' => 'application/json'
  end
end
