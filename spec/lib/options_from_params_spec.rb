describe OptionsFromParams do
  describe '#call' do
    let(:action) { 'opened' }
    let(:pr_class_name) { "PullRequest::#{action.capitalize}" }
    let(:pr_number) { '74' }
    let(:app_name) { 'iris-acceptance-pr-74' }
    let(:branch_name) { 'chores/set-up-mailtrap-86957570' }
    let(:heroku_client) { instance_double(HerokuClient) }

    let(:params) do
      {
        'action' => action,
        'pull_request' => {
          'number' => pr_number,
          'head' => {
            'ref' => branch_name
          }
        }
      }
    end

    let(:env) do
      {
        'HEROKU_APP_PREFIX' => 'iris-acceptance',
      }
    end

    before do
      stub_const('ENV', env)
      allow(HerokuClient).to receive(:new).and_return(heroku_client)
    end

    it 'pretties up the params to pass to RespondIfRespondable' do
      expect(described_class.call(params)).to eq(
        pr_class: PullRequest::Opened,
        pr_class_options: {
          app_name: app_name,
          branch_name: branch_name,
          heroku_client: heroku_client,
          pr_number: pr_number,
        },
      )
    end
  end
end
