post '/hooks' do
  params = JSON.parse(request.env['rack.input'].read)
  AcceptanceAppManager::PullRequest.call(params)
  'Got it, thanks!'
end
