# Install newrelic php monitoring

unless node[:new_relic][:license_key].nil?

  include_recipe 'shlomo-newrelic'

  package 'newrelic-php5'

  execute "initialize newrelic" do
    environment ({
      "NR_INSTALL_SILENT" => "true",
      "NR_INSTALL_KEY" => node[:new_relic][:license_key]
    })
    command "newrelic-install install"
  end
end
