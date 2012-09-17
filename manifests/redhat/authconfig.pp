
class os::redhat::authconfig {

    file { "/etc/sysconfig/authconfig":
        owner => root,
        group => root,
        mode => 0644,
        content => template("os/redhat/authconfig.erb")
    }

}
