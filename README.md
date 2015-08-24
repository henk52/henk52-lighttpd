henk52-lighttpd
===============

* see: http://news.softpedia.com/news/Installing-Lighttpd-on-Fedora-and-Ubuntu-44557.shtml

Puppet module for Lighttpd, a light system requirements.


## LIMITATIONS:
* Right now it has only been tested on Fedora (20).


# Installation:
* cd /etc/puppet/modules
* git clone https://github.com/henk52/henk52-lighttpd.git lighttpd


# Usage:

## Defalt installation of Lighttpd

1. sudo puppet apply --verbose /etc/puppet/modules/lighttpd/manifests/install.pp


## Have a in '/storage'

´´´
$szWebStorageDir = '/var/webstorage'
file { "$szWebStorageDir":
  ensure => directory,
}

$arAliases = [
  { 
    alias => '/storage',
    path  => "$szWebStorageDir",
  },
]

class { 'lighttpd':
  harAliasMappings => "$arAliases",
}
´´´

