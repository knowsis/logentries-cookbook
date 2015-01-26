Chef::Resource::Template.send(:include, Knowsis::Logging::LogEntries)

include_recipe "rsyslog"

service 'rsyslog' do
  supports [:start, :stop, :restart, :reload]
  action :nothing
end

template node[:logentries][:ssl_cert_location] do
    source "logentries_ssl_cert.erb"
    owner "root"
    mode "644"
end

   
template "/etc/rsyslog.d/10-logentries.conf" do
    source "logentries_rsyslog.conf.erb"
    owner "root"
    mode "644"
    helpers (Knowsis::Logging::LogEntries)    
    notifies :restart, 'service[rsyslog]', :delayed
end
