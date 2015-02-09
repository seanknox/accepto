require './lib/respond_to_pull_request_event'

RSpec.describe RespondToPullRequestEvent do
  let(:pr_class) { double('pr_class') }
  let(:pr_title) { 'User can do something awesome' }
  let(:pr_action) { 'some action' }
  let(:pr_class_options) { { some: :options } }
  let(:params) do
    {
      'action' => pr_action,
      'pull_request' => {
        'title' => pr_title,
      },
    }
  end
  let(:options) do
    {
      pr_class: pr_class,
      pr_class_options: pr_class_options,
    }
  end

  before do
    allow(IsPrRespondable).to receive(:call).with(
      pr_title: pr_title,
      pr_action: pr_action,
    ).and_return(pr_respondable?)
    allow(OptionsFromParams).to receive(:call).with(params).and_return(options)
  end

  def call
    described_class.call(params)
  end

  context 'respondable' do
    let(:pr_respondable?) { true }

    specify do
      expect(pr_class).to receive(:call).with(pr_class_options)
      call
    end
  end

  context 'not responable' do
    let(:pr_respondable?) { false }
    specify do
      expect(pr_class).not_to receive(:call)
      call
    end
  end
end
