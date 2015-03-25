require 'sinatra'
require 'json'

module AcceptanceAppManager
  class DeployException < StandardError; end
end

Dir[File.join(File.dirname(__FILE__), 'lib/**/*.rb')].each { |f|require f }

post '/hooks' do
  begin
    params = JSON.parse(request.env.fetch('rack.input').read)
    RespondToPullRequestEvent.call(params)
    'Successfully responded to Pull Request!'
  rescue
    puts "Exception ! ! ! #{$!.message}" # Sinatra swallows errors
    raise
  end
end

get '/status/:app_setup_id' do
  heroku_client = HerokuClient.new
  content_type :json
  heroku_client.app_setup_status(params[:app_setup_id]).to_json
end
