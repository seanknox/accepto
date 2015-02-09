describe HerokuClient do
  subject { described_class.new }
  let(:app_setup) { instance_double(PlatformAPI::AppSetup) }
  let(:app) { instance_double(PlatformAPI::App) }
  let(:config_var) { instance_double(PlatformAPI::ConfigVar) }
  let(:app_name) { 'app-name'}
  let(:app_json_schema_data) do
    {
      source_blob: {
        url: 'tarball-url',
      },
      app: {
        name: app_name,
      },
      overrides: {
        env: 'env',
      }
    }
  end
  let(:source_app_name) { 'test-source-app' }
  let(:env) { { 'SOURCE_APP_FOR_CONFIG_VARS' => source_app_name } }

  before do
    stub_const('ENV', env)
  end

  specify '#create_app' do
    allow(subject).to receive(:app_setup).and_return(app_setup)
    expect(app_setup).to receive(:create).with(app_json_schema_data)
    subject.create_app(app_json_schema_data)
  end

  specify '#delete_app' do
    allow(subject).to receive(:app).and_return(app)
    expect(app).to receive(:delete).with(app_name)
    subject.delete_app(app_name)
  end

  specify '#source_app_config_vars' do
    allow(subject).to receive(:config_var).and_return(config_var)
    expect(config_var).to receive(:info).with(source_app_name)
    subject.source_app_config_vars
  end
end
