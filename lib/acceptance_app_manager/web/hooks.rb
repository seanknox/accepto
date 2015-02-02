post '/hooks' do
  params = JSON.parse(request.env.fetch('rack.input').read)
  AcceptanceAppManager::RespondToPullRequestEvent.call(params)
  'Got it, thanks!'
end
