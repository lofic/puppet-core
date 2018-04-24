# Provide some core packages and features that I really want on every machine.
# Set the package list in hiera for a per-OS basis.

class core($packages) {

    package { $packages: ensure => present }

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
