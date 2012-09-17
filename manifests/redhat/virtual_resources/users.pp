
class os::redhat::virtual_resources::users {

    # Standard Redhat Users that we know that our services require,
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
        uid => 99,
        gid => 99,
        comment => "Nobody at $hostname",
        shell => "/sbin/nologin",
        home => "/",
        ensure => present,
    }

}

