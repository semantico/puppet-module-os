
class os::redhat::virtual_resources::packages {
    
    # Virtual resources for packages: packages that we may need in certain
    # other classes, but don't want to install unless required.
    # Being virtual also means we can 'realize' them in multiple places
    
    
    case $lsbmajdistrelease {
        5: {
            @package { ["java-1.6.0-sun-devel","java-1.6.0-sun","jpackage-utils-compat-el5"]:    
                ensure => present,
                tag => "system_java",
            }
        }
        4: {
            @package { ["java-1.6.0-sun-devel","java-1.6.0-sun"]:     
                ensure => present,
                tag => "system_java",
            }
        }
    }
    
    file { "/etc/jstatd.all.policy":
                    content => template("os/jstatd.all.policy"),
                    mode => 0444,
                    owner => "root",
                    group => "root",
                    tag => "autoapply",
    }  
    
    # puppet debugging and help, but also generally used for ruby apps
    @package { irb: ensure => present, tag => 'autoapply' }
    #@package { rdoc: ensure => present, tag => 'autoapply' }
    
    
    # without problem.
    @package { perl-DBD-Pg: ensure => present, tag => 'autoapply' }
    
    #sams munge email credentials
    @package { perl-DBI: ensure => present, tag => 'autoapply' }
        
    
    #contins mkpasswd used by puppet generate passwords
    @package { expect: ensure => present, tag => 'autoapply' }

    
    #sams ip compression
    @package { perl-Net-Netmask:      ensure => present, tag => 'autoapply' }    

    #gw force update of rebuilt sarge package
    @package { dmidecode: ensure => latest, tag => 'autoapply' }
    
    #used by various nagios plugins
    @package { python: ensure => present, tag => 'autoapply' }
    
    #ocsinventory (pulled from repo so no dependencies needed
    #@package { perl-Compress-Zlib:      ensure => present, tag => 'autoapply' }
    #@package { perl-Net-IP:             ensure => present, tag => 'autoapply' }
    #@package { perl-Net-SSLeay:         ensure => present, tag => 'autoapply' }
    #@package { perl-XML-Simple:         ensure => present, tag => 'autoapply' }
    #@package { perl-XML-SAX-Expat:      ensure => present, tag => 'autoapply' }
    
    #used by our puppet facts but not a dependency in facter or puppet packages
    @package { pciutils:                ensure => present, tag => 'autoapply' }
    
    @package { screen:                  ensure => present, tag => 'autoapply' }
    
    #xt requires xmllint
    @package { libxml2:                  ensure => present, tag => 'autoapply' }
    
    #munin mysql graphing   
    @package { "perl-Cache-Cache":         ensure => present, tag => 'autoapply' }
    @package { "perl-IPC-ShareLite":         ensure => present, tag => 'autoapply' }

    @package { "perl-DBD-MySQL":         ensure => present, tag => 'autoapply' }

    #required for some binary i386 packages on 64bit systems
    @package { "compat-libstdc++-33":         ensure => present, tag => 'autoapply' }
    
    @package { perl-YAML-LibYAML:         ensure => present, tag => 'autoapply' }
   
    #perf_grinder
    @package { perl-Time-Piece:         ensure => present, tag => 'autoapply' }
    
    #mon
    @package { perl-libwww-perl: ensure => present, tag => 'autoapply' }
    
    #mon dns checker
    @package { perl-Net-DNS: ensure => present, tag => 'autoapply'}

    # Mainly for logcheck, but we use it in other modules too, hence Virtual
    @package { logtail: ensure => present, tag => 'autoapply' }

    # we need this to autocreate passwords on puppetmaster, but generally useful
    @package { pwgen: ensure => present, tag => 'autoapply' }
    
    
    #This is busted on rhel4, and although fixed in rawhide not available as a rpm update..
    case $lsbmajdistrelease {
        4: {
            case $operatingsystem {
                CentOS: { $pacct_log = "/var/account/pacct" }
                default: { $pacct_log = "/var/log/pacct" }
            }
            #This is busted on rhel4
            file { "/etc/logrotate.d/psacct":
                content => template("os/redhat/psacct"),
                mode => 0444,
                tag => "autoapply",
            }
            
        }
    }

    

}

