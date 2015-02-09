require './lib/is_pr_respondable.rb'

RSpec.describe IsPrRespondable do
  subject do
    described_class.call(
      pr_title: pr_title,
      pr_action: pr_action,
    )
  end

  let(:pr_class) { double('pr_class') }
  let(:pr_title) { 'User can do something awesome' }
  let(:pr_action) { supported_pr_action }
  let(:supported_pr_action) { 'a_pr_action' }
  let(:pr_class_options) { { some: :options } }

  before do
    stub_const(
      "#{described_class.name}::SUPPORTED_PR_ACTIONS",
      [supported_pr_action],
    )
  end

  context 'action is supported and not a WIP' do
    it { is_expected.to be true }
  end

  context 'action is not supported' do
    let(:pr_action) { 'a non-supported action' }
    it { is_expected.to be false }
  end

  context 'pr is a WIP' do
    let(:pr_title) { 'a WiP pr' }
    it { is_expected.to be false }
  end
end
