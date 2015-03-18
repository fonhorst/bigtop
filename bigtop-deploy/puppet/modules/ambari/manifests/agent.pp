class ambari::agent ($serverhostname) {

  include ambari::installation::install_agent

  file_line { 'ambari-agent-ini-hostname':
    ensure  => present,
    path    => '/etc/ambari-agent/conf/ambari-agent.ini',
    line    => "hostname=${serverhostname}", # server host name
    match   => 'hostname=*',
    require => Package[ambari-agent]
  }


  exec { 'ambari-agent-start':
    command => "ambari-agent start",
    user    => root,
    require => [Package[ambari-agent], File_line[ambari-agent-ini-hostname]],
    onlyif  => 'ambari-agent status | grep "not running"'
  }
}