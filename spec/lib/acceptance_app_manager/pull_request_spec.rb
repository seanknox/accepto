require 'spec_helper'

describe AcceptanceAppManager::PullRequest do
  describe '#call' do
    let(:manager) { instance_double(AcceptanceAppManager::Manager) }
    let(:params) do
      {
        'action' => action,
        'pull_request' => {
          'title' => title,
          'number' => '1',
          'head' => {
            'ref' => 'my-pr-branch'
          }
        }
      }
    end

    context 'action == synchronize' do
      let(:action) { 'synchronize' }
      let(:title) { 'Test me' }

      before do
        allow(AcceptanceAppManager::Manager).to receive(
          :new
        ).and_return(manager)
      end

      it 'calls Manager.update' do
        allow(manager).to receive(:update)
        described_class.call(params)
      end
    end

    context 'action == close' do
      let(:action) { 'close' }
      let(:title) { 'Test me' }

      before do
        allow(AcceptanceAppManager::Manager).to receive(
          :new
        ).and_return(manager)
      end

      it 'calls Manager.update' do
        allow(manager).to receive(:destroy)
        described_class.call(params)
      end
    end

    context 'action == reopened' do
      let(:action) { 'reopened' }
      let(:title) { 'Test me' }

      before do
        allow(AcceptanceAppManager::Manager).to receive(
          :new
        ).and_return(manager)
      end

      it 'calls Manager.update' do
        allow(manager).to receive(:create)
        described_class.call(params)
      end
    end

    context 'action == opened' do
      let(:action) { 'opened' }
      let(:title) { 'Test me' }

      before do
        allow(AcceptanceAppManager::Manager).to receive(
          :new
        ).and_return(manager)
      end

      it 'calls Manager.update' do
        allow(manager).to receive(:create)
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
      let(:title) { 'Test me' }

      it 'returns' do
        described_class.call(params)
      end
    end
  end
end
