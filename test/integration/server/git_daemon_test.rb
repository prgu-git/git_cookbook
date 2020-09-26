# InSpec test for recipe git_cookbook::server

describe port(9418) do
  it { should be_listening }
end

describe service('git-daemon') do
  it { should be_enabled }
  it { should be_running }
end
