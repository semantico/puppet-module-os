class os::debian::virtual_resources::groups {

    @group { "root":
        gid => 0,
        ensure => present,
    }

    @group { "nogroup":
        gid => 65534,
        ensure => present,
    }

}
