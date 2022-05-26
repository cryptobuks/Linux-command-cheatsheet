## Downloading Raspberry Pi image

Download Raspbian software from [this location](https://www.raspberrypi.org/downloads/raspbian/).

## Install Raspberry Image on SD card

Follow the [Installing operating system images on Linux](:/42dec45018e6408fa854491fb01e2adf) instruction.

Else, download Imager software for Ubuntu on [](https://www.raspberrypi.org/downloads/)https://www.raspberrypi.org/downloads/.
Next install the downloaded software on the SD card. Stick the card in the Pi and boot it up...

## Initial login and adding first user

Default Raspbian server login:

```
USERNAME: pi
PASSWORD: raspberry
```

## Change following settings in raspi-config

```
sudo raspi-config
2 Network options
    N2 Wi-fi
4 Localisation Options
    I2 Change Timezone - Europe - Amsterdam
    I3 Change Keyboard layout - Generic 105-key (intl) PC - English US - English (US, with euro on 5) - AltGr Default - NoComposeKey
5 Interfacing Options
    P2 SSH Enabling
7 Advanced Options
    A1 Expand Filesystem
```

Finish and Reboot

## Adding new user

```
sudo adduser [username]
```

Creates home directory and copies files from /etc/skel

Give user sudo rights

```
usermod -a -G sudo  bas
```

Test user sudo rights

Login with user: su username

Verify if user can execute sudo commands:

```
sudo ls -la /root
```

The first time the user will be asked his password

## Disable PI account for security

Login with newly created user.

Type following command to disable PI user:

```
sudo usermod -L pi
```

To check if account is succesfully locked:

```
sudo grep -E --color 'pi' cat /etc/shadow
```

A ! should be added before the encrypted password.

To undo the locking type:

```
sudo usermod -U pi
```

And to check:

```
sudo grep -E --color 'pi' cat /etc/shadow
```

## Changing the default keyboard layout

If you have a standard US keyboard and the raspberry does not show the right keys, its time to change the following file to math your keyboard layout.

```
sudo cp /etc/default/keyboard{,.org}
sudo nano /etc/default/keyboard
```

Configure the file so it looks like this:

```
# KEYBOARD CONFIGURATION FILE

# Consult the keyboard(5) manual page.

XKBMODEL="dell101"
XKBLAYOUT="us"
XKBVARIANT="std"
XKBOPTIONS=""

BACKSPACE="guess"
```

## Changing the Raspi hostname

Edit the following files and add hostname

```
sudo cp /etc/hostname{,.org}
sudo nano /etc/hostname
```

Change the hostname of the system

```
sudo cp /etc/hosts /etc/hosts.org
sudo nano /etc/hosts
```

Change the entry after the 127.0.0.1 to the same name as in hostname

Finish and Reboot

## Changing the Ip Addresses

To configure a static ip address on the raspberry, add the following section to the file /etc/dhcpcd.conf.org

```
sudo cp /etc/dhcpcd.conf{,.org}
sudo nano /etc/dhcpcd.conf
```

Add the following

```
interface eth0
static ip_address=192.168.88.2/24
static routers=192.168.88.1
static domain_name_servers=8.8.8.8

interface wlan0
static ip_address=192.168.1.119/24
static routers=192.168.1.1
static domain_name_servers=192.168.1.1
```

## Adding wireless network

```
sudo iwlist wlan0 scan
sudo cp /etc/wpa_supplicant/wpa_supplicant.conf{,.org}
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
ifconfig wlan0
```

Add the following to the file:

```
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=NL

network={
        ssid="TELE2-F35157"
        psk="45888C324786"
}
```

## Updating the system before use

The first action we will do is update the system so it gets the latest patches and security updates.
Enter the following command and press enter (no sudo because you are already logged in as root):

```
sudo apt update
sudo apt upgrade
```

You can also run the next experimental command from a terminal session and then log off.
Next time you log on, the system should be updated.

```
nohup sudo apt update && apt -y upgrade &
```

After a while the packages are updated to their most recent versions. Now reboot the server with:

```
shutdown -r now
```

The connection will be lost and after a minute or so you can log in again for the next step.

## Installing a firewall

To stay safe, it is mandatory to install a firewall. Here we are going to use ufw firewall.

Install ufw with the following command

```
sudo apt install ufw
```

### Configuring the firewall

We will initially set up the firewall that is only accepts ssh incoming sessions. There has to be an exception made in the firewall for eacht
installed Masternode.

```
sudo ufw allow ssh/tcp
sudo ufw limit ssh/tcp
sudo ufw logging medium
sudo ufw enable
```

Note that you can always disable the firewall with:

```
sudo ufw disable
```

After configuring the firewall, you can check it with

```
sudo ufw status
```

### Adding exceptions for services

Each new service port has to be added with a command similar like:

```
ufw allow 6667/tcp
```

To remove rules from the firewall use:

```
sudo ufw status numbered
sudo ufw delete 2
```

## Increase the USB current for peripherals

To change the current output on USB ports from 0,6 to 1,2 Ampere, open the file

```
sudo cp /boot/config.txt{,.org} 
sudo nano /boot/config.txt
```

Add the following at the end of the file:

```
# ENABLE MAXIMUM USB CURRENT (600MA TO 1.2A)
max_usb_current=1
```

## Adding multiple name servers

Open resolv.conf

```
sudo cp /etc/resolv.conf{,.org}
sudo nano /etc/resolv.conf
```

Add the following lines to the file

```
# Generated by resolvconf
nameserver 8.8.8.8
nameserver 192.168.1.1
nameserver 62.58.153.220
nameserver 62.58.48.30
nameserver 208.67.222.222
nameserver 208.67.220.220
```

Restart networking

```
sudo service networking restart
```

or

```
sudo /etc/init.d/networking restart
```

## SSH Server config

Changing the SSH config to secure SSH server

```
sudo cp /etc/ssh/sshd_config{,.bak}
sudo nano /etc/ssh/sshd_config
```

Simply copy and paste the config below:

```
# Optional:
# Change port from 22 to 2222 - change the firewall first if you do this!!
# Port 2222

SyslogFacility AUTH
LogLevel INFO

# LoginGraceTime specifies how many seconds to keep the connection alive without successfully logging in.
LoginGraceTime 120
# PermitRootLogin selects whether root is allowed to log in.
PermitRootLogin no
# strictModes is a safety guard that will refuse a login attempt if the authentication files are readabl$
StrictModes yes

# Since we do not run XServer on the system we disallow forwarding. 
X11Forwarding no
X11DisplayOffset 10

# Change to yes to enable challenge-response passwords (beware issues with
# some PAM modules and threads)
ChallengeResponseAuthentication no

# Set this to 'yes' to enable PAM authentication, account processing,
# and session processing. If this is enabled, PAM authentication will
# be allowed through the ChallengeResponseAuthentication and
# PasswordAuthentication.  Depending on your PAM configuration,
# PAM authentication via ChallengeResponseAuthentication may bypass
# the setting of "PermitRootLogin without-password".
# If you just want the PAM account and session checks to run without
# PAM authentication, then enable this but set PasswordAuthentication
# and ChallengeResponseAuthentication to 'no'.
UsePAM yes

# Allow client to pass locale environment variables
AcceptEnv LANG LC_*

# override default of no subsystems
Subsystem       sftp    /usr/lib/openssh/sftp-server

# Disable printing the MOTD
PrintMotd no
```

Restart SSH server with:

```
sudo systemctl restart ssh
```

## Changing the Login banner (MOTD)

Note that this is no longer needed since I customized the motd with motd-custom.sh

```
sudo cp /etc/motd{,.org}
sudo nano /etc/motd
```

Delete all text and paste the following text:

```
##########################   WARNING!   #########################
###         All connections are monitored and recorded.       ###
### Disconnect IMMEDIATELY if you are not an authorized user! ###
#################################################################
```

save the file.

Then:

```
sudo cp /etc/profile{,.org}
```

Add to end of bash profile script '/etc/profile':

```
nano /etc/motd-custom.sh
```

Make the following files:

```
/etc/motd-custom.sh   - the script that executes when logging on
/etc/motd-maint   - contains announcements you make for maintenance etc.
```

Open the "/etc/motd-custom.sh" file and paste the following contents:

```
#!/bin/bash
# Requires sysstat for mpstat (apt install sysstat)

echo -e "
\033[0;35m+++++++++++++++++: \033[0;37mSystem Data\033[0;35m :++++++++++++++++++++
\033[0;35m+ \033[0;37mDate and Time \033[0;35m= \033[1;32m`date`
\033[0;35m+      \033[0;37mHostname \033[0;35m= \033[1;32m`hostname`
\033[0;35m+       \033[0;37mAddress \033[0;35m= \033[1;32m`IP=$(curl -s ip.vostron.net |  awk '{print $NF}'); echo -n "$IP"`
\033[0;35m+        \033[0;37mKernel \033[0;35m= \033[1;32m`uname -r`
\033[0;35m+        \033[0;37mUptime \033[0;35m= \033[1;32m`uptime | awk -F'( |,)' '{print $4 $5}'`
\033[0;35m+          \033[0;37mLoad \033[0;35m= \033[1;32m`mpstat | awk /'all/ {print $12}'` idle
\033[0;35m+           \033[0;37mCPU \033[0;35m= \033[1;32m`cat /proc/cpuinfo | grep -m 1 "model name" | awk -F ": " '{print $2}'`
\033[0;35m+        \033[0;37mMemory \033[0;35m= \033[1;32mUsed `free -m | head -n 2 | tail -n 1 | awk {'print $3'}`MB out of `free -m | head -n 2 | tail -n 1 | awk {'print $2'}`MB
\033[0;35m+           \033[0;37mHDD \033[0;35m= \033[1;32mUsed `df -h / | tail -n 1 | awk {'print $3'}` out of `df -h / | tail -n 1 | awk {'print $2'}`
\033[0;35m+          \033[0;37mSwap \033[0;35m= \033[1;32m`free | awk /'Swap:/ {print $4*100/$2}'` free
\033[0;35m++++++++++++++++++: \033[0;37mUser Data\033[0;35m :++++++++++++++++++++++
\033[0;35m+      \033[0;37mUsername \033[0;35m= \033[1;32m`whoami`
\033[0;35m+     \033[0;37mProcesses \033[0;35m= \033[1;32m`ps aux | grep $USER | wc -l` of `ulimit -u` MAX
\033[0;35m++++++++++++: \033[0;33mMaintenance Information\033[0;35m :++++++++++++++
+\033[0;33m `cat /etc/motd-maint`
\033[0;35m++++++++++++++++++++: \033[0;31mWARNING!\033[0;35m :+++++++++++++++++++++
\033[0;35m+ \033[0;31mAll connections are monitored and recorded.
\033[0;35m+ \033[0;31mDisconnect IMMEDIATELY if you are not authorized!
\033[0;35m+++++++++++++++++++++++++++++++++++++++++++++++++++++
"
tput sgr0
```

Make the file executable with the following command:

```
sudo chmod ugo+x /etc/motd-custom.sh
```

## Disable unneeded services

The following services are enabled by default but can be disabled:

Tip: You can also use the `sysv-rc-conf` program to disable services.

- sudo systemctl stop bluetooth && sudo systemctl disable bluetooth

## NTP synchronisation

In newer Linux distributions that ship with Systemd, you can also sync time via timesyncd.conf file. Just open the file for editing.

```
$ sudo nano /etc/systemd/timesyncd.conf
```

And add or uncomment the following lines after \[Time\] statement, as illustrated in the below excerpt:

```
[Time]
NTP=0.nl.pool.ntp.org  
FallbackNTP=0.europe.pool.ntp.org 1.europe.pool.ntp.org
```

After editing the file, issue the timedatectl command to activate the NTP client build in systemd.

```
$ sudo timedatectl set-ntp true 
$ timedatectl status
```

In my case

```
sudo timedatectl set-ntp true
bas@tatooine:~ $ timedatectl status
               Local time: Fri 2020-05-29 16:13:07 CEST
           Universal time: Fri 2020-05-29 14:13:07 UTC
                 RTC time: n/a
                Time zone: Europe/Amsterdam (CEST, +0200)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no
```

Afterwards, issue date command in order to display your system clock.

```
bas@tatooine:~ $ date
Fri 29 May 16:16:08 CEST 2020
```

## SSH Hardening 1

## On local client

**Make SSH keypairs and disable password logon**

```
mkdir ~/.ssh && chmod 700 ~/.ssh

bas@Exogol in ssh $ ssh-keygen -b 4096
Generating public/private rsa key pair.
Enter file in which to save the key (/home/bas/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/bas/.ssh/id_rsa
Your public key has been saved in /home/bas/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:67wHC6Z+fbFTKJv94q4yEDA+f+jnDlX5ab1hS4j1SXo bas@Exogol
The key's randomart image is:
+---[RSA 4096]----+
|  |
| o      . |
| . o    o . . |
| o .  . + B . |
| o o. S *.E |
| +.+ ooo+.+ |
| ..= o.B +o |
| o.=o= B |
| ..=oo=Bo+. |
+----[SHA256]-----+
```

```
bas@Exogol in ssh $ ls -alh /home/bas/.ssh/
total 64K
drwx------  2 bas bas 4,0K Mar 26 17:41 .
drwx------ 32 bas bas  12K Mar 26 16:16 ..
-rw-------  1 bas bas 3,4K Mar 26 17:41 id_rsa
-rw-r--r--  1 bas bas  736 Mar 26 17:41 id_rsa.pub
-rw-------  1 bas bas  666 Mar 12 12:34 known_hosts
-rw-------  1 bas bas  664 Feb 25 15:47 known_hosts.old
```

**Uploaden van SSH key naar server**

```
ssh-copy-id bas@95.179.178.85

bas@Exogol in ssh $ ssh-copy-id bas@95.179.178.85

/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
bas@95.179.178.85's password: 

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'bas@95.179.178.85'"
and check to make sure that only the key(s) you wanted were added.
```

## On the server

**Loggin on to the server**

```
ssh 'bas@95.179.178.85'
```

**Disable SSH root login and login with passwords**

```
sudo nano /etc/ssh/sshd_config
```

```
# Change the following rules Port 1971
AddressFamily inet

PermitRootLogin no

PasswordAuthentication no 
PermitEmptyPasswords no

X11Forwarding no
```

```
sudo systemctl restart sshd
```

**Lock up the server with a firewall**

```
sudo apt install ufw

sudo ufw allow 1971

sudo ufw enable

sudo ufw status

sudo ss -tulpan
```

## SSH hardening 2

[source](https://algorithmdude.com/2019/02/11/raspberry-pi-3-secure-configuration-and-hardening/) Instead of using our username/password to log in, we will create and use SSH keys to login. After, we will disable password login. SSH keys are much safer than passwords and significantly more difficult for an attacker to crack or brute force.

On the Pi, run the following commands (as your non-root user) to create the authorized_keys file:

```
mkdir ~/.ssh
chmod 700 ~/.ssh
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

This creates a new file (~/.ssh/authorized\_keys) and sets the appropriate permissions on the .ssh directory and authorized\_keys file. We will place our public key from Windows in this file to allow remote access. On Windows, install PuttyGen and launch it. Click the button to “Generate” a public/private key pair. It should look something like this

[![Putty generate key](:/a6f50a6c7ccd443cb815a759a739a807)](http://192.168.1.2/wiki/./linux/././images/puttygen-key.png)

Copy the public key (the highlighted portion in the screenshot) and paste it into the authorized_keys file on your Pi. I recommend SSHing from Windows via username/password for this step and copying the key through your Putty session; it’s much easier and less error prone to copy/paste instead of typing it by hand!

We also need to modify the SSH configuration to allow SSH keys. Verify the following values are set in the `/etc/ssh/sshd_config` file. If they are not found, set them at the bottom of the file:

```
# Don't allow root login via SSH
PermitRootLogin no
# Allow SSH keys
PubkeyAuthentication yes
# Allow 30 seconds for user to provide credentials
LoginGraceTime 30
# Show SSH where our authorized_keys file is stored
AuthorizedKeysFile %h/.ssh/authorized_keys
# Check the permissions are correct on the home directory and SSH files before allowing login
StrictModes yes
# Don't allow empty password attempts
PermitEmptyPasswords no
# Disable password logins via SSH
PasswordAuthentication no
# Disable the Pluggable Authentication Module (PAM).
# This disables all Linux authentication unless they have a key.
# Make sure your key works before setting this option!
UsePAM no
```

A full description of all SSHD options is found here: [sshd_config](https://www.freebsd.org/cgi/man.cgi?sshd_config%285)).
Restart SSH once everything has been configured:

```
sudo systemctl restart ssh
```

Test your SSH key login to verify everything was set properly. Tell Putty to use your private key by setting the path in Connection > SSH > Auth > “Private key file for authentication”

[![Use private key](:/49c105e2445444dabb5b1ebf140401c3)](http://192.168.1.2/wiki/./linux/././images/putty-use-private-key.png)

I suggest saving these settings for easier use later on.

Now you can login on the system with the public-private key pair. The login screen will ask for the password you added to the key pair.

### Changing the Putty key to Linux SSH format

Default Linux SSH from the terminal can not work with the PuTTY ppk key. We have to make a new key with the following procedure to make it work:

```
# Install PuTTY tools:
sudo apt install putty-tools

# Revert the ppk key to a Linux format key with
puttygen yavin-private.ppk -O private-openssh -o yavin-private.key

# Remove group/world rights from the key:
chmod go-rwx yavin-private.key

# Log in on the server like this:
ssh -i yavin-private.key bas@192.168.1.119
```

This will make it work!

### **Enable automatic updates**

```
apt update
apt dist-upgrade

apt install unattended-upgrades
dpkg-reconfigure --priority=low unattended-upgrades
```
