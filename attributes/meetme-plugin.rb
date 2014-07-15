# Which plugins will be activated?
# The configuration for each activated plugin must be in a like-named node under [:new_relic][:meetme_plugin][:plugins]
default[:new_relic][:meetme_plugin][:activate_plugins] = [ 'apache_httpd', 'php_apc' ]

default[:new_relic][:meetme_plugin][:plugins][:apache_httpd][:scheme] = 'http'
default[:new_relic][:meetme_plugin][:plugins][:apache_httpd][:host] = 'localhost'
default[:new_relic][:meetme_plugin][:plugins][:apache_httpd][:verify_ssl_cert] = 'false'
default[:new_relic][:meetme_plugin][:plugins][:apache_httpd][:port] = '80'
default[:new_relic][:meetme_plugin][:plugins][:apache_httpd][:path] = '/server-status'

default[:new_relic][:meetme_plugin][:plugins][:php_apc][:scheme] = 'http'
default[:new_relic][:meetme_plugin][:plugins][:php_apc][:host] = 'localhost'
default[:new_relic][:meetme_plugin][:plugins][:php_apc][:verify_ssl_cert] = 'false'
default[:new_relic][:meetme_plugin][:plugins][:php_apc][:port] = '80'
default[:new_relic][:meetme_plugin][:plugins][:php_apc][:path] = '/apc-nrp.php'
