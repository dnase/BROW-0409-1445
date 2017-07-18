class review (
  $user = 'review',
) {
  include review::motd
  $homedir = $user ? {
    'root'  => '/root',
    default => "/home/${user}"
  }
  user { $user:
    ensure     => present,
    managehome => true,
    home       => $homedir,
  }
  file { "${homedir}/.bashrc":
    ensure => file,
    owner  => $user,
    group  => $user,
    mode   => '0644',
  }
  service { 'puppet':
    ensure => stopped,
    enable => false,
  }
}
