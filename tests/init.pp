# The baseline for module testing used by Puppet Labs is that each manifest
# should have a corresponding test manifest that declares that class or defined
# type.
#
# Tests are then run by using puppet apply --noop (to check for compilation
# errors and view a log of events) or by fully applying the test in a virtual
# environment (to compare the resulting system state to the desired state).
#
# Learn more about module testing here:
# http://docs.puppetlabs.com/guides/tests_smoke.html
#

$szTestDirectory = '/var/test'

$arAliases = {
  '/test' => "$szTestDirectory",
}  

$szWebProcessOwner = 'lighttpd'

group { 'lighttpd':
  ensure => present,
}

user { "$szWebProcessOwner":
  ensure  => present,
  gid     => 'lighttpd',
  require => Group['lighttpd'];
}

file { "$szTestDirectory":
  ensure => directory,
  owner  => "$szWebProcessOwner",
  require => User["$szWebProcessOwner"],
}

file { "$szTestDirectory/index.html":
  ensure  => file,
  owner   => "$szWebProcessOwner",
  content => "<html><title>Testing puppet install of lighttpd</title><body>Did the installatio succeed?</body></html>",
  require => User["$szWebProcessOwner"],
}

class { "lighttpd":
  szWebProcessOwnerName => $szWebProcessOwner,
  harAliasMappings => $arAliases,
  require => User["$szWebProcessOwner"],
}

