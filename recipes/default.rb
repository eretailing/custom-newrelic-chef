unless node["new_relic"]["license_key"].empty?

  case node['platform']
  when "debian", "ubuntu"
    
    execute "add newrelic deb repository" do
      user 'root'
      group 'root'
      command <<-EOF
        echo 'deb http://apt.newrelic.com/debian/ newrelic non-free' > /etc/apt/sources.list.d/newrelic.list
        wget -q -O - https://download.newrelic.com/548C16BF.gpg | apt-key add -
        apt-get update
      EOF
      not_if do
        find = Mixlib::ShellOut.new("find /etc/apt/ -name '*.list' | xargs cat | grep  ^[[:space:]]*deb.*[[:space:]]newrelic[[:space:]] | grep -v deb-src").run_command
        find.exitstatus && find.stdout.length>1
      end
    end
    
  when "redhat", "centos", "amazon", "scientific"

    # from the original cookbook - not directly supported here
    include_recipe "newrelic-sysmond"
    
  end
  
  package "newrelic-sysmond"

  template "/etc/newrelic/nrsysmond.cfg" do
    source "nrsysmond.cfg.erb"
    owner "root"
    group "newrelic"
    mode 0640
    notifies :restart, "service[newrelic-sysmond]"
  end

  service "newrelic-sysmond" do
    action [:enable, :start]
  end

end
