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
    variables ( 
        lazy{
            {"log_key" => get_log_key(node[:opsworks][:instance][:hostname], node[:opsworks][:stack][:name])}            
        }
    )
    notifies :restart, 'service[rsyslog]', :delayed
end
