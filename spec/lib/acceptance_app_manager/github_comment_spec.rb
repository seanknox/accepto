require 'spec_helper'

describe AcceptanceAppManager::GithubComment do
  let(:comment) { 'yo!' }
  let(:pr_number) { 1 }
  let(:project) { 'my-project' }

  before do
    stub_const('ENV', 'GITHUB_PROJECT' => project)
  end

  it 'adds a comment' do
    expect_any_instance_of(Octokit::Client).to receive(:add_comment).with(
      project,
      pr_number,
      comment
    )

    described_class.call(
      comment: comment,
      pr_number: pr_number
    )
  end
end
