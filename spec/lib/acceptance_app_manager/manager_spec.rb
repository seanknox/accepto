require 'spec_helper'

describe AcceptanceAppManager::Manager do
  subject { described_class.new(params) }
  let(:heroku) { instance_double(AcceptanceAppManager::Heroku) }
  let(:pr_number) { '1' }
  let(:app_created_comment) { "Test URL: #{app_url}" }
  let(:app_destroyed_comment) { 'Test app deleted!' }
  let(:branch_name) { '123456' }
  let(:params) do
    {
      pr_number: pr_number,
      branch_name: branch_name
    }
  end
  let(:app_name) { 'my-app-pr-1' }
  let(:app_url) { 'https://my-app-pr-1.herokuapp.com' }
  let(:tarball_url) { 'https://tarball_url.com' }

  before do
    stub_const(
      'ENV',
      'HEROKU_APP_PREFIX' => 'my-app'
    )
    allow(AcceptanceAppManager::Heroku).to receive(:new).and_return(heroku)
    allow(heroku).to receive(:app_url).and_return(app_url)
    allow(AcceptanceAppManager::GithubTarball).to receive(:call).with(
      branch_name: branch_name
    )
  end

  describe '#create' do
    it 'calls Heroku.create and #comment_pr' do
      expect(heroku).to receive(:create)
      expect(AcceptanceAppManager::GithubComment).to receive(:call).with(
        comment: app_created_comment,
        pr_number: pr_number
      )
      subject.create
    end
  end

  describe '#update' do
    it 'calls Heroku.destroy and Heroku.create' do
      expect(heroku).to receive(:create)
      expect(heroku).to receive(:destroy)
      subject.update
    end
  end

  describe '#destroy' do
    it 'calls Heroku.destroy and #comment_pr' do
      expect(heroku).to receive(:destroy)
      expect(AcceptanceAppManager::GithubComment).to receive(:call).with(
        comment: app_destroyed_comment,
        pr_number: pr_number
      )
      subject.destroy
    end
  end
end
