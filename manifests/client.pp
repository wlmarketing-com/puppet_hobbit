class xymon::client (
  $server
) {
    package { 'xymon-client': }
    package { 'hobbit-plugins': ensure => present }

    service { 'hobbit-client':
      ensure    => running,
      require   => Package['xymon-client'],
    }

    $server = extlookup('hobbit_server','x')
    $clienthostname = "${fqdn}"
    file { '/etc/sysconfig/hobbit-client':
        content => template('xymon/hobbit-client'),
        notify  => Service['hobbit-client'],
        require => Package['xymon-client'],
    }
}