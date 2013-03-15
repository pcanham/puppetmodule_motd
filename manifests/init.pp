# Class: motd
#
# This module manages motd
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class motd {
  if $::kernel == 'Linux' {
    file { '/etc/motd':
      ensure  => file,
      owner   => root,
      group   => root,
      mode    => '0644',
      backup  => false,
      content => template('motd/motd.erb'),
    }
  }
}
