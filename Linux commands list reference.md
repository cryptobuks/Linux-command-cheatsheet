# Linux commands list reference

## GENERAL COMMANDS

``command_1; command_2; command_3``  : Running multiple commands in one single command

``command_1 && command_2`` : Running multiple commands in one single command only if the previous command was successful

``ctrl+r search_term`` : Easily search and use the commands that you had used in the past

``ctrl+Q`` : Unfreeze your Linux terminal from accidental Ctrl+S. You probably are habitual of using Ctrl+S for saving. But if you use that in Linux terminal, you’ll have a frozen terminal.

``Ctrl+A / Ctrl+E`` : Move to beginning or end of line.

``Ctrl+U / Ctrl+K`` :  If you press Ctrl+U, it deletes everything from your current cursor position to the beginning of the line. If you press Ctrl+K, it deletes everything from your cursor position to the end of the line.

``!!`` : Reuse the previous command in present command.

``grep -Pri Search_Term path_to_directory`` : Find if there are files containing a particular text.

``man <commando>`` : Opvragen van manual / handleiding van een commando. De beste referentie om een commando te leren kennen!

``CTRL + U`` : shortcut dat in een commandoregel het deel voor de cursor in de regel verwijderd

``sudo !!`` : laatste commando herhalen (maar nu in sudo modus) - dus niet meer hertypen!

``apt-get update``: Synchronizes the list of packages on your system to the list in the repositories. Use it before installing new packages to make sure you are installing the latest version.

``apt-get upgrade``: Upgrades all of the software packages you have installed.

``clear``: Clears previously run commands and text from the terminal screen.

``date``: Prints the current date.

``find / -name example.txt``: Searches the whole system for the file example.txt and outputs a list of all directories that contain the file.

``nano example.txt``: Opens the file example.txt in the Linux text editor Nano.

``poweroff``: To shutdown immediately.
raspi-config: Opens the configuration settings menu.

``reboot``: To reboot immediately.

``shutdown -h now``: To shutdown immediately.

``shutdown -h 01:22``: To shutdown at 1:22 AM.
startx: Opens the GUI (Graphical User Interface).

``killall -9 vlc`` : Geforceerd sluiten van alle VLC instances

``uname -sr`` : toon linux versie in gebruik

``uptime`` : Toon hoe lang het systeem aan staat

``neofetch`` : op een hele fancy manier je systeeminformatie in de terminal tonen

``cmatrix -a`` : terminal screensaver a-la The Matrix

``id`` : Toon huidige gebruiker met id's, groups lid etc.

``tee`` : Tee kan gebruikt worden om een deel (snapshot) van de output van een commando (pipeline) op te slaan in een bestand, bijv. ``cat /etc/passwd | sort | tee passwd.file | cut -d : -f 1`` slaat de output van sort op.

``pwd`` : Print working directory

``write user pts/1`` : schrijf iets in de terminal van een andere gebruiker

``mesg`` : met mesg kun je veranderen dat je in de terminal personen mag pingen met een bericht. meestal staat deze op 'mesg is n' daarna 'mesg y' om write te mogen gebruiken.

``bc`` :  An arbitrary precision calculator language

``echo $$`` : toon PID van huidige bash shell om te zien in welke shell je aan het editen bent 

``init 5`` : Legacy runlevels. 'init 5' switches to runlevel 5  = X11 mode (see inittab for what each runlevel boots too). e.g. init 1 reboots to single user mode
     Better use systemctl!

``xrandr -s 1920x1080`` : Xrandr is een terminal commando waarmee je de schermresolutie kunt veranderen. (gezien op een Manjaro YT video)

## FILE AND DIRECTORY COMMANDS

``rm -rf *`` : NOOIT GEBRUIKEN DIT VERWIJDERD ALLES OP HET SYSTEEM

``cat example.txt``: Displays the contents of the file example.txt.

``cd /abc/xyz``: Changes the current directory to the /abc/xyz directory.

``cd -`` : Change toggle to last used directory

``cd ~`` : Change to home directory (or just ``cd``	)

