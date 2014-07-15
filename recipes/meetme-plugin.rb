# Installs the MeetMe NewRelic plugin
# See https://github.com/MeetMe/newrelic-plugin-agent

package "python-pip"

execute "pip install newrelic-plugin-agent"

if node[:new_relic][:meetme_plugin][:activate_plugins] && node[:new_relic][:meetme_plugin][:activate_plugins].is_a(Array) && node[:new_relic][:meetme_plugin][:activate_plugins].length > 0
  config_map = node[:new_relic][:meetme_plugin][:plugins]
  template "/etc/newrelic/newrelic-plugin-agent.cfg" do
    source "newrelic-plugin-agent.cfg.erb"
    owner "root"
    group "root"
    mode "0600"
    variables config_map
  end
  
  if node[:new_relic][:meetme_plugin][:plugins][:php_apc]
    # put APC file in place
    # put it in the DocumentRoot of the default vhost
    execute "place newrelic-plugin-agent APC script into default vhost document root" do
      command "docroot=$(fgrep DocumentRoot /etc/apache2/sites-enabled/000-default | sed -e 's/[^/]*//') ;
        cp /opt/newrelic-plugin-agent/apc-nrp.php $docroot"
    end
  end  
  
  service "newrelic-plugin-agent" do
    supports :start => true, :stop => true, :status => true, :restart => true
    action :nothing
  end 

  execute "install newrelic-plugin-agent init script" do
    command "cp /opt/newrelic-plugin-agent/newrelic-plugin-agent.deb /etc/init.d/newrelic-plugin-agent ;
      chmod 755 /etc/init.d/newrelic-plugin-agent ;
      chown root:root /etc/init.d/newrelic-plugin-agent ;
      update-rc.d newrelic-plugin-agent defaults"
    notifies :enable, "service[newrelic-plugin-agent]"
    notifies :start, "service[newrelic-plugin-agent]"
  end
  
end
