# Provide some core packages and features that I really want on every machine.

class core {

    if  ($facts['os']['family'] == 'RedHat')
    and ($facts['os']['release']['major'] == '7') {

        package { 'bind-utils' :      ensure => present, }
        package { 'curl' :            ensure => present, }
        package { 'man' :             ensure => present, }
        package { 'openssh-clients' : ensure => present, }
        package { 'wget' :            ensure => present, }
        package { 'xorg-x11-xauth' :  ensure => present, }
        package { 'yum-utils' :       ensure => present, }

        file { '/etc/cron.daily/mlocate.cron' :    ensure => absent,  }
        file { '/etc/cron.daily/makewhatis.cron' : ensure => absent,  }

        package { 'mlocate' :
                ensure => present,
                notify => File[ '/etc/cron.daily/mlocate.cron' ],
        }

    }

}
