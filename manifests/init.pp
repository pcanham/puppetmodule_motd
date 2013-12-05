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
