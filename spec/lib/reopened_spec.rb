require 'spec_helper'

RSpec.describe AcceptanceAppManager::PullRequest::Reopened, :vcr do
  it_behaves_like 'a pull request action'

  it 'aliases the Opened class' do
    expect(described_class).to eq(AcceptanceAppManager::PullRequest::Opened)
  end
end
