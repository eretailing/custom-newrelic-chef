# Installs the MeetMe NewRelic plugin
# See https://github.com/MeetMe/newrelic-plugin-agent

package "python-pip"

execute "pip install newrelic-plugin-agent"

if node[:new_relic][:meetme_plugin][:activate_plugins] && node[:new_relic][:meetme_plugin][:activate_plugins].size > 0
  config_map = node[:new_relic][:meetme_plugin][:plugins]
  template "/etc/newrelic/newrelic-plugin-agent.cfg" do
    source "newrelic-plugin-agent.cfg.erb"
    owner "root"
    group "root"
    mode "0600"
    variables config_map
  end
  
  if node[:new_relic][:meetme_plugin][:activate_plugins].include?('php_apc') 
    sheller = Mixlib::ShellOut.new("fgrep DocumentRoot /etc/apache2/sites-enabled/000-default | sed -e 's/[^/]*//'")
    sheller.run_command
    default_site_docroot = sheller.stdout.strip
    if default_site_docroot.length>2
      # put APC file in place
      # put it in the DocumentRoot of the default vhost
      execute "place newrelic-plugin-agent APC script into default vhost document root #{default_site_docroot}" do
        command "cp /opt/newrelic-plugin-agent/apc-nrp.php #{default_site_docroot}"
        not_if { File.exists?("#{default_site_docroot}/apc-nrp.php") }
      end
    end
  end  
  
  service "newrelic-plugin-agent" do
    supports :start => true, :stop => true, :status => true, :restart => true
    action :nothing
  end 

  execute "install newrelic-plugin-agent init script" do
    command %q@cp /opt/newrelic-plugin-agent/newrelic-plugin-agent.deb /etc/init.d/newrelic-plugin-agent ;
      chmod 755 /etc/init.d/newrelic-plugin-agent ;
      sed -i -e "s/^PIDDIR_OWNER=$/PIDDIR_OWNER=\"newrelic\"/" /etc/init.d/newrelic-plugin-agent ;
      chown root:root /etc/init.d/newrelic-plugin-agent ;
      update-rc.d newrelic-plugin-agent defaults@
    not_if { File.exists?("/etc/init.d/newrelic-plugin-agent") }
    notifies :enable, "service[newrelic-plugin-agent]"
    notifies :start, "service[newrelic-plugin-agent]"
  end
 
  logrotate_file="/etc/logrotate.d/newrelic-plugin-agent"
  file "#{logrotate_file}"  do
    owner "root"
    group "root"
    mode 0640
    action :create
    # newline is important
    content "/var/log/newrelic/newrelic-plugin-agent.log {
    rotate 7
    daily
    missingok
    notifempty
    sharedscripts
    copytruncate
    compress
}
"
    end 
end
