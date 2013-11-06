name             "shlomo-newrelic"
maintainer       "Shlomo Swidler"
maintainer_email "shlomo.swidler@orchestratus.com"
license          "MIT"
description      "Setup New Relic"
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          "0.1.0"

recipe "newrelic-sysmond", "Install and configure newrelic-sysmond"
recipe "php", "Install and configure newrelic-php5"

supports "debian"
supports "ubuntu"
supports "redhat", ">= 5.0"
supports "centos", ">= 5.0"

depends "chef-newrelic-sysmond", "= 1.3.3"
