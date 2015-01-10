require 'spec_helper'

describe AcceptanceAppManager::GithubTarball do
  let(:branch_name) { 'fake-branch-name' }
  let(:project) { 'my-project' }

  before do
    stub_const('ENV', 'GITHUB_PROJECT' => project)
  end

  it 'create an archive link for the Github tarball' do
    expect_any_instance_of(Octokit::Client).to receive(:archive_link).with(
      project,
      ref: branch_name
    )

    described_class.call(branch_name: branch_name)
  end
end
