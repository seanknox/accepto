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
    'Got it, thanks!'
  rescue
    puts "Exception ! ! ! #{$!.message}" # Sinatra swallows errors
    raise
  end
end
