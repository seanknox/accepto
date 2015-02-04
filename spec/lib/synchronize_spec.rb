require 'spec_helper'

RSpec.describe AcceptanceAppManager::PullRequest::Synchronize, :vcr do
  it_behaves_like 'a pull request action'
end
