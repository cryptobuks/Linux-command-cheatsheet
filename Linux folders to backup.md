Under most circumstances you want to backup these:

    /home/ for user data and configuration.
    /etc/ for system wide configuration files.
    /var/ contains a mix of directories you usually want to backup and those you don't want to backup. See below for a more detailed explanation.

Some more directories to consider are:

    /usr/local/ hand-installed packages (i.e. not installed through apt) are installed here. If you have packages installed here, you may want to backup the whole directory, so you don't have to reinstall them. If the packages themselves aren't important to you, it should be enough to backup /usr/local/etc/ and /usr/local/src/.
    /opt/ if you didn't store anything here, you don't need to back it up. If you stored something here, you are in the best position to decide, if you want to back it up.
    /srv/ much like /opt/, but is by convention more likely to contain data you actually want to backup.
    /root/ stores configuration for the root user. If that is important to you, you should back it up.

/var/

/var/ contains many files you want to backup under most circumstances, but also some you don't want to backup.

You probably want to backup these:

    /var/lib/ this directory contains variable state data for installed applications. Depending on the application you want to backup that state or you don't. If you want to be on the safe side, you can just back up everything. Otherwise you can look at each sub-directory and decide for yourself if the data contained is important enough to you to back it up.
    /var/mail/ you normally want to backup local mails.
    /var/www/ if your web root is located here and this is the only place where your web content is stored, you want to back it up.
    /var/games/ you may want to backup these, if system wide game data is important enough for you (not many games use this storage though).
    /var/backups/ usually contains files that are automatically generated from other data that you usually want on a backup, but that would take an unnecessary amount of space in the backup or is otherwise cumbersome to backup. For example dpkg dumps a list of installed packages here, so you can later know which packages to install after restoring the backup. You probably want to backup this.

You probably don't want to backup these:

    /var/cache/ contrary to the name, some contents of this directory are important, so check each subdirectory individually, as a rule of thumb, everything you put here yourself is important. You also might want to backup /var/cache/debconf/.
    /var/lock/ locks usually (always) don't need to be backed up.
    /var/run/ contains data that is only important for your running system, i.e. when you shutdown you system, it will not be needed any more.
    /var/spool/ normally important data shouldn't be stored here, but you might want to check.
    /var/spool/cron/crontabs/ might contain many commands or a complex schedule, even with dependencies on other systems, that has taken considerable effort to put together.

You have to decide yourself on these:

    /var/local/ you normally know if you stored something here and whether you want it on a backup or not.
    /var/opt/ see /var/local/ or better check if something important is stored here.
    /var/log/ depends on whether your logs are important to you and if you have enough space to store them (they might take a lot of backup space over time).


You'll be backing up some 'garbage' doing this... but if you just backup all of /home, /etc, and /var/ you should have everything (unless you know you put something somewhere else). You'll want to leave out /var/tmp, /var/run/, /var/lock for sure. 

rsync -rzvP --partial /sourcedir / destdir


https://www.howtogeek.com/427480/how-to-back-up-your-linux-system/
Grsync
luckyBackup 

https://www.ibackup.com/online-backup-linux/readme.htm

https://www.maketecheasier.com/back-up-entire-hard-drive-linux/

https://linuxtechlab.com/how-to-perform-linux-system-backup/
