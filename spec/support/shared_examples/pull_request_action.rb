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

    let(:platform_api_client) { AcceptanceAppManager::PlatformApiFacade.new }

    it 'creates an app and comments on the PR' do
      described_class.call(args)
    end
  end
end
