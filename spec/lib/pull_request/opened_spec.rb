RSpec.describe PullRequest::Opened, :vcr do
  let(:expected_result) do
    {
      heroku_status: 'pending',
      github_comment_url: 'https://github.com/some-fancy-comment',
      collaborator_result: [
        {
          'created_at' => '2015-01-06T23:50:02Z',
          'id' => 'resource-id',
          'updated_at' => '2015-01-06T23:50:02Z',
          'user' => {
            'id' => 'user-id',
            'email' => 'user@dabohealth.com'
          }
        },
        {
          'created_at' => '2015-02-17T00:06:48Z',
          'id' => 'another-resource-id',
          'updated_at' => '2015-02-17T00:06:48Z',
          'user' =>  {
            'id' => 'another-user-id',
            'email' => 'another-user@dabohealth.com'
          }
        }
      ]
    }
  end
  it_behaves_like 'a pull request action'
end
