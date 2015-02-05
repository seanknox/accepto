RSpec.shared_examples 'a pull request action' do
  describe '#call' do
    let(:args) do
      {
        pr_number: '74',
        platform_api_client: platform_api_client,
        app_name: 'iris-acceptance-pr-74',
        branch_name: 'chores/set-up-mailtrap-86957570'
      }
    end
    let(:env) do
      {
        'HEROKU_API_KEY' => 'heroku-api-key',
        'GITHUB_USERNAME' => 'daboeng',
        'GITHUB_PERSONAL_TOKEN' => 'github-personal-token',
        'GITHUB_PROJECT' => 'dabohealth/iris',
        'SOURCE_APP_FOR_CONFIG_VALUES' => 'dabo-iris-integration'
      }
    end
    let(:platform_api_client) { AcceptanceAppManager::PlatformApiFacade.new }

    before do
      stub_const('ENV', env)
    end

    it 'creates an app and comments on the PR' do
      described_class.call(args)
    end
  end
end
