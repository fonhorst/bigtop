class ambari::server () {

  include ambari::installation::install_server

  exec { 'ambari-setup':
    command => "ambari-server setup -s",
    user    => root,
    require => Package[ambari-server]
  }

  file { '/etc/ambari-server/conf/ambari.properties':
    content => template("ambari/ambari.properties"),
    require => Package[ambari-server]
  }

  service { 'ambari-server':
    ensure  => running,
    require => [Package[ambari-server], Exec[ambari-setup]],
    start   => Exec[ambari-server-start]
  }

  exec { 'ambari-server-start':
    command => "ambari-server start",
    require => Service[ambari-server],
    onlyif  => 'ambari-server status | grep "not running"'
  }
}