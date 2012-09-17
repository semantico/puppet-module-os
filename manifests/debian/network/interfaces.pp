
class os::debian::network::interfaces {

    if $debian_interfaces {

        file { "/etc/network/interfaces":
            owner => root,
            group => root,
            content => template("os/debian/interfaces.erb"),
            mode => 0444,
        }

    } else {
        notice("${hostname}: Set debian_interfaces to manage /etc/network/interfaces")
    }

}

