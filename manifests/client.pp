class xymon::client (
  $server
) {
    package { 'xymon-client': }
    package { 'hobbit-plugins': ensure => present }

    service { 'hobbit-client':
      ensure    => running,
      require   => Package['xymon-client'],
    }

    $clienthostname = "${fqdn}"
    file { '/etc/default/hobbit-client':
        content => template('xymon/hobbit-client'),
        notify  => Service['hobbit-client'],
        require => Package['xymon-client'],
    }
}