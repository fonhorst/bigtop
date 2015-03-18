class ambari {
  
   # Turn off interfering services
  include ambari::disable_services

  # Install and enable ntp
  include ambari::simple_ntp
  
}