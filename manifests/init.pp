# Provide some core packages and features that I really want on every machine.
# Set the package list in hiera for a per-OS basis.

class core(Array $packages=[]) {

    include yum   # Does nothing if $::osfamily != 'RedHat'

    ensure_packages($packages)

    Class['yum'] -> Package[$packages]

    if  ($facts['os']['family'] == 'RedHat')
    and ($facts['os']['release']['major'] == '7') {
        file { '/etc/cron.daily/mlocate.cron' :    ensure => absent,  }
        file { '/etc/cron.daily/makewhatis.cron' : ensure => absent,  }
        package { 'mlocate' :
                ensure => present,
                notify => File[ '/etc/cron.daily/mlocate.cron' ],
        }
    }

}
