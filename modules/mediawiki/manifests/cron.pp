# class: mediawiki::cron
class mediawiki::cron {
    # https://github.com/miraheze/mw-config/issues/114
    #cron { 'jobqueue':
    #    ensure  => present,
    #    command => '/usr/local/bin/foreachwikiindblist /srv/mediawiki/dblist/all.dblist /srv/mediawiki/w/maintenance/runJobs.php > /var/log/mediawiki/cron/jobqueue.log',
    #    user    => 'www-data',
    #    minute  => '*/10',
    #}

    cron { 'purge_checkuser':
        ensure  => present,
        command => '/usr/local/bin/foreachwikiindblist /srv/mediawiki/dblist/all.dblist /srv/mediawiki/w/extensions/CheckUser/maintenance/purgeOldData.php > /var/log/mediawiki/cron/purge_checkuser.log',
        user    => 'www-data',
        minute  => '0',
        hour    => '*/12',
    }

    cron { 'purge_abusefilter':
        ensure => present,
        command => '/usr/local/bin/foreachwikiindblist /srv/mediawiki/dblist/all.dblist /srv/mediawiki/w/extensions/AbuseFilter/maintenance/purgeOldLogIPData.php > /var/log/mediawiki/cron/purge_abusefilter.log',
        user    => 'www-data',
        minute  => '0',
        hour    => '*/12',
    }
}
