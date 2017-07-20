class nginx::params {
  case $facts['os']['family'] {
    'RedHat', 'Debian': {
      $package = 'nginx'
      $owner = 'root'
      $group = 'root'
      $docroot = '/var/www'
      $confdir = '/etc/nginx'
      $blockdir = '/etc/nginx/conf.d'
      $logdir = '/var/log/nginx'
      $service = 'nginx'
    }
    'windows': {
      $package = 'nginx-service'
      $owner = 'Administrator'
      $group = 'Administators'
      $docroot = 'C:/ProgramData/nginx/html'
      $confdir = 'C:/ProgramData/nginx/conf'
      $blockdir = 'C:/ProgramData/nginx/conf.d'
      $logdir = 'C:/ProgramData/nginx/logs'
      $service = 'nginx'
    }
  }
  $user = $facts['os']['family'] ? {
    'windows' => 'nobody',
    'Debian'  => 'www-data',
    default   => 'nginx',
  }
  $highperf = true
}
















