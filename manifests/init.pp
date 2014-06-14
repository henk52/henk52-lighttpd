# == Class: lighttpd
#
# Full description of class lighttpd here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
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
  $szWebProcessOwnerName = params_lookup( 'WebProcessOwner' )
) inherits lighttpd::params  {


#  see: http://news.softpedia.com/news/Installing-Lighttpd-on-Fedora-and-Ubuntu-44557.shtml

package { 'lighttpd':
  ensure => present,
}


file { '/etc/lighttpd/lighttpd.conf':
  ensure  => present,
  content => template('lighttpd_conf.erb'),
  require => Package [ 'lighttpd' ],
  notify  => Service [ 'lighttpd' ]
}


service { 'lighttpd':
  ensure => running,
  enable => true,
}

}
