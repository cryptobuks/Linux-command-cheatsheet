# Linux Distributie first steps

## Mint

### Software te verwijderen na schone installatie

* Rhytmbox (2mb): ``sudo apt-get remove --auto-remove rhythmbox; sudo apt-get purge rhythmboxs``
* Thunderbird (210mb): ``sudo apt-get remove --dry-run thunderbird`` & ``sudo apt-get remove --purge thunderbird`` & ``sudo apt-get remove --purge thunderbird``
* VLC (229kb) Celluloid is mediaplayer: ``sudo apt-get remove --purge vlc``
* 

```
celluloid zal verwijderd worden
hexchat zal verwijderd worden
hexchat-common zal verwijderd worden
libreoffice-avmedia-backend-gstreamer zal verwijderd worden
libreoffice-base zal verwijderd worden
libreoffice-base-core zal verwijderd worden
libreoffice-base-drivers zal verwijderd worden
libreoffice-calc zal verwijderd worden
libreoffice-common zal verwijderd worden
libreoffice-core zal verwijderd worden
libreoffice-draw zal verwijderd worden
libreoffice-gnome zal verwijderd worden
libreoffice-gtk3 zal verwijderd worden
libreoffice-help-de zal verwijderd worden
libreoffice-help-en-gb zal verwijderd worden
libreoffice-help-en-us zal verwijderd worden
libreoffice-help-es zal verwijderd worden
libreoffice-help-fr zal verwijderd worden
libreoffice-help-it zal verwijderd worden
libreoffice-help-nl zal verwijderd worden
libreoffice-help-pt zal verwijderd worden
libreoffice-help-pt-br zal verwijderd worden
libreoffice-help-ru zal verwijderd worden
libreoffice-help-zh-cn zal verwijderd worden
libreoffice-help-zh-tw zal verwijderd worden
libreoffice-impress zal verwijderd worden
libreoffice-java-common zal verwijderd worden
libreoffice-l10n-de zal verwijderd worden
libreoffice-l10n-en-gb zal verwijderd worden
libreoffice-l10n-en-za zal verwijderd worden
libreoffice-l10n-es zal verwijderd worden
libreoffice-l10n-fr zal verwijderd worden
libreoffice-l10n-it zal verwijderd worden
libreoffice-l10n-nl zal verwijderd worden
libreoffice-l10n-pt zal verwijderd worden
libreoffice-l10n-pt-br zal verwijderd worden
libreoffice-l10n-ru zal verwijderd worden
libreoffice-l10n-zh-cn zal verwijderd worden
libreoffice-l10n-zh-tw zal verwijderd worden
libreoffice-math zal verwijderd worden
libreoffice-ogltrans zal verwijderd worden
libreoffice-pdfimport zal verwijderd worden
libreoffice-sdbc-hsqldb zal verwijderd worden
libreoffice-style-galaxy zal verwijderd worden
libreoffice-style-tango zal verwijderd worden
libreoffice-writer zal verwijderd worden
python3-uno zal verwijderd worden
rhythmbox zal verwijderd worden
rhythmbox-plugin-tray-icon zal verwijderd worden
rhythmbox-plugins zal verwijderd worden
thunderbird zal verwijderd worden
thunderbird-gnome-support zal verwijderd worden
thunderbird-locale-en zal verwijderd worden
thunderbird-locale-en-us zal verwijderd worden
thunderbird-locale-nl zal verwijderd worden
timeshift zal verwijderd worden
xul-ext-lightning zal verwijderd worden
```
### AppImages
Appimages in een aparte AppImages folder in Home directory opslaan voor eenvoudige backups van deze programma's.

### Mounten van een netwerkschijf (Ahch-To)

### Cinnamom opleuken met themes etc.
Ga naar: https://cinnamon-spices.linuxmint.com/

### Extensions downloaden en installeren

Download extention. Daarna uitpakken in:

``~ / .local / share / cinnamon / extensions /``

Vervolgens Cinnamon restarten

Of via menu > extensions

### Favotiete extensions

* Transparent panels - Startmenu transparant (achteraf toch niet goed werkend)
* Desktop Cube - Compiz desktop kubus bij draaien van schermen ( Ctrl + Alt + Pijltje links/rechts)
* Cinnamon maximus - Undecorate windows - geen kaders meer (Super + U)
* GTile - Vensters handiger verdelen (Super + G)

Downloaden: https://cinnamon-spices.linuxmint.com/extensions/view/76

