# Install newrelic php monitoring

unless node[:new_relic][:license_key].nil?

  include_recipe 'shlomo-newrelic'

  package 'newrelic-php5'

  execute "initialize newrelic PHP" do
    environment ({
      "NR_INSTALL_SILENT" => "true",
      "NR_INSTALL_KEY" => node[:new_relic][:license_key]
    })
    command "newrelic-install install"
  end
  
  # Some editions have the license key in an additional location
  execute "Update newrelic PHP license key" do
    command %Q{sed -i -e "s/newrelic.license = \"\"/newrelic.license=\"#{node[:new_relic][:license_key]}\"/" /etc/php5/conf.d/newrelic.ini }
    only_if { File.exists?("/etc/php5/conf.d/newrelic.ini") }
  end
end
