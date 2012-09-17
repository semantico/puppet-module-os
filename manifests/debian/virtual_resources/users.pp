class os::debian::virtual_resources::users {

    # Standard Debian Users that we know that our services require,
    # so define them as virtual users and realise them all over the place.
    #
    # NOTE: These /may/ lock the system user to a UID. This may not
    #       be what you want, and may require a fair bit of juggling
    #       to

    if ( $root_password_crypt ) {
        @user { "root":
            uid => 0,
            gid => 0,
            comment => "root at $hostname",
            shell => "/bin/bash",
            home => "/root",
            ensure => present,
            password => $root_password_crypt,
        }
    } else {
        @user { "root":
            uid => 0,
            gid => 0,
            comment => "root at $hostname",
            shell => "/bin/bash",
            home => "/root",
            ensure => present,
        }
    }

    @user { "nobody":
        uid => 65534,
        gid => 65534,
        comment => "Nobody at $hostname",
        shell => "/bin/sh",
        home => "/nonexistent",
        ensure => present,
        groups => $environment ? {
            development => [ 'users' ],
            default => [ ]
        },
    }

}
