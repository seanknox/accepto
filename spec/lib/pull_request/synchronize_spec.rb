RSpec.describe PullRequest::Synchronize, :vcr do
  let(:pr_number) { '945434415664646545641' }
  let(:app_name) { 'some-app-name-pr-34857' }
  let(:branch_name) { 'test-branch' }
  let(:heroku_client) { double('Heroku Client') }

  it 'closes then re-opens the app' do
    expect(PullRequest::Closed).to receive(:call).ordered.with(
      pr_number: pr_number,
      heroku_client: heroku_client,
      app_name: app_name,
    )
    expect(PullRequest::Opened).to receive(:call).ordered.with(
      pr_number: pr_number,
      heroku_client: heroku_client,
      app_name: app_name,
      branch_name: branch_name,
    )
    described_class.call(
      pr_number: pr_number,
      heroku_client: heroku_client,
      app_name: app_name,
      branch_name: branch_name,
    )
  end
end
