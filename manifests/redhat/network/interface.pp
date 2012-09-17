define os::redhat::network::interface (
                            $ipaddr,
                            $netmask,
                            $broadcast = false,
                            $gateway = false,
                            $hwaddr = false,
                            $onboot = "yes",
                            $bootproto = "static",
                            $interface_type = "Ethernet",
                            $extra_args = [ ]
                        ) {

    $device = $title
    $id = "os_redhat_network_interface_${device}"

    $base_dir = "/etc/sysconfig/network-scripts"

    case $bootproto {
        static: { }
        dhcp: { }
        default: { fail("$hostname: unsupported bootproto '$bootproto'") }
    }

    # Note: need to prefix with NEW- as otherwise ifup will think it 
    # is an interface definition
    file { "${base_dir}/NEW-ifcfg-${device}":
        content => template("os/redhat/ifcfg.erb"),
        mode => 0444,
        tag => "autoapply",
    }

    file { "${base_dir}/ifcfg-${device}":
        source => "${base_dir}/NEW-ifcfg-${device}",
        mode => 0444,
        require => File["${base_dir}/NEW-ifcfg-${device}"],
    }

    show_diff { "${id}.ifcfg": 
        src => "${base_dir}/NEW-ifcfg-${device}", 
        dest => "${base_dir}/ifcfg-${device}" 
    }

}
