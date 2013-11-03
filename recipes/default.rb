chef_gem "chef-rewind"
require 'chef/rewind'

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

    include_recipe "chef-newrelic-sysmond::default"
    
    unwind "apt_repository[newrelic]"
    
  when "redhat", "centos", "amazon", "scientific"

    include_recipe "chef-newrelic-sysmond::default"
    
  end

end
