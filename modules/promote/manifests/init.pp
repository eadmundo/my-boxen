class promote {
    file { '/usr/local/bin/promote':
        ensure  => present,
        content => template("promote/promote.sh"),
        mode => 777
    }
}