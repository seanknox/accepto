RSpec.describe PullRequest::Opened, :vcr do
  let(:expected_result) do
    {
      heroku_status: 'pending',
      collaborator_emails: collaborator_emails,
      github_comment_url: 'https://github.com/some-fancy-comment',
    }
  end

  let(:collaborator_emails) do
    [
      'user@dabohealth.com',
      'another-user@dabohealth.com'
    ]
  end

  it_behaves_like 'a pull request action'
end