``cp examplefile.txt /home/pi/office/``: copies examplefile.txt in the current directory and pastes it into the /home/pi/ directory

``sudo cp /etc/default/keyboard{,.org}`` : kopieer het bestand naar zichzelf + een toevoegsel. 

``cp mrtg.cfg{,.back.`date +'%F'`}`` : Kopieer met naam.back.datum - beter alternatief.

``ls -l``: Lists files in the current directory, along with file size, date modified, and permissions.

``ls -li <filename>``: lists file with file size, date modified, permissions and inode number. Hardlinks verwijzen bv. naar deze inodes.

``mkdir example_directory``: Creates a new directory named example_directory inside the current directory.

``mv XXX``: Moves the file or directory named XXX to a specified location. For example, mv examplefile.txt /home/pi/office/ moves examplefile.txt in the current directory to the /home/pi/office directory. If the file is not in the current directory, add the path of the file’s location (i.e. cp /home/pi/documents/examplefile.txt /home/pi/office/ moves the file from the documents directory to the office directory). This command can also be used to rename files (but only within the same directory). For example, mv examplefile.txt newfile.txt renames examplefile.txt to newfile.txt, and keeps it in the same directory.

``rm example.txt``: Deletes the file example.txt.

``rmdir example_directory``: Deletes the directory example_directory (only if it is empty).

``scp user@10.0.0.32:/some/path/file.txt``: Copies a file over SSH. Can be used to download a file from a PC to the Raspberry Pi. user@10.0.0.32 is the username and local IP address of the PC, and /some/path/file.txt is the path and file name of the file on the PC.

``touch example.txt``: Creates a new, empty file named example.txt in the current directory.

``sudo find / -type f  -size +10000k -exec ls -lh {} \; | awk '{print $5 ": " $9}' | sort -nr | head -n 40``
: Command scans for lagre files on the system and shows a top 40 biggest files.

``scrot`` : cd Destkop; scrot - screenshot to desktop. scrot -s: captures mouse selected window or mouse drag. scrot sv: select window with banner. scrot -u:  scrot -d 4 -c: delays screenshot with 4 seconds and with countdown timer. scrot myscreen.jpg /.png: determine name of screen output.

``python3 -m http.server --bind <local ip-address>`` : use a local pyton powered simple http server which only serve html pages.

``sort -u crazy-color-file`` : sorteert een groot bestand met meerdere gelijke regels en verwijder (-u) dubbele waarden zodat alleen unieke waarden overblijven.

``cat /etc/passwd | cut -d : -f 1`` : toon een delimited kolom (:) in bestand en toon kolom (-f) 1.

``file / usr/bin/bash`` : toon (meta) informatie over een bestand

``type echo`` : toon wat voor soort bestand het is

``hash`` : Linux bewaard veelgebruikte commando's in een hash zodat deze snel toegankelijk is

``stat filename`` : toon statistieken van een bestand

``mkdir -p scripts/path/to/source`` : gebruik mkdir om het hele path te creëren

``rmdir source`` : alleen een directory verwijderen    

``rm -r scripts`` : directory recursief verwijderen

``ln <file> <target link location>`` : Hardlink maken naar een bestand - geen directory. Hardlinks kunnen niet gemaakt worden tussen filesystems. Hardlinks zijn bijna kopies van een bestand maar zijn toch hetzelfde bestand. vb. 'ln hosts hardlink'

``ln -s <file> <target link>`` : maak een pointer naar het bestand maar niet de inode. kan ook voor directories gebruikt worden.

## Archiveren en comprimeren

``tar -cvf homedir.tar .	`` : maak van huidige directory een TAR bestand 

``tar -tvf homedir.tar	`` : toon inhoud van tar bestand

``tar -xvf homedir.tar	`` : pak tar bestand uit op huidige locatie

``gzip -v <filenaam>`` : comprimeer een bestand en maak er een .gz van

``gzip -dv <filenaam>`` : pak een .gz bestand uit

``bzip2 -v <filenaam>`` : comprimeer een bestand en maak er een .bz2 van (langaam maar betere compressie)

