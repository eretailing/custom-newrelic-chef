package 'ruby1.9.3' # for the upcoming newrelic plugin. It's written in Ruby.
# the upcoming newrelic recipe relies on the 'newrelic' user being able to install system gems via sudo.
# make that happen without asking for a password
file "/etc/sudoers.d/newrelic-bundle-install" do
  owner "root"
  group "root"
  mode 0440
  action :create
  content "newrelic ALL=(root)NOPASSWD:bundle install"
end
include_recipe 'newrelic_plugins::aws_cloudwatch'
