# class: role::dbreplication
class role::dbreplication {
    include mariadb::packages

    $icinga_password = lookup('passwords::db::icinga')
    class { 'mariadb::config':
        config          => 'mariadb/config/mw.cnf.erb',
        password        => lookup('passwords::db::root'),
        server_role     => 'slave',
        icinga_password => $icinga_password,
    }

    ufw::allow { 'mysql port db7 ipv4':
        proto => 'tcp',
        port  => '3306',
        from  => '51.89.160.143',
    }

    ufw::allow { 'mysql port db7 ipv6':
        proto => 'tcp',
        port  => '3306',
        from  => '2001:41d0:800:105a::11',
    }

    file { '/etc/ssl/private':
        ensure  => directory,
        owner   => 'root',
        group   => 'mysql',
        mode	=> '0750',
    }

    include ssl::wildcard

    # Create a user to allow db transfers between servers
    users::user { 'dbcopy':
        ensure      => present,
        uid         => 3000,
        ssh_keys    => [
            'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAm2zOFC/jMPPX2hbWHfuONDhylWRS6y7XXgGu8txQ6K dbcopy@db4'
        ],
    }

    motd::role { 'role::dbreplication':
        description => 'replication backup database server',
    }
}
