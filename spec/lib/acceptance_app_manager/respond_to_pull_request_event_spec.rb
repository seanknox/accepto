require 'spec_helper'

describe AcceptanceAppManager::RespondToPullRequestEvent do
  describe '#call' do
    let(:title) { 'App.json configuration for acceptance app manager' }
    let(:pr_number) { '74' }
    let(:app_name) { 'iris-acceptance-pr-74' }
    let(:branch_name) { 'chores/set-up-mailtrap-86957570' }
    let(:platform_api_client) do
      instance_double(AcceptanceAppManager::PlatformApiFacade)
    end

    let(:params) do
      {
        'action' => action,
        'pull_request' => {
          'title' => title,
          'number' => pr_number,
          'head' => {
            'ref' => branch_name
          }
        }
      }
    end

    let(:env) do
      {
        'GITHUB_PERSONAL_TOKEN' => 'fake-token',
        'GITHUB_PROJECT' => 'dabohealth/iris',
        'GITHUB_USERNAME' => 'daboeng',
        'HEROKU_API_KEY' => 'fake-key',
        'HEROKU_APP_PREFIX' => 'iris-acceptance',
        'SOURCE_APP_FOR_CONFIG_VALUES' => 'dabo-iris-integration',
      }
    end

    let(:args) do
      {
        pr_number: pr_number,
        platform_api_client: platform_api_client,
        app_name: app_name,
        branch_name: branch_name,
      }
    end

    shared_examples 'a pull request action' do
      let(:pull_request_class_name) do
        Object.const_get(
          "AcceptanceAppManager::PullRequest::#{action.capitalize}"
        )
      end

      it 'calls the appropiate class' do
        allow(AcceptanceAppManager::PlatformApiFacade).to receive(:new).
          and_return(platform_api_client)
        expect(pull_request_class_name).to receive(:call).with(args)
        described_class.call(params)
      end
    end

    before do
      stub_const('ENV', env)
    end

    context 'when the action is synchronize' do
      let(:action) { 'synchronize' }
      it_behaves_like 'a pull request action'
    end

    context 'action == closed' do
      let(:action) { 'closed' }
      it_behaves_like 'a pull request action'
    end

    context 'action == reopened' do
      let(:action) { 'reopened' }
      it_behaves_like 'a pull request action'
    end

    context 'action == opened' do
      let(:action) { 'opened' }
      it_behaves_like 'a pull request action'
    end

    context 'title includes WIP' do
      let(:action) { 'opened' }
      let(:title) { 'WIP' }

      it 'does nothing' do
        expect(described_class.call(params)).to eq(nil)
      end
    end

    context 'action we do not handle' do
      let(:action) { 'unassigned' }

      it 'it does nothing' do
        expect(described_class.call(params)).to eq(nil)
      end
    end
  end
end