Usage

    Super + G open gTile
    Esc close gTile
    ARROWS move with keyboard
    Shift + ARROWS select area
    Space or Enter tile the selected area

More options are available in Cinnamon Settings -> Extensions -> gTile@shuairan -> Settings.

### Desklets



### Cinnamon restarten

Ctrl+F2, r, enter

### Aanpassen van de terminal met shortcuts

Gebruik hiervoor de .bash files in de directory [bash-default-files](./bash-default-files/).
Vervang de huidige bestanden met deze voor een prettig werkende terminal omgeving.

### Software te installeren/activeren

* VS Code
* VLC
* Youtube-dl
* GIT
* Keepass
* Codecs (``sudo apt install mint-meta-codecs``)
* Redshift
* Warpinator
* Driver manager (updaten van NVIDIA driver)
* Flameshot
* Stacer
* Timeshift
* python-is-python3 (``sudo apt install python-is-python3``)!!!

### Systeem opruimen

``sudo apt autoremove``

### Firewall activeren

Deny inbound connections!  
Allow outbound connections.  

### Startup applicaties aanpassen

Met het programma ``Startup applications``.

Uitschakelen:

* Mintwelcome
* Warpinator
* im-launch

### Set up flameshot

How To Setup Flameshot?

Now that you are aware of the features (and probably have it installed), how do you use it?

Of course, you don’t want to launch a screenshot tool by searching for it in the list of applications installed.

So, the best way to access it would be to press the PRT SC key, right?

But, by default, when you press the Print Screen button, it will launch the default screenshot tool (or directly take a full-screen screenshot).

Fret not, you can easily change it. Here’s how you can set flameshot to launch upon pressing the ‘Prt Sc‘ button:

1. Head to the system settings and navigate your way to the “Device” options.

2. Next, head inside the “Keyboard Shortcuts” option.

3. Now, you need to change the keyboard shortcut for “Saving a screenshot to Pictures” from Prt Sc to anything else (a button you don’t use frequently). 

Refer to the image above to understand it better.

4. Once you have done this, scroll down to the bottom and add a new keyboard shortcut by clicking on the “+” button.

5. Here, you will get the option to name the shortcut (it can be anything) and in place of the command, you will have to enter:

flameshot gui

And, hit the Prt Sc button when you set the shortcut. That’s it!

    By default, Flameshot saves the pictures in PNG format. So, if you need a JPEG file, you can simply rename the file extension.
    You can change the color of the text/arrow mark by performing right-click before adding it. Once you change it, the color remains the same even when you use it the next time. You can change the color again, the same way.
    If you want the option to choose a custom color (instead of the pre-defined color selection), head to the tool settings that you find on the left side of the screen.
    If you cannot access the Flameshot configuration option via the app drawer, simply type in “flameshot config” in the terminal.

### Screenshots in Mint

* Print : 
* Shift + Print : Take screenshot of area
* Ctrl + Shift + Print : Take screenshot of area to clipboard
* Ctrl + Print : Copy screenshot to clipboard
* Alt + Print : Take screenshot of a window
* Ctrl + Alt + Print : Copy screenshot of a window to clipboard
* Shift + Ctrl + Alt + R : Toggle recording desktop

### Overige custom shortcuts
* Ctrl + Alt + S : Flameshot
* Ctrl + Alt + F : Firefox
* Ctrl + Alt + C : VS Code


### Software die ik gebruik

| Programma | Bron | Doel |
| :--- | :--- | :--- 
| Filezilla | Pacakge manager | bestandsoverdracht |
| VS Codium | https://github.com/VSCodium/vscodium/releases (Appimage)| Code schrijven |
| Atomic Wallet | https://atomicwallet.io/downloads (Appimage)| CryptoWallet |
| Electrum | https://electrum.org/#download (Appimage)| CryptoWallet |
| Ledger live | https://www.ledger.com/ledger-live/download (Appimage)| CryptoWallet |
| KeepassX | Package manager | Password manager |
| VeraCrypt | Fileserver | Encrypted volumes |
| Dropbox | Package manager | Cloud synchronisatie bestanden |
| Midnight Commander | ``sudo apt install mc`` | Bestandsbeheer |
| Stow | ``sudo apt install stow`` | dotfiles configuratie |
| Git | ``sudo apt install git`` | Code repository | 
| Codecs | ``sudo apt install mint-meta-codecs`` | Video's en media afspelen |
| Redshift | ``sudo apt install redshift`` | Temperatuur van beeldscherm aanpassen na X uur 's-avonds |
| Jupyter notebooks | ``sudo apt install jupyter`` | Python data analyse met Jupyter |
| CloneZilla | ``sudo apt install clonezilla`` | Backup / clone maken van harddisk |


