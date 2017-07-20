Host <<| tag == 'puppetlabs' |>>

node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
  include role::classroom
  include profile::epel
}
