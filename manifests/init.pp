# Class: motd
#
# This module manages motd, you also have the ability to customise the motd on
# a server by server basis by adding a /etc/motd.local file to the system and
# puppet will merge this file into the /etc/motd for you.
#
# Additionally you can add in a list of modules puppet is maintaining into the
# motd as well by using motd::register
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#     class { motd: }
#
#     motd::register { 'ntpd': }
#
class motd {

  concat{'/etc/motd':
    owner => root,
    group => root,
    mode  => 0644
  }

  concat::fragment{'motd_header':
    target => '/etc/motd',
    content => template('motd/motd.erb'),
    order   => 01,
  }

  # local users on the machine can append to motd by just creating
  # /etc/motd.local
  concat::fragment{'motd_local':
    target => '/etc/motd',
    ensure  => '/etc/motd.local',
    order   => 15
  }

	# used by other modules to register themselves in the motd
	define motd::register($content="", $order=10) {
	  if $content == "" {
	    $body = $name
	  } else {
      $body = $content
    }

    concat::fragment{"motd_fragment_$name":
	    target  => '/etc/motd',
      content => "    -- $body\n"
    }
	}
}