### Iets ingewikkelder software
;
#### Python instellingen

Initiele Python installatie.

``sudo apt install python-is-python3 python3-pip``

``(sudo) pip3 install pandas pandas_ta jupyter matplotlib scipy``

Overige python modules etc. worden met de betreffende software meegeinstalleerd.

#### Youtube-dl

```
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl
```

### Nerd fonts

```
#### Hack nerd font:
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
```

Extract fonts from zipfile to ```$HOME/.fonts

### VS Codium

```
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg | gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/vscodium.gpg
echo 'deb https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/ vscodium main' | sudo tee --append /etc/apt/sources.list.d/vscodium.list 
sudo apt update && sudo apt install codium
```

### Software verwijderen

* Rhytmbox (2mb): sudo apt-get remove --auto-remove rhythmbox; sudo apt-get purge rhythmboxs
* Thunderbird (210mb): sudo apt-get remove --dry-run thunderbird & sudo apt-get remove --purge  thunderbird & sudo apt-get remove --purge thunderbird
* VLC (229kb) Celluloid is mediaplayer: sudo apt-get remove --purge vlc

### Tweaks en instellingen

* SSH keys van servers in .ssh plaatsen en alleen rw voor user maken.
* stow gebruiken om de dotfiles weer op de juiste plaatsen met de juiste symbolic links.

### Cinnamon herstarten

```
Ctrl + F2
r
enter
```

### Lettertypes groter maken
Start > QT5 Configuration tool > Fonts op 12
Start > System settings > Font selection > Fonts op 12


## MX Linux

MX Linux is Debian stable based so packages can be (de)installed with apt.

### Python stuff

* sudo apt-get install python3-venv
* sudo apt-get install python3-pip
* sudo apt-get install python3-gpg

# Jupyter
* sudo apt-get install setuptools
* sudo apt-get install jupyter

Standaard Python verwijst naar Python2. Symbolic link aanpassen naar Python3.

```
$ ls -alh /usr/bin/python
lrwxrwxrwx 1 root root 7 mrt  4  2019 /usr/bin/python -> python2

rm /usr/bin/python

sudo ln -s /usr/bin/python3 /usr/bin/python

ls -alh /usr/bin/python
lrwxrwxrwx 1 root root 16 mei 31 20:02 /usr/bin/python -> /usr/bin/python3

python --version
Python 3.7.3
```

### Dropbox

Source: https://help.dropbox.com/installs-integrations/desktop/linux-commands

Add the following line to /etc/apt/sources.list/d/various.list, and replace xenial with your build's name below.

	sudo vim /etc/apt/sources.list.d/various.list
	deb https://linux.dropbox.com/ubuntu xenial main

Import our GPG keys into your apt repository, perform the following command from your terminal shell:

	sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 1C61A2656FB57B7E4DE0F4C1FC918B335044912E

	sudo apt update

	sudo apt install dropbox
	sudo apt install thunar-dropbox-plugin
	
Start Dropbox, installeer proprietary daemon en log in.

### Youtube-dl

	sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
	sudo chmod a+rx /usr/local/bin/youtube-dl


### nerd fonts

Source: https://www.nerdfonts.com/

	# Hack nerd font:
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
	
Extract fonts from zipfile to ```$HOME/.fonts

### oh-my-posh

Source: https://ohmyposh.dev/docs/linux

Posh installation:

	sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
	sudo chmod +x /usr/local/bin/oh-my-posh
	
