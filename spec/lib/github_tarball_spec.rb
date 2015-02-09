describe GithubTarballUrl do
  subject do
    described_class.new(
      branch_name: branch_name
    )
  end
  let(:branch_name) { 'fake-branch-name' }
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

  it 'create an archive link for the Github tarball' do
    allow(subject).to receive(:octokit_client).and_return(octokit_client)
    expect(octokit_client).to receive(:archive_link).with(
      project,
      ref: branch_name
    )

    subject.call
  end
end
