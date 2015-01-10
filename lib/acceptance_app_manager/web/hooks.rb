post '/hooks' do
  params = JSON.parse(request.env['rack.input'].read)
  AcceptanceAppManager::PullRequest.new(params)
  'Got it, thanks!'
end
