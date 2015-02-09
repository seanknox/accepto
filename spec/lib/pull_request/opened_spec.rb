RSpec.describe PullRequest::Opened, :vcr do
  let(:expected_result) do
    {
      heroku_status: 'pending',
      github_comment_url: 'https://github.com/some-fancy-comment'
    }
  end

  it_behaves_like 'a pull request action'
end
