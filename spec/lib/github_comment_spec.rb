require 'octokit'

describe GithubComment do
  subject do
    described_class.new(
      comment: comment,
      pr_number: pr_number
    )
  end
  let(:comment) { 'yo!' }
  let(:pr_number) { 1 }
  let(:project) { 'my-project' }
  let(:octokit_client) { instance_double(Octokit::Client) }

  before do
    stub_const(
      'ENV',
      'GITHUB_PROJECT' => project,
      'GITHUB_USERNAME' => 'octocat',
      'GITHUB_PERSONAL_TOKEN' => '1234badf3234'
    )
  end

  it 'adds a comment' do
    allow(subject).to receive(:octokit_client).and_return(octokit_client)
    expect(octokit_client).to receive(:add_comment).with(
      project,
      pr_number,
      comment
    )
    subject.call
  end
end