``bzcat <filenaam> | less`` : bekijk het gecomprimeerde bestand met cat

``bzip2 -dv <filenaam>`` : pak een .bz2 bestand uit

## File permissies

``chmod a=rwx hosts`` : geef rwx rechten aan all voor bestand hosts

``chmod u=rw hosts`` : verander user rechten op hosts file naar rw

``chmod g-rx hosts`` : haal rx rechten weg van hosts voor group

``chmod 777 hosts`` : geef het bestand rwx aan user, group en others

``chattr +i`` : immutable bit zetten op bestand (niet aanpasbaar)

``chattr -i``  : immutable bit weghalen

Numerieke waarden (binair)

```
x = 1
w = 2
r = 4
wx = 3
wr= 6
rx = 5
```

``chmod 364 hosts`` : user heeft wx, group heeft wr en other heeft r

## acl op file zetten

``getfacl <filenaam>`` : toon acl op filenaam

``setfacl --modify u:tpbonfi:7 hosts`` : zet acl op hosts waarbij user tpbonfi alle rechten krijgt (7)

## NETWORKING AND INTERNET COMMANDS

``ifconfig``: To check the status of the wireless connection you are using  (to see if wlan0 has acquired an IP address).

``iwconfig``: To check which network the wireless adapter is using.

``iwlist wlan0 scan``: Prints a list of the currently available wireless networks.

``iwlist wlan0 scan | grep ESSID``: Use grep along with the name of a field to list only the fields you need (for example to just list the ESSIDs).

``nmap``: Scans your network and lists connected devices, port number, protocol, state (open or closed) operating system, MAC addresses, and other information.

``ping``: Tests connectivity between two devices connected on a network. For example, ping 10.0.0.32 will send a packet to the device at IP 10.0.0.32 and wait for a response. It also works with website addresses.

``wget http://www.website.com/example.txt``: Downloads the file example.txt from the web and saves it to the current directory.

```
wget \
     --recursive \
     --no-clobber \
     --page-requisites \
     --html-extension \
     --convert-links \
     --restrict-file-names=windows \
     --domains https://gekko.wizb.it \
     --no-parent \
https://gekko.wizb.it/

wget --recursive --no-clobber --page-requisites --html-extension --convert-links --restrict-file-names=windows --no-parent https://gekko.wizb.it/

wget https://gekko.wizb.it/
```

## SYSTEM INFORMATION COMMANDS

``dmesg`` : Geeft error en log informatie terug naar het scherm. Handig bij debuggen van fouten (zoals bij mount.cifs)

``cat /proc/meminfo``: Shows details about your memory.

``cat /proc/cpuinfo``: Shows you the processor information

``cat /proc/partitions``: Shows the size and number of partitions on your SD card or hard drive.

``cat /proc/version``: Shows you which version of the Raspberry Pi you are using.

``df -h``: Shows information about the available disk space.

``df /``: Shows how much free disk space is available.

``dpkg – –get–selections | grep XXX``: Shows all of the installed packages that are related to XXX.

``dpkg – –get–selections``: Shows all of your installed packages.

``free``: Shows how much free memory is available.

``hostname -I``: Shows the IP address of your Raspberry Pi.

``UP key``: Pressing the UP key will print the last command entered into the command prompt. This is a quick way to repeat previous commands or make corrections to commands.

``vcgencmd measure_temp``: Shows the temperature of the CPU.

``vcgencmd get_mem arm && vcgencmd get_mem gpu``: Shows the memory split between the CPU and GPU.

``dmesg -l err`` : Toon error messages in console

## USB Commands

``lsusb``: Lists USB hardware connected to your Raspberry Pi.

``findmnt``: List the currently mounted devices/filesystems

``mount -l``: Old way of fnding the currently mounted devices/filesystems

``lsblk``: prints all block devices (except RAM disks) in a tree-like format by default

```
root@tatooine:/var/www/html/wiki# lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
mmcblk0     179:0    0 29.7G  0 disk
├─mmcblk0p1 179:1    0  256M  0 part /boot
└─mmcblk0p2 179:2    0 29.5G  0 part /
root@tatooine:/var/www/html/wiki# lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda           8:0    1 57.3G  0 disk
└─sda1        8:1    1 57.3G  0 part
mmcblk0     179:0    0 29.7G  0 disk
├─mmcblk0p1 179:1    0  256M  0 part /boot
└─mmcblk0p2 179:2    0 29.5G  0 part /
```

``dmesg | tail``: Shows the kernell ring buffer messages to detect which device was just added

``blkid -p "device"``: To find out the UUID, label and more properties of the attached device

To find the difference between before and after plugging in the usb device, you can use:

```
$ ls -l /dev/disk/by-* >/tmp/nousb.txt
$ # plug usb
$ ls -l /dev/disk/by-* >/tmp/withusb.txt
$ diff --ignore-space-change /tmp/withusb.txt /tmp/nousb.txt
```

``udevadm monitor --udev``: with this command line, you need to unplug the device before using the command and then plug it to see it

### 3 ways to mount

``mount -t auto /dev/sda1 /media``: Mount the usb stick to the /media location

```
root@tatooine:/var/www/html/wiki# lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda           8:0    1 57.3G  0 disk
└─sda1        8:1    1 57.3G  0 part
mmcblk0     179:0    0 29.7G  0 disk
├─mmcblk0p1 179:1    0  256M  0 part /boot
└─mmcblk0p2 179:2    0 29.5G  0 part /
root@tatooine:/media# mount -t auto /dev/sda1 /media
root@tatooine:/media# lsblk --fs
NAME        FSTYPE LABEL  UUID                                 FSAVAIL FSUSE% MOUNTPOINT
sda
└─sda1      vfat          CC2F-F523                              57.3G     0% /media
mmcblk0
├─mmcblk0p1 vfat   boot   4BBD-D3E7                             199.9M    21% /boot
└─mmcblk0p2 ext4   rootfs 45e99191-771b-4e12-a526-0779148892cb     22G    20% /
```

Or

``sudo mount -L Ubuntu 18.10`` : mount using a label

``sudo mount -U BXXX-6XXX``: mount using UUID

**Permanently mounting (at bootup)**

To permanently mount the usb stick, open the file ``/etc/fstab`` and enter the following:

```
# pendrive SanDisk Corp. Ultra Fit 64Gb
UUID=CC2F-F523               /media/usb-stick auto defaults,nofail
```

UUID comes from ``blkid -p /dev/sda1``

``` 
blkid -p /dev/sda1
/dev/sda1: UUID="CC2F-F523" VERSION="FAT32" TYPE="vfat" USAGE="filesystem" PART_ENTRY_SCHEME="dos" PART_ENTRY_TYPE="0xc" PART_ENTRY_NUMBER="1" PART_ENTRY_OFFSET="32" PART_ENTRY_SIZE="120176608" PART_ENTRY_DISK="8:0"
```

Now that fstab knows that our USB-stick should be placed at /media/usb-stick, we can mount the pendrive just by using that directory the next time we plug the pendrive: ``mount /media/usb-stick``.

**Remove mounted device**

When you want To finally remove the USB-stick, you need to release it from the filesystem first with umount.

``sudo umount /media/usb-stick``

**Optional: Set pendrive label**

To set create or rename the label of a pendrive there are several programs:

* e2label - Change the label on an ext2/ext3/ext4 filesystem
* tune2fs - adjust tunable filesystem parameters on ext2/ext3/ext4 filesystems
* mke2fs - create an ext2/ext3/ext4 filesystem

To set a pendrive label as usb-stick

```
e2label /dev/sda1 usb-stick
tune2fs -L usb-stick /dev/sda1
```

Or create filesystem: ``mke2fs	pubsw /dev/hdb1``
And change the label: ``mke2fs -L	pubsw /dev/hdb1``

## SSH COMMANDS

``ssh <user>@<ip-address> -p <portnumber>`` : Remote login with ssh in linux terminal

``ssh -i <keyfile> <user>@<ip-address> -p <portnumber`` : Remote login with ssh in linux terminal with public keyfile e.g. "ssh -i key.ppk demo@192.237.248.66"

``sudo dpkg --get-selections > installed-packages.list`` : maak een overzicht van alle geinstalleerde pakketten en exporteer deze naar*.list bestand

## SCP commands

Kopieer plaatselijk bestand naar remote server.

```
scp testfile.txt root@95.179.178.85:~/

root@95.179.178.85's password: 
testfile.txt                                  100%   26     2.2KB/s   00:00 `` 
```

Andere voorbeelden:

``scp /pi/example.c pi@192.168.3.215 /pi/project``

``scp -r /pi/project pi@192.168.3.216 /pi/project`` : Many files in a directory can be sent using the recursive option (-R).

``scp -p test.c pi@192.168.3.216:~/`` : use the "-p" option to preserve modification times, access times, and modes from the original file

``scp -pC test.c pi@192.168.3.216:~/`` : SCP allows the files to be compressed with -C before they can be sent across the network to the destination.

``scp -P 21938 test.c pi@192.168.3.216:~/`` : Socket programming involves sending and receiving data through ports and SCP can be used to send data through specific ports to the remote host. This can be done using the "-P" option.

``scp -rq ~/files pi@192.168.3.216:~/files`` : There might be cases, where you wouldn't want to know the status of transfer of files, like in the image above. It makes sense, to turn off the transfer status when there is a large amount of files. We can do that by using the "-q" option. 

``scp -r username@remoteip:remote_location_directory /location/where/you/save`` : 

Option you may use on your demand

-P port : Specifies the port to connect to on the remote host. Note that this option is written with a capital "P", because -p is already reserved for preserving the times and modes of the file in rcp.

-p : Preserves modification times, access times, and modes from the original file.

-r : Recursively copy entire directories.

-v : Verbose mode. Causes scp and ssh to print debugging messages about their progress. This is helpful in debugging connection, authentication, and configuration problems.

```
scp -r root@95.179.178.85:/root/test /home/bas/Downloads/
root@95.179.178.85's password: 
testfile.txt                                  100%   26     2.2KB/s   00:00    
testback.txt                                  100%   10     0.9KB/s   00:00    

```

``scp -r root@95.179.178.85:/opt /home/bas/Downloads/abafar`` : Download complete opt directory


## creating tar.bz2 files splitting them in different parts and joining them afterwards
```
tar -cvjf binance_0.1.db-eth-2017-2020.tar.bz2 binance_0.1.db

split -b 45M binance_0.1.db-eth-2017-01-01_2020_02-20.tar.bz2 "binance_0.1.db-eth-2017-01-01_2020_02-20.tar.bz2.part"

ls -alh

cat binance_0.1.db-eth-2017-01-01_2020_02-20.tar.bz2.part* > binance_0.1.db-eth-2017-01-01_2020_02-20.tar.bz2

tar -xjf binance_0.1.db-eth-2017-01-01_2020_02-20.tar.bz2
``` 

## Creating a bootable usb stick with a Linux distribution
First download the iso file from the website. After downloading, execute the following commands:

```
# Insert usb stick and execute:
sudo fdisk -l

# It will show you the location of the usb stick, like '/dev/sdb1'.

# Unmount the usb stick with:
sudo umount /dev/sdb1

# Go to the directory where the downloaded iso resides and enter the following command (in this case it is a Lubuntu iso file). This will write the iso to the /dev/sdb location:
sudo dd if=lubuntu-18.04-alternate-i386.iso of=/dev/sdb

# After a few minutes the console will show something like this:
1464320+0 records gelezen
1464320+0 records geschreven
749731840 bytes (750 MB, 715 MiB) copied, 219,47 s, 3,4 MB/s

# You are now ready to use the usb stick for installing linux on a laptop.
``` 

## Installing an image to a SD card and imaging a SD card to a file

``bas@exogol:~/Downloads$ sudo dd bs=4M if=2020-02-13-raspbian-buster-lite.img of=/dev/mmcblk0 status=progress conv=fsync`` : Copying an image to an SD card. E.g. at initial copy of Raspberry image to SD card for first boot.

