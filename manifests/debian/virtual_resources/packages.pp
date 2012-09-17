class os::debian::virtual_resources::packages {

    # Virtual resources for packages: packages that we may need in certain
    # other classes, but don't want to install unless required.
    # Being virtual also means we can 'realize' them in multiple places
    # without problem.

    #java

    #java versions
    case $lsbdistcodename {
        sarge: {
            $seed_file="jre5.seed"
            $java_package="sun-java5-bin"
        }
        etch: {
            $seed_file="jre6.seed"
            $java_package="sun-java6-jdk"
        }
        default: {
            $seed_file="jre6.seed"
            $java_package="openjdk-6-jdk"
        }
    }

    #seed files for the sun tandcs
    file { "/var/cache/debconf/jre6.seed":
                    content => template("os/jre6.seed"),
                    mode => 0555,
                    owner => "root",
                    group => "root",
    }
    file { "/var/cache/debconf/jre5.seed":
                    content => template("os/jre5.seed"),
                    mode => 0555,
                    owner => "root",
                    group => "root",
    }
    @package {  "system_java":
                name => "${java_package}",
                alias => "system_java",
                ensure => present,
                require      => File["/var/cache/debconf/${seed_file}"],
                responsefile => "/var/cache/debconf/${seed_file}",
                tag => "system_java",
    }

    file { "/etc/jstatd.all.policy":
                    content => template("os/jstatd.all.policy"),
                    mode => 0444,
                    owner => "root",
                    group => "root",
                    tag   => "autoapply",
    }

    @package { "ttf-dejavu": ensure => present, tag => 'autoapply' }

    #puppet debugging and help, but also generally used for ruby apps
    @package { irb: ensure => present, tag => 'autoapply' }
    @package { rdoc: ensure => present, tag => 'autoapply' }

    #Needed to build native extensions for rubygems
    @package { 'libicu-dev': ensure => present, tag => 'autoapply' }

    #gitlab deps
    @package { 'gcc': ensure => present, tag => 'autoapply' }
    @package { 'checkinstall': ensure => present, tag => 'autoapply' }
    @package { 'libxml2-dev': ensure => present, tag => 'autoapply' }
    @package { 'libxslt-dev': ensure => present, tag => 'autoapply' }
    @package { 'sqlite3': ensure => present, tag => 'autoapply' }
    @package { 'libsqlite3-dev': ensure => present, tag => 'autoapply' }
    @package { 'libcurl4-openssl-dev': ensure => present, tag => 'autoapply' }
    @package { 'libreadline-dev': ensure => present, tag => 'autoapply' }
    @package { 'libc6-dev': ensure => present, tag => 'autoapply' }
    @package { 'libssl-dev': ensure => present, tag => 'autoapply' }
    @package { 'libmysql++-dev': ensure => present, tag => 'autoapply' }
    @package { 'zlib1g-dev': ensure => present, tag => 'autoapply' }
    @package { 'redis-server': ensure => present, tag => 'autoapply' }
    @package { 'python-dev': ensure => present, tag => 'autoapply' }
    @package { 'python-pip': ensure => present, tag => 'autoapply' }
    @package { 'python-cairo-dev': ensure => present, tag => 'autoapply' }
    @package { 'python-django': ensure => present, tag => 'autoapply' }
    @package { 'python-ldap': ensure => present, tag => 'autoapply' }
    @package { 'python-memcached': ensure => present, tag => 'autoapply' }
    @package { 'python-pysqlite2': ensure => present, tag => 'autoapply' }
    @package { 'python-twisted': ensure => present, tag => 'autoapply' }
    @package { 'libyaml-dev': ensure => present, tag => 'autoapply' }
    @package { 'pygments': ensure => present, tag => 'autoapply' , provider => pip }








    # ssl_ca needs this at least
    @package { openssl: ensure => present, tag => 'autoapply' }

    #used by our puppet facts but not a dependency in facter or puppet packages
    @package { pciutils: ensure => present, tag => 'autoapply' }
    #gw force update of rebuilt sarge package
    @package { dmidecode: ensure => latest, tag => 'autoapply' }

    #used by various nagios plugins
    @package { python: ensure => present, tag => 'autoapply' }

    # Common Perl libs
    @package { libxml-simple-perl: ensure => present, tag => 'autoapply' }
    @package { libwww-perl: ensure => present, tag => 'autoapply' }
    @package { perl-DBI: ensure => present, tag => 'autoapply' }
    @package { libnet-ip-perl: ensure => present, tag => 'autoapply' }
    @package { libcompress-zlib-perl: ensure => present, tag => 'autoapply' }
    @package { libnet-ssleay-perl: ensure => present, tag => 'autoapply' }
    @package { libhtml-parser-perl: ensure => present, tag => 'autoapply' }
    @package { libhtml-tree-perl: ensure => present, tag => 'autoapply' }
    @package { libhtml-tagset-perl: ensure => present, tag => 'autoapply' }
    @package { libxml-namespacesupport-perl: ensure => present, tag => 'autoapply' }
    @package { libxml-libxml-perl: ensure => present, tag => 'autoapply' }
    @package { libxml-sax-expat-perl: ensure => present, tag => 'autoapply' }
    @package { libxml-libxml-common-perl: ensure => present, tag => 'autoapply' }
    @package { libxml-sax-perl: ensure => present, tag => 'autoapply' }
    @package { libxml-parser-perl: ensure => present, tag => 'autoapply' }
    @package { libclass-dbi-pg-perl: ensure => present, tag => 'autoapply' }
    @package { libyaml-perl: ensure => present, tag => 'autoapply' }
    @package { libsnmp-perl: ensure => present, tag => 'autoapply' }
    @package { libhtml-template-perl: ensure => present, tag => 'autoapply' }

    #mysql munin monitor

    @package {  "libfile-cache-perl": ensure => present, tag => 'autoapply' }
    @package {  "libipc-sharelite-perl": ensure => present, tag => 'autoapply' }
    @package {  "libdbd-mysql-perl": ensure => present, tag => 'autoapply' }

    #pg munin monitor
    @package {  "libdbd-pg-perl": ensure => present, tag => 'autoapply' }
    @package {  "libdbi-perl": ensure => present, tag => 'autoapply' }


    case $lsbdistcodename {
        etch:  { @package {  "libicu": name => libicu40 , ensure => present, tag => 'autoapply' } }
        hardy: { @package {  "libicu": name => libicu38 , ensure => present, tag => 'autoapply' } }
        lucid: { @package {  "libicu": name => libicu42 , ensure => present, tag => 'autoapply' } }
        default: { @package {  "libicu": name => libicu42 , ensure => present, tag => 'autoapply' } }
    }

    @package { logrotate: ensure => present, tag => 'autoapply' }

    @package { "m4":		ensure => present, tag => "autoapply"}

    #xt requires xmllint
    @package { libxml2-utils: ensure => present, tag => 'autoapply' }

    #perf_grinder
    @package { libtime-piece-perl:         ensure => present, tag => 'autoapply' }

    #sams ip compression
    @package { libnet-netmask-perl:      ensure => present, tag => 'autoapply' }

    @package { screen: ensure => present, tag => 'autoapply' }
    @package { arping: ensure => present, tag => 'autoapply' }

    # Mainly for logcheck, but we use it in other modules too, hence Virtual
    @package { logtail: ensure => present, tag => 'autoapply' }

    # portmap - for NFS mainly
    @package { portmap: ensure => present, tag => 'autoapply' }

    #used for apache2 install and possibly tomcat
    @package { cronolog: ensure => present, tag => 'autoapply' }

    # Tools required by multiple modules
    @package { snmp: ensure => present, tag => 'autoapply' }

    @package { smbfs: ensure => present }
    @package { imagemagick: ensure => present }

    # Required by Perl GD
    @package { libfontconfig1: ensure => present }

    # Handy for shell scripts, timeout a command
    @package { timeout: ensure => present, tag => 'autoapply' }

    # Used for yajsw
    @package { 'unrar' : ensure => present, tag => 'autoapply' }

    ###gems

    @package { 'charlock_holmes': ensure => present, tag => 'autoapply' , require => Package['libicu-dev'], provider => "gem" }
    @package { 'bundler': ensure => present, tag => 'autoapply' , provider => "gem" }

    @package { 'sinatra': ensure => present, provider => "gem" }
    @package { 'thin': ensure => present, provider => "gem" }

    @package { 'bcrypt-ruby': ensure => present, provider => "gem" }

    @package { 'ruby-net-ldap': name => 'net-ldap', ensure => present, provider => "gem" }
}
