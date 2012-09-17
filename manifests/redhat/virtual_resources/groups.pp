class os::redhat::virtual_resources::groups {

    @group { "root":
        gid => 0,
        ensure => present,
    }

    @group { "nobody":
        gid => 99,
        ensure => present,
    }

}