``sudo dd if=/dev/mmcblk0 of=~/raspbian_backup.img`` : mmcblk is the device where the SD card exists (check with ```sudo fdisk -l```)

``sudo dd if=~/raspbian_backup.img of=/dev/mmcblk0`` : Restoring the backup image to the SD card - make sure the card is the same size as the image.

## FTP

Procedure for uploading a file to an ftp server from Raspberry Pi to Synology with ftps.
Note: Use the lftp program for this!

```
# From the directory where the files to upload are:
lftp User@Server-IP

Enter password: 

# Alternatively you can do
lftp www.yourdomain.com -u username,password -e "set ssl:verify-certificate no;"

# Enter the next command to bypass certificate errors:
set ssl:verify-certificate no

# Go to directory of choice:
ls cd /Backup/documenten

# Single file
put filename

# Multiple files
mput *.xls

# Exiting the server
quit
```

Getting FTP files is mostly similar.

```
# From the directory where the files to upload are:
lftp User@Server-IP

Enter password: 

# Alternatively you can do
lftp www.yourdomain.com -u username,password -e "set ssl:verify-certificate no;"

# Enter the next command to bypass certificate errors:
set ssl:verify-certificate no

# Go to directory of choice:
ls cd /Backup/documenten

# Single file
get filename

# Multiple files
mget *.xls

# Exiting the server
quit
``` 
## Mounten en unmounten van devices, files en shares
``mount.cifs //192.168.1.3/ActiveBackup /mnt/ActiveBackup -o user=[USERNAAM],pass=[PASSWORD],vers=2.0`` : Mounten van een fileshare op Synology server vanaf linux.

`` `` : 

## Wanneer je een file in windows hebt gemaakt en Linux kan er niets mee

Starten van een bash file, gemaakt met VSCode in Windows doet dit:

``bash: ./start.sh: /bin/bash^M: bad interpreter: No such file or directory``

Gebruik dan het onderstaande commando en line ends te verwijderen:

``sed -i -e 's/\r$//' start.sh

 `` : 

`` `` : 

## Multimedia en conversion commando's

Meerdere multimediabestanden van een bepaald formaat (hier .flac) converteren naar .mp3

``find -name "*.flac" -exec bash -c 'ffmpeg -i "{}" -y -acodec libmp3lame -ab 128k "${0/.flac}.mp3"' {} \;``

Een bestand converteren naar MP3

``ffmpeg -1 oud.avi nieuw.mp3``

## systemctl en services

``systemctl get-default`` : show initial system runlevel

``systemctl set-default multi-user.target`` : Change system runlevel to multi-user (no graphical)

``systemctl list-units``: list only the active units from the server's memory

``systemctl list-units --all``: list all the units independent of their state add "--all" to this command

``systemctl list-unit-files``: Now list-units shows the list of units which are currently loaded in the memory but not necessarily installed on the server

