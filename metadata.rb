name             "custom-newrelic-chef"
maintainer       "Shlomo Swidler"
maintainer_email "shlomo.swidler@orchestratus.com"
license          "MIT"
description      "Setup New Relic"
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          "0.2.0"

recipe "default", "Install and configure newrelic-sysmond"
recipe "meetme-plugin", "Install and configure the MeetMe Plugin Agent"
recipe "aws", "Install and configure NewRelic's AWS CloudWatch plugin"

supports "debian"
supports "ubuntu"
supports "redhat", ">= 5.0"
supports "centos", ">= 5.0"

depends "newrelic-sysmond", ">= 1.3.3"
depends 'newrelic_plugins', '>= 1.0.1'
