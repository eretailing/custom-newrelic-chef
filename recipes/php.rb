# Install newrelic php monitoring

unless node[:new_relic][:license_key].nil?

  include_recipe 'shlomo-newrelic::default'

  package 'newrelic-php5' do
    notifies :run, "execute[initialize newrelic]", :immediately
  end

  execute "initialize newrelic" do
    environment {
      "NR_INSTALL_SILENT" => "true",
      "NR_INSTALL_KEY" => node[:new_relic][:license_key]
    }
    command "newrelic-install install"
    action :nothing
  end
end
