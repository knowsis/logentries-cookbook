Chef::Resource::Template.send(:include, Knowsis::Logging::LogEntries)

include_recipe "rsyslog"

package 'rsyslog-gnutls' do
    action :install
end

service 'rsyslog' do
  supports [:start, :stop, :restart, :reload]
  action :nothing
end

directory node[:logentries][:ssl_cert_location] do
    owner "root"
    group "root"
    mode "0755"
    action :create
end

template "#{node[:logentries][:ssl_cert_location]}/logentries.all.crt" do
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
