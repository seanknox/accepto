require 'spec_helper'

describe AcceptanceAppManager::PullRequest do
  let(:title) { 'Test me' }

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

      before do
        allow(AcceptanceAppManager::Manager).to receive(
          :new
        ).and_return(manager)
      end

      it 'calls Manager.update' do
        expect(manager).to receive(:update)
        described_class.call(params)
      end
    end

    context 'action == closed' do
      let(:action) { 'closed' }

      before do
        allow(AcceptanceAppManager::Manager).to receive(
          :new
        ).and_return(manager)
      end

      it 'calls Manager.destroy' do
        expect(manager).to receive(:destroy)
        described_class.call(params)
      end
    end

    context 'action == reopened' do
      let(:action) { 'reopened' }

      before do
        allow(AcceptanceAppManager::Manager).to receive(
          :new
        ).and_return(manager)
      end

      it 'calls Manager.create' do
        expect(manager).to receive(:create)
        described_class.call(params)
      end
    end

    context 'action == opened' do
      let(:action) { 'opened' }

      before do
        allow(AcceptanceAppManager::Manager).to receive(
          :new
        ).and_return(manager)
      end

      it 'calls Manager.create' do
        expect(manager).to receive(:create)
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
