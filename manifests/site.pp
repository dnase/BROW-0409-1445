Host <<| tag == 'puppetlabs' |>>

node 'drewbilee.puppetlabs.vm' {
  include role::blog
}

node default {
  include role::classroom
}
