RSpec.describe PullRequest::Opened, :vcr do
  let(:expected_result) do
    {
      heroku_status: 'pending',
      collaborator_emails: collaborator_emails,
      github_comment_url: 'https://github.com/some-fancy-comment',
      app_setup_id: '3792b923-2716-424a-9be0-02d32d6786fd',
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
