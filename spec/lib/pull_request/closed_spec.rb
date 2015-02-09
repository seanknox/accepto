RSpec.describe PullRequest::Closed, :vcr do
  let(:expected_result) do
    {
      heroku_id: 'a-fake-heroku-id',
      github_comment_url: 'https://github.com/dabohealth/iris/pull/comment',
    }
  end

  it_behaves_like 'a pull request action'
end