Themes download:

	mkdir ~/.poshthemes
	wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
	unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
	chmod u+rw ~/.poshthemes/*.json
	rm ~/.poshthemes/themes.zip
	
Preview files:

	for file in ~/.poshthemes/*.omp.json; do echo "$file\n"; oh-my-posh --config $file --shell universal; echo "\n"; done;
	

### Visual studio Code

Source: https://code.visualstudio.com/docs/setup/linux

Copy package from https://go.microsoft.com/fwlink/?LinkID=760868

Then install with:

	sudo apt install ./code_1.56.2-1620838498_amd64.deb

### Atomic wallet

Source: https://atomicwallet.io

https://get.atomicwallet.io/download/atomicwallet.deb

Then install with:

	sudo apt install ./atomicwallet.deb 

### Electrum wallet

Source: https://electrum.org

Download: https://download.electrum.org/4.1.2/electrum-4.1.2-x86_64.AppImage

Make executable and run.

Or install from Python sources:

Install dependencies: 	sudo apt-get install python3-pyqt5 libsecp256k1-0 python3-cryptography
Download package: 		wget https://download.electrum.org/4.1.2/Electrum-4.1.2.tar.gz
Verify signature: 		wget https://download.electrum.org/4.1.2/Electrum-4.1.2.tar.gz.asc
Get public key:			wget https://raw.githubusercontent.com/spesmilo/electrum/master/pubkeys/ThomasV.asc
Import the key: 		gpg --import ThomasV.asc
Verify signature2:		gpg --verify Electrum-4.1.2.tar.gz.asc

```
gpg: assuming signed data in 'Electrum-4.1.2.tar.gz'
gpg: Signature made do 08 apr 2021 15:47:30 CEST
gpg:                using RSA key 6694D8DE7BE8EE5631BED9502BD5824B7F9470E6
gpg: Good signature from "Thomas Voegtlin (https://electrum.org) <thomasv@electrum.org>" [unknown]
gpg:                 aka "ThomasV <thomasv1@gmx.de>" [unknown]
gpg:                 aka "Thomas Voegtlin <thomasv1@gmx.de>" [unknown]
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: 6694 D8DE 7BE8 EE56 31BE  D950 2BD5 824B 7F94 70E6
```

Run without installing: 
As root:	
	tar -xvf Electrum-4.1.2.tar.gz
	mv Electrum-4.1.2 /opt/
	ln -s /opt/Electrum-4.1.2/run_electrum /usr/bin/run_electrum
	python3 -m pip install --upgrade requests
As user:
	run_electrum

Install with PIP: 	
	sudo apt-get install python3-setuptools python3-pip
	python3 -m pip install --user Electrum-4.1.2.tar.gz


### Overige pakketten

	sudo apt install keepassx mc ranger stow veracrypt

### Gufw Firewall configuratie

	Profile: Thuis
	Status: On
	Incoming: Weigeren
	Outgoing: Toestaan

### Adding the old SSH servers

	mkdir .ssh

Copy saved id_rsa, id_rsa.pub known_hosts & known_hosts.old to .ssh
id_rsa should be the most secret file there is! It is your access key.
The id_rsa.pub key is copied to the server.

	chmod go-r *

## Ubuntu 

### How to set up the wireless controller on Ubuntu after Installation

Get connected to a wire and type the following:

```bash
sudo apt update
sudo apt install firmware-b43-installer
```


### How to change Ubuntu dark theme
#### Step 1. Install Gnome Tweaks

Open terminal and install gnome tweak tools using the command below.

```bash
sudo -s
apt install -y gnome-tweaks
apt-get install gnome-tweak-tool
```

Open gnome tweaks control panel using command:-

```bash
gnome-tweaks
```

#### Step 2. Change Theme

Under appearance section, select theme as Adwaita-dark theme.

#### Step 3. Change Background

To change background, go to Setting >> Background and select black color.

### Ubuntu 18.04 top bar verwijderen of aanpassen.
Installeer eerst de gnome shell extensions:

```bash
sudo apt install gnome-shell-extensions
```

Ga daarna naar ``Ubuntu software > All > Add-ons``

Type "Hide top bar" (kan even duren voordat software center reageert).

Installeer deze.

Daarna ben je klaar. De ruimte die de top bar inneemt is nu beschikbaar voor applicaties.

[top bar installatie](images/Screenshot from 2019-10-17 18-47-49.png)

[top bar image](images/Screenshot from 2019-10-17 18-48-06.png)

Er is ook de optie "Hide top panel" deze verwijderd de top bar permanent (in tegenstelling tot hide top bar. Deze toont de bar als programma's kleiner zijn dan het volledige scherm.)

## Installing the best Gnome extensions for Ubuntu 18.04

Andere Gnome desktop extensies die ik voorlopig gebruik zijn:

* Dash to dock
* Pomodoro timer
* Cafeine
* Clipboard indicator
* Pall-color picker
* Refresh Wi-Fi Connections
* Coverflow alt-tab

Deze zijn allemaal op dezelfde wijze te installeren als "Hide top bar" nadat de gnome-shell-extensions zijn geinstalleerd.

## Connecting to a SSH server on the local network in Ubuntu

Open terminal venster en type het volgende commando:

```bash
bas@naboo:~$ ssh -p 2222 bas@192.168.1.111
```

If you use a keyfile, you should use this instead (nog te bevestigen).

```bash
ssh -p 1122 -i path/to/pemfile user@[hostip/hostname]
```

### Installing Stack software on Ubuntu 18.04

Afkomstig van [transip stack](https://mirror.transip.net/stack/linux/).

De repository en de client zijn in 64-bit versies beschikbaar, voer het volgende uit om de TransIP STACK client repository toe te voegen aan jouw OS:

```bash
echo 'deb http://mirror.transip.net/stack/software/deb/Ubuntu_18.04/ ./' | sudo tee /etc/apt/sources.list.d/stack-client.list
```

Hierna zul je TransIP's repository-key aan apt moeten toevoegen. Realiseer je dat de eigenaar van de key updates, pakketten en repositories kan distribueren die je systeem zal vertrouwen (meer informatie). Om de key toe te voegen en de repository in te laden, voer je volgende commando's uit:

```bash
wget -O - https://mirror.transip.net/stack/release.key | sudo apt-key add - 
sudo apt-get update
```

Installeer de STACK client zelf door het volgende commando uit te voeren:

```bash
sudo apt-get install stack-client
```

### Screenshots/casts in Unity

**Screenshots**

* ``Prt Scrn`` to take a screenshot of the desktop.
* ``Alt+Prt Scrn`` to take a screenshot of a window.
* ``Shift+Prt Scrn`` to take a screenshot of an area you select.

**Screencasts**

Press Ctrl+Alt+Shift+R to start recording what is on your screen.

A red circle is displayed in the top right corner of the screen when the recording is in progress.

Once you have finished, press Ctrl+Alt+Shift+R again to stop the recording.

The video is automatically saved in your Videos folder in your home folder, with a file name that starts with Screencast and includes the date and time it was taken.

### Fix connection issues with Nano ledger S

From: https://support.ledger.com/hc/en-us/articles/115005165269-Fix-connection-issues

In Linux you need to create a set of udev rules to allow device access. Refer to the Chrome USB API documentation for details. Please follow the instructions below.

1. Add the udev rules

    Enter the following command to automatically add the rules and reload udev:

    wget -q -O - https://raw.githubusercontent.com/LedgerHQ/udev-rules/master/add_udev_rules.sh | sudo bash

    Retry connecting your Ledger Nano S with Ledger Live.

    If it's still not working, continue to step 3: troubleshooting.

2. Troubleshooting

Try each of the following three options. 
```
    Option 1
    Edit the file /etc/udev/rules.d/20-hw1.rules file by adding the OWNER="<user>" parameter to each line, where <user> is your Linux user name.
    Then reload the rules as follows:

    udevadm trigger
    udevadm control --reload-rules

    Retry the connection with Ledger Live. If it does not work, try the next option.
    Option 2
    Edit the /etc/udev/rules.d/20-hw1.rules file and add the following lines:

    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="plugdev", ATTRS{idVendor}=="2c97"

    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="plugdev", ATTRS{idVendor}=="2581"

    Then reload the rules:

    udevadm trigger
    udevadm control --reload-rules

    Retry connecting with Ledger Live. If it does not work yet, try the last option.
    Option 3
    If you are on Arch Linux, you can try the following rules:

    /etc/udev/rules.d/20-hw1.rules

    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="1b7c", MODE="0660", TAG+="uaccess", TAG+="udev-acl"

    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="2b7c", MODE="0660", TAG+="uaccess", TAG+="udev-acl"

    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="3b7c", MODE="0660", TAG+="uaccess", TAG+="udev-acl"

    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="4b7c", MODE="0660", TAG+="uaccess", TAG+="udev-acl"

    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="1807", MODE="0660", TAG+="uaccess", TAG+="udev-acl"

    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="1808", MODE="0660", TAG+="uaccess", TAG+="udev-acl"

    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="0000", MODE="0660", TAG+="uaccess", TAG+="udev-acl"

    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="0001", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
     SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="0004", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
     SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="1011", MODE="0660", GROUP="plugdev"
     SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="1015", MODE="0660", GROUP="plugdev" 

    Then reload the rules again and retry the connection with Ledger Live:

    udevadm trigger
    udevadm control --reload-rules


    Still not working after following all the steps correctly? Please contact Ledger Support.
```
