Onderstaande vernieuwde instructies voor het configureren van een nieuwe Raspberry Pi server

# Starten zonder Xwindows

```
sudo raspi-config
1 System options
S5 Boot / Auto Login Select boot into desktop or to command line
B1 Console Text console, requiring user to login
```

Console output:

```
Removed /etc/systemd/system/default.target.
Created symlink /etc/systemd/system/default.target → /lib/systemd/system/multi-user.target.
```

# Disk volledig benutten

```
sudo raspi-config
6 Advanced Options Configure advanced settings
A1 Expand Filesystem Ensures that all of the SD card is available

```

# Adding static Ip Addresses to eth0

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

# Adding wireless network

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

# Changing the Raspi hostname

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

# Changing the default keyboard layout

If you have a standard US keyboard and the raspberry does not show the right keys, its time to change the following file to math your keyboard layout.

```
sudo cp /etc/default/keyboard{,.org}
sudo nano /etc/default/keyboard
```

Configure the file so it looks like this:

```
XKBMODEL=pc105
XKBLAYOUT=us
XKBVARIANT=
XKBOPTIONS=
BACKSPACE=guess
```

# Updating the system before use

The first action we will do is update the system so it gets the latest patches and security updates.
Enter the following command and press enter (no sudo because you are already logged in as root):

```
sudo apt update
sudo apt upgrade
```

After a while the packages are updated to their most recent versions. Now reboot the server with:

```
shutdown -r now
```

The connection will be lost and after a minute or so you can log in again for the next step.

# Enable automatic updates

It's important to keep your system up to date with all the latest security updates. To do this in an automatic way, use the snippet below and your system will update automatically.

```
sudo apt update
sudo apt dist-upgrade

sudo apt install unattended-upgrades
sudo dpkg-reconfigure --priority=low unattended-upgrades
```

Choose yes when asked "Automatically download and install stable updates"

# Adding new user

```
sudo adduser [username]
```

Creates home directory and copies files from /etc/skel

Give user sudo rights

```
sudo usermod -a -G sudo  bas
```

Test user sudo rights

Login with user: su username

Verify if user can execute sudo commands:

```
sudo ls -la /root
```

# Disable PI account for security

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

BEWARE THAT YOU SHOULD AT LEAST HAVE CONSOLE ACCESS TO YOUR SYSTEM BEFORE EXECUTING THE INSTRUCTIONS BELOW!!!

# Installing a firewall

To stay safe, it is mandatory to install a firewall. Here we are going to use ufw firewall.

Install ufw with the following command

```
sudo apt install ufw

sudo ufw status
```

## Configuring the firewall

We will initially set up the firewall that is only accepts ssh incoming sessions. There has to be an exception made in the firewall for each service we configure.

```
sudo ufw allow ssh/tcp
sudo ufw limit ssh/tcp
sudo ufw logging medium
sudo ufw enable
```

After configuring the firewall, you can check it with

```
sudo ufw status
```

Note that you can always disable the firewall with:

```
sudo ufw disable
```

## Adding exceptions for services

Each new service port has to be added with a command similar like:

```
ufw allow 9387/tcp
```

## Removing firewall rules

To remove rules from the firewall use:

```
sudo ufw status numbered
sudo ufw delete 2
```

# Secure SSH

To reach your server in a secure way, you should use SSH.

Most Linux distributions have installed SSH by default.

To harden the SSH server, you could use a SSH key to log on the server. This is more secure than a password alone.

## On local client

To make SSH keypairs and disable password logon, use the next steps.

Make a directory that u can use to keep the secure key files:

```
# create hidden directory
mkdir ~/.ssh 

# only local user can use directory
chmod 700 ~/.ssh
```

Create a key pair with the following command. Follow the instructions.  
It's more secure to use a passphrase with the key so that in case that someone has your key, they still cannot use it.

```
ssh-keygen -b 4096

Generating public/private rsa key pair.
Enter file in which to save the key (/home/bas/.ssh/id_rsa): <YOURFILENAME>
Enter passphrase (empty for no passphrase): <YOURPASSPHRASE>
Enter same passphrase again: <YOURPASSPHRASE>
```
After the keypair is made, you can upload the key to the server with:

```
ssh-copy-id bas@192.168.88.2
```

Use your password when uploading the keys.

## Setup the SSH server

On the server we have to setup some things for a more secure SSH server

First log on to the server with:

```
ssh 'bas@192.168.88.2'
```

It can be that your client pc wants to save the key password for you in a keychain.

First create a backup of your SSH server configuration

```
sudo cp /etc/ssh/sshd_config{,.org}
```

Now you van configure the SSH server.
Here we will configure SSH to:

