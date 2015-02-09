RSpec.describe PullRequest::Reopened do
  it 'aliases the Opened class' do
    expect(described_class).to be PullRequest::Opened
  end
end
