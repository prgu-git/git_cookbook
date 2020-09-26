# the default recipe is implied if only the cookbook name is provided
# effectively `include_recipe "git_cookbook::default"`
include_recipe 'git_cookbook'

# install the above `daemon_pkg`
package 'git-daemon-run'

# create our data directory
directory '/opt/git'

# setup the systemd unit (service) with the above `daemon_bin`, enable, and
# start it
systemd_unit 'git-daemon.service' do
  content <<-EOU.gsub(/^\s+/, '')
    [Unit]
    Description=Git Repositories Server Daemon
    Documentation=man:git-daemon(1)

    [Service]
    ExecStart=/usr/bin/git daemon \
    --reuseaddr \
    --base-path=/opt/git/ \
    /opt/git/

    [Install]
    WantedBy=getty.target
    DefaultInstance=tty1
    EOU

  action [ :create, :enable, :start ]
end
