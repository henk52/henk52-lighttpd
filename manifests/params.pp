
class lighttpd::params {
$WebProcessOwner = $::operatingsystem ? {
  /(?i:Debian|Ubuntu|Mint)/ => 'www-data',
  default => 'lighttpd',
}
}
