require 'spec_helper'

describe AcceptanceAppManager::RespondToPullRequestEvent, :vcr do
  describe '#call' do
    let(:title) { 'App.json configuration for acceptance app manager' }
    let(:params) do
      {
        'action' => action,
        'pull_request' => {
          'title' => title,
          'number' => '74',
          'head' => {
            'ref' => 'chores/set-up-mailtrap-86957570'
          }
        }
      }
    end

    let(:env) do
      {
        'GITHUB_PERSONAL_TOKEN' => 'fake_token',
        'GITHUB_PROJECT' => 'dabohealth/iris',
        'GITHUB_USERNAME' => 'daboeng',
        'HEROKU_API_KEY' => 'fake_key',
        'HEROKU_APP_PREFIX' => 'iris-acceptance',
        'SOURCE_APP_FOR_CONFIG_VALUES' => 'dabo-iris-integration',
      }
    end

    before do
      stub_const('ENV', env)
    end

    context 'action == synchronize' do
      let(:action) { 'synchronize' }

      it 'calls Synchronize' do
        #TODO: Figure out why this isn't finding the app to delete
        expect(AcceptanceAppManager::PullRequest::Synchronize).to receive(:call)
        described_class.call(params)
      end
    end

    context 'action == closed' do
      let(:action) { 'closed' }

      it 'calls Closed' do
        #TODO: Figure out why this isn't making the network call
        expect(AcceptanceAppManager::PullRequest::Closed).to receive(:call)
        described_class.call(params)
      end
    end

    context 'action == reopened' do
      let(:action) { 'reopened' }

      it 'calls Reopened' do
        expect(AcceptanceAppManager::PullRequest::Reopened).to receive(:call)
        described_class.call(params)
      end
    end

    context 'action == opened' do
      let(:action) { 'opened' }

      it 'calls Opened' do
        expect(AcceptanceAppManager::PullRequest::Opened).to receive(:call)
        described_class.call(params)
      end
    end

    context 'title includes WIP' do
      let(:action) { 'opened' }
      let(:title) { 'WIP' }

      it 'returns' do
        described_class.call(params)
      end
    end

    context 'action we do not handle' do
      let(:action) { 'unassigned' }

      it 'returns' do
        described_class.call(params)
      end
    end
  end
end
