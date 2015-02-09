RSpec.shared_examples 'a pull request action' do
  describe '#call' do
    let(:args) do
      {
        pr_number: '92',
        heroku_client: heroku_client,
        app_name: 'iris-acceptance-pr-92',
        branch_name: 'test-branch-please-ignore'
      }
    end
    let(:env) do
      {
        'HEROKU_API_KEY' => 'fake-heroku-api-key',
        'GITHUB_USERNAME' => 'daboeng',
        'GITHUB_PERSONAL_TOKEN' => 'fake-github-token',
        'GITHUB_PROJECT' => 'dabohealth/iris',
        'SOURCE_APP_FOR_CONFIG_VARS' => 'dabo-iris-integration'
      }
    end
    let(:heroku_client) { HerokuClient.new }

    before do
      stub_const('ENV', env)
    end

    it 'responds to a pr action' do
      expect(described_class.call(args)).to eq expected_result
    end
  end
end
