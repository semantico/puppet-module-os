#$title of define should match the first parameter of the associated debian_interfaces line
#e.g eth0/x.x.x.x./...
define os::debian::network::interfaces::post-up (
    $ethtool_speed = 100, 
    $ethtool_duplex = "full",
    $ethtool_interfaces = false, #[ eth0,eth1] 
    $route_pairs = false #e.g array of "route:gateway"["10.146.0.0/16:10.177.56.254", "10.146.0.0/16,10.177.56.254"]
    ){
    
    file { "/etc/network/${title}_post-up":
            content => template("os/debian/post-up.erb"),
            mode => 0755,
    }  
    
}    
