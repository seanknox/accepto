require 'spec_helper'

RSpec.describe AcceptanceAppManager::PullRequest::Opened, vcr: { record: :new_episodes } do
  it_behaves_like 'a pull request action'
end
