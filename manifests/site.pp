Host <<| tag == 'puppetlabs' |>>

node default {
  include role::classroom
  include profile::epel
}
