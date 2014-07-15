package 'ruby1.9.3' # for the upcoming newrelic plugin. It's written in Ruby.

# the upcoming newrelic recipe relies on the 'newrelic' user being able to install system gems via sudo.
# make that happen without asking for a password
temp_sudoers_file="/etc/sudoers.d/newrelic-bundle-install"
file "create #{temp_sudoers_file}"  do
  path temp_sudoers_file
  owner "root"
  group "root"
  mode 0440
  action :create
  # newline is important
  content "newrelic ALL=(root) NOPASSWD: ALL
"
end

include_recipe 'newrelic_plugins::aws_cloudwatch'

file "delete #{temp_sudoers_file}" do
  path temp_sudoers_file
  action :delete
end
