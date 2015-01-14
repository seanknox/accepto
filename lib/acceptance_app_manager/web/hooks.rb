post '/hooks' do
  params = JSON.parse(request.env.fetch('rack.input').read)
  AcceptanceAppManager::PullRequest.call(params)
  'Got it, thanks!'
end