* Not allow root to login
* Use the keyfile
* Use another obscure port

```
sudo nano /etc/ssh/sshd_config
```

Change the following lines

```
Port 1970
AddressFamily inet

PermitRootLogin no

AllowUsers bas

PasswordAuthentication no 
PermitEmptyPasswords no

UsePAM no

X11Forwarding no
```

## Add the port to the firewall

If you have set up a firewall (and I hope you did), then you should add the new SSH port to the rules.


You can check the open ports on your system with:

```
sudo ss -atpu
```

If port 1970 is shown, then the firewall can be changed.


```
sudo ufw status

sudo ufw allow 1970/tcp

sudo ufw status
```

## Reboot the SSH service to enable the configuration


```
sudo systemctl restart sshd
```

## Test the server

Open a new terminal and login to the server with:

```
ssh 'dcd@172.16.65.130' -p 1970
```

## Cleanup firewall rules

Because we first added a firewall rule for SSH port 22 and since we changed this port to 1970. This old rule for port 22 is not necessary anymore. We can remove these rules with:

```
sudo ufw delete allow 22/tcp
```

# Adding multiple name servers

Open resolv.conf

```
sudo cp /etc/resolv.conf{,.org}
sudo nano /etc/resolv.conf
```

Add the following lines to the file

```
# Generated by resolvconf
# Google
nameserver 8.8.8.8
# Local router
nameserver 192.168.1.1
# Quad9 public DNS server
nameserver 9.9.9.9
# Cloudflare
nameserver 1.1.1.1
# OpenDNS home
nameserver 208.67.222.222
```

Restart networking

```
sudo service networking restart
```

or

```
sudo /etc/init.d/networking restart
```

# Increase the USB current for peripherals

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

## Setting the correct timezone

First check the date and timezone of your system

```
sudo timedatectl
```

Check the timezone and if the ntp service is activated and synchronized.

Use the following command to see the symlink to the configured system timezone:

```
sudo ls -l /etc/localtime
```

or

```
sudo cat /etc/timezone
```

To check how your own timezone is called, use the next command:

```
sudo timedatectl list-timezones
```

Save your location so you can use it in the next command.  
In my case: ``Europe/Amsterdam``

```
sudo timedatectl set-timezone Europe/Amsterdam
```

Now check the configured timezone once again with:

```
sudo timedatectl
```

# NTP synchronisation

It's important that the bot's time is synchronised with a time server.

For Europe, you can see the timeservers here: https://www.pool.ntp.org/zone/europe

```
sudo cp /etc/systemd/timesyncd.conf{,.org}
sudo nano /etc/systemd/timesyncd.conf
```

And add or uncomment the following lines after \[Time\] statement, as illustrated in the below excerpt:

```
[Time]
NTP=0.nl.pool.ntp.org  
FallbackNTP=0.europe.pool.ntp.org 1.europe.pool.ntp.org
RootDistanceMaxSec=5
PollIntervalMinSec=32
PollIntervalMaxSec=2048
```

After editing the file, issue the timedatectl command to activate the NTP client build in systemd.

```
sudo timedatectl set-ntp true
sudo timedatectl status
```

Restart and check the service:

```
systemctl restart systemd-timesyncd
systemctl status systemd-timesyncd
```

If not active use:

```
systemctl start systemd-timesyncd
systemctl enable systemd-timesyncd
```

Afterwards, issue date command in order to display your system clock.

```
bas@yavin:~ $ date
Sat 08 Jan 2022 06:22:10 PM CET
```

# Disable unneeded services

The following services are enabled by default but can be disabled:

Tip: You can also use the `sysv-rc-conf` program to disable services.
```
sudo apt install sysv-rc-conf
sudo sysv-rc-conf
```

- sudo systemctl stop bluetooth && sudo systemctl disable bluetooth

# Set locale to NL (for Perl)

If you get the error message when installing Perl or Perl based software:

```
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LC_MONETARY = "nl_NL.UTF-8",
	LC_ADDRESS = "nl_NL.UTF-8",
	LC_TELEPHONE = "nl_NL.UTF-8",
	LC_NAME = "nl_NL.UTF-8",
	LC_MEASUREMENT = "nl_NL.UTF-8",
	LC_IDENTIFICATION = "nl_NL.UTF-8",
	LC_NUMERIC = "nl_NL.UTF-8",
	LC_PAPER = "nl_NL.UTF-8",
	LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to a fallback locale ("en_US.UTF-8").
```

Do the following

```
export LANGUAGE=nl_NL.UTF-8
export LANG=nl_NL.UTF-8
export LC_ALL=nl_NL.UTF-8
locale-gen nl_NL.UTF-8
dpkg-reconfigure locales
```

