name             "shlomo-newrelic"
maintainer       "Shlomo Swidler"
maintainer_email "shlomo.swidler@orchestratus.com"
license          "MIT"
description      "Setup New Relic"
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          "0.2.0"

recipe "default", "Install and configure newrelic-sysmond"
recipe "php", "Install and configure newrelic-php5"
recipe "meetme-plugin", "Install and configure the MeetMe Plugin Agent"

supports "debian"
supports "ubuntu"
supports "redhat", ">= 5.0"
supports "centos", ">= 5.0"

depends "newrelic-sysmond", ">= 1.3.3"
