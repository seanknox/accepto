post '/hooks' do
  params = JSON.parse(request.env['rack.input'].read)
  logger.info '*** PARAMS ***'
  logger.info params
  AcceptanceAppManager::PullRequest.new.async.perform(params)
  'Got it, thanks!'
end
