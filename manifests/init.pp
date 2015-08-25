# == Class: lighttpd
#
# Full description of class lighttpd here.
#
# === Parameters
#
# Document parameters here.
#
# [*szWebProcessOwnerName*]
#    This user is expected to have been created prior to calling it here.
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { lighttpd:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class lighttpd (
  $szWebProcessOwnerName = hiera( 'WebProcessOwner', 'lighttpd' ),
  $szWebRootDirectory = hiera( 'WebRootDirectory', '/var/www' ),
  $harAliasMappings
) inherits lighttpd::params  {


package { 'lighttpd':
  ensure => present,
}


file { '/etc/lighttpd/lighttpd.conf':
  ensure  => present,
  content => template('/etc/puppet/modules/lighttpd/templates/lighttpd_conf.erb'),
  require => Package [ 'lighttpd' ],
  notify  => Service [ 'lighttpd' ]
}


service { 'lighttpd':
  ensure => running,
  enable => true,
}

}
