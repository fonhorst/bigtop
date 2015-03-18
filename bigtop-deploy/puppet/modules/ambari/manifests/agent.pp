class ambari::agent ($serverhostname) {

  include ambari::installation::install_agent

  Exec {
        path => ["/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/"] }

  file_line { 'ambari-agent-ini-hostname':
    ensure  => present,
    path    => '/etc/ambari-agent/conf/ambari-agent.ini',
    line    => "hostname=${serverhostname}", # server host name
    match   => 'hostname=*',
    require => Package[ambari-agent]
  }


  exec { 'ambari-agent-start':
    command => "service ambari-agent start",
    user    => root,
    require => [Package[ambari-agent], File_line[ambari-agent-ini-hostname]],
    onlyif  => 'service ambari-agent status | grep "not running"'
  }
}