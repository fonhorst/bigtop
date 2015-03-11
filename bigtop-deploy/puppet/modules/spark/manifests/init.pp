# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class spark {

  class install_common {
    package { "spark-core":
      ensure => latest,
    }
  }

  class install_master {
    package { "spark-master":
      ensure => latest,
    }
  }

  class install_worker {
    package { "spark-worker":
      ensure => latest,
    }
  }

  class install_all {
    include install_common
    include install_master
    include install_worker
  }

  class common ($master_host = $fqdn, $master_port = "7077", $master_ui_port = "18080") {
    include install_common

    file { "/etc/spark/conf/spark-env.sh":
        content => template("spark/spark-env.sh"),
        require => [Package["spark-core"]],
    }
  }

  class master {
    include common   
    include install_master


    if ( $fqdn == $master_host ) {
      service { "spark-master":
        ensure => running,
        require => [ Package["spark-master"], File["/etc/spark/conf/spark-env.sh"], ],
        subscribe => [Package["spark-master"], File["/etc/spark/conf/spark-env.sh"] ],
        hasrestart => true,
        hasstatus => true,
      }
    }
  }

  class worker {
    include common
    include install_worker


    if ( $fqdn == $master_host ) {
      Service["spark-master"] ~> Service["spark-worker"]
    }
    service { "spark-worker":
      ensure => running,
      require => [ Package["spark-worker"], File["/etc/spark/conf/spark-env.sh"], ],
      subscribe => [Package["spark-worker"], File["/etc/spark/conf/spark-env.sh"] ],
      hasrestart => true,
      hasstatus => true,
    } 
  }
}
