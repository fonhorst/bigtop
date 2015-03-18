class ambari::installation {

    class install_agent {
     Exec {
        path => ["/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/"] }

     # Ambari Repo
     exec { 'get-ambari-agent-repo':
        command => "wget http://public-repo-1.hortonworks.com/ambari/centos6/1.x/GA/ambari.repo",
        cwd     => '/etc/yum.repos.d/',
        creates => '/etc/yum.repos.d/ambari.repo',
        user    => root
     }

     # Ambari Agent
     package { 'ambari-agent':
        ensure  => present,
        require => Exec[get-ambari-agent-repo]
     }

    }

    class install_server {
        Exec {
        path => ["/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/"] }

        # Ambari Repo
        exec { 'get-ambari-server-repo':
            command => "wget http://public-repo-1.hortonworks.com/ambari/centos6/1.x/GA/ambari.repo",
            cwd     => '/etc/yum.repos.d/',
            creates => '/etc/yum.repos.d/ambari.repo',
            user    => root
        }

        # Ambari Server
        package { 'ambari-server':
            ensure  => present,
            require => Exec[get-ambari-server-repo]
        }
    }

    class install_all {
        include install_agent
        include install_server
    }

}