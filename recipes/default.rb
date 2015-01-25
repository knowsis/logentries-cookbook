Chef::Resource::Template.send(:include, Knowsis::Logging::LogEntries)

include_recipe "rsyslog"

service 'rsyslog' do
  supports [:start, :stop, :restart, :reload]
  action :nothing
end
   
template "/etc/rsyslog.d/10-nlogentries.conf" do
    source "logentries_rsyslog.conf.erb"
    owner "root"
    mode "644"
    helpers (Knowsis::Logging::LogEntries)    
    notifies :restart, 'service[rsyslog]', :delayed
end