``systemctl list-unit-files --type=service``: To further filter the unit files we can add type= argument with list-unit-files. The argument should be a comma-separated list of unit types. This should give us a complete list of installed services (independent of it's state).

``systemctl list-units --all --type=mount``: we can also list all the mount type unit files available on our server using type=mount

``systemctl list-unit-files --type=service --state=enabled``: To list all the service unit files which are currently in enabled state use --state=enabled

``systemctl list-unit-files --type=service --state=enabled,disabled``:  list all the systemctl service which are either enabled or disabled

``systemctl list-units --type=service --state=running``: To list the running services we will use list-units in combination with --type=service and --state=running

``systemctl list-units --type=service --state=failed``: To list failed services you can use --state=failed

``systemctl --failed``: Idem.

``systemctl status sshd``: check the status of sshd service

``systemctl show sshd --property=SubState``: To check if a systemctl service is running or not

``systemctl show sshd --property=ActiveState``: To check if a service is active or inactive

``LoadState=loaded``: To check if a service is loaded or not

``systemctl show <service>``: To list all the properties of a service

``sudo systemctl start gekko``: Manually start service

``sudo systemctl stop gekko``: Manually stop service

``sudo systemctl disable gekko``: Disable service at system startup (auto start)

``sudo systemctl status gekko.service``: Show current status of service

``sudo journalctl -u gekko``: Show service logs

``sudo systemctl daemon-reload``: If service init file is changed, you must reload daemon

## VIM tips en tricks

``vim .vimrc`` : maak een vim config bestand

```
set number
set showcmd
set nocursorline
set ignorecase
set incsearch
set hlsearch
set tabstop=4
set softtabstop=4
```

## Bash profile

``source ~/.bash_profile`` : opnieuw laden van bash profile in huidige prompt. Handig om gewijzigde bashrc of bash_aliases door te voeren in de huidige shell.

``PS1`` : Default prompt

``PS2`` : Prompt bij niet afgemaakt commando in shell. In .bash_profile kun je dit aanpassen met bijv: `PS2="Command not finished >"` of iets dergelijks

``export PATH PS1`` : in .bash_profile betekend dat de instellingen meegenomen worden naar een nieuwe diepere (parent > child) shell (bijv wanneer sudo su)

``alias`` : toon alle aliasses die in de shell zijn geconfigureerd.

Tip: Maak van de aangepaste bash rc en aliases file een git repo en plaats deze in opt zodat elke bashrc file daarnaar kan verwijzen (te configureren in /etc/.bashrc voor elke nieuwe gebruiker). Nieuwe aliases etc kunnen dan via github centraal worden gedistribueerd naar alle servers.

Tip: alias refresh='. ~/.bashrc'

``set -o`` : Tweede set van customizations van bash shell. Laat set parameters van de bash shell zien. 

``set -o noclobber`` : Overschrijven van reeds bestaande bestanden tegengaan. Kan alleen nieuwe files maken. 

Tip: noclobber kan met | overruled worden, bijv. ``cat /etc/passwd >| hosts``

``set +o noclobber`` : noclobber uitzetten (+o betekend +off)

``set -o vi`` : vi commandline editing inschakelen. Met vi commando's de commandline beinvloeden.

``shopt`` : Toon Shell opties (andere set van mogelijkheden om de shell aan te passen)

``shopt +s cdspell`` : Aanzetten van spellingcontrole in de console. Geeft je tips als je een commando, directory of bestand niet goed hebt opgeschreven. Niet supernauwkeurig.     

``shopt +u cdspell`` : Uitzetten.

Bash function for in .bash_aliases:

```
# start function
refresh () {
     # Enter function commands
     source ~/.bash_profile
# End function
}
```

Voorbeeld bash_logout script

```
clear

# Cleanup of temporary files
echo "Now running .bash_logout cleanup script"

for _MY_TMP_FILES in `find / -user bas -name "*.tmp" -print 2>/dev/null`
do
     echo "Found and now removing $_MY_TMP_FILES"
     /usr/bin/rm -i "$_MY_TMP_FILES"
done
```


## Terminal commands

``Ctrl + Alt + t`` : Hotkey naar terminal openen. In de terminal opent dit een tweede terminal instance.w

``Ctrl + l`` : Scherm leegmaken (zoals clear of cls)

``Ctrl + Alt + ``

## Diversen
``sort -u crazy-color-file`` : sorteert een groot bestand met meerdere gelijke regels en verwijder (-u) dubbele waarden zodat alleen unieke waarden overblijven.
``cat /etc/passwd | cut -d : -f 1`` : toon een delimited kolom (:) in bestand en toon kolom (-f) 1.
``file / usr/bin/bash`` : toon (meta) informatie over een bestand
``type echo`` : toon wat voor soort bestand het is
``hash`` : Linux bewaard veelgebruikte commando's in een hash zodat deze snel toegankelijk is
``stat filename`` : toon statistieken van een bestand

```
tar -cvf homedir.tar .	# maak van huidige directory een TAR bestand 
tar -tvf homedir.tar	# toon inhoud van tar bestand
tar -xvf homedir.tar	# pak tar bestand uit op huidige locatie
```

