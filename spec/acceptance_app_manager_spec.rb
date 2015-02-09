require 'rack/test'

describe 'Github web hooks receiver', :vcr do
  include Rack::Test::Methods

  let(:params) do
    {
      action: 'opened',
      pull_request: {
        number: '92',
        head: {
          ref: 'test-branch-please-ignore',
        },
        title: 'Killer Feature',
      }
    }
  end

  it 'receives hook and inititates a pull request task accordingly' do
    stub_const('ENV',
      'GITHUB_PERSONAL_TOKEN' => 'fake-github-token',
      'GITHUB_PROJECT' => 'dabohealth/iris',
      'GITHUB_USERNAME' => 'daboeng',
      'HEROKU_API_KEY' => 'fake-heroku-api-key',
      'HEROKU_APP_PREFIX' => 'iris-acceptance',
      'SOURCE_APP_FOR_CONFIG_VARS' => 'dabo-iris-integration',
    )
    post '/hooks',
         params.to_json,
         'CONTENT_TYPE' => 'application/json'
  end
end
