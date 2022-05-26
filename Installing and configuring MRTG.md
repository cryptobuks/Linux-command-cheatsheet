## Installing and configuring MRTG

In deze instructie ga ik ervan uit dat [NGINX reeds geinstalleerd](#!./linux/././nginx-webservice.md) is.

On the raspberry type:

```
sudo apt-get install mrtg

# When asked if the mrtg.cfg file should only be readable by root, choose 'yes'.
```

For a full listing of what MRTG installs and where, run the locate command:

```
sudo updatedb && locate mrtg
```

Technically speaking, mrtg.cfg could remain in /etc, but just to keep things tidy let’s create a directory for it and move it into that directory:

```
sudo mkdir /etc/mrtg && sudo mv /etc/mrtg.cfg /etc/mrtg
```

MRTG includes a script called cfgmaker that will help us populate /etc/mrtg/mrtg.cfg with the information obtained from your gateway\\router.

*Note: My config is below...*

```
sudo cfgmaker --output=/etc/mrtg/mrtg.cfg public@your-router's-IP-address

# In mijn geval:

/usr/bin/cfgmaker --global "WorkDir: /var/www/html/mrtg" --output /etc/mrtg/mrtg.cfg veronagroen@127.0.0.1
```

```
--base: Get Device Info on veronagroen@127.0.0.1:
--base: Vendor Id: Unknown Vendor - 1.3.6.1.4.1.8072.3.2.10
--base: Populating confcache
--base: Get Interface Info
--base: Walking ifIndex
--snpd:   veronagroen@127.0.0.1: -> 1 -> ifIndex = 1
--snpd:   veronagroen@127.0.0.1: -> 2 -> ifIndex = 2
--snpd:   veronagroen@127.0.0.1: -> 3 -> ifIndex = 3
--base: Walking ifType
--snpd:   veronagroen@127.0.0.1: -> 1 -> ifType = 24
--snpd:   veronagroen@127.0.0.1: -> 2 -> ifType = 6
--snpd:   veronagroen@127.0.0.1: -> 3 -> ifType = 6
--base: Walking ifAdminStatus
--snpd:   veronagroen@127.0.0.1: -> 1 -> ifAdminStatus = 1
--snpd:   veronagroen@127.0.0.1: -> 2 -> ifAdminStatus = 1
--snpd:   veronagroen@127.0.0.1: -> 3 -> ifAdminStatus = 1
--base: Walking ifOperStatus
--snpd:   veronagroen@127.0.0.1: -> 1 -> ifOperStatus = 1
--snpd:   veronagroen@127.0.0.1: -> 2 -> ifOperStatus = 2
--snpd:   veronagroen@127.0.0.1: -> 3 -> ifOperStatus = 1
--base: Walking ifMtu
--snpd:   veronagroen@127.0.0.1: -> 1 -> ifMtu = 65536
--snpd:   veronagroen@127.0.0.1: -> 2 -> ifMtu = 1500
--snpd:   veronagroen@127.0.0.1: -> 3 -> ifMtu = 1500
--base: Walking ifSpeed
--snpd:   veronagroen@127.0.0.1: -> 1 -> ifSpeed = 10000000
--snpd:   veronagroen@127.0.0.1: -> 2 -> ifSpeed = 10000000
--snpd:   veronagroen@127.0.0.1: -> 3 -> ifSpeed = 0
--base: Writing /etc/mrtg/mrtg.cfg
```

However I use separate config files for separate devices. To insert my specific preconfigured config do:

```
cp mrtg.cfg{,.back.`date +'%F'`}
nano /etc/mrtg/mrtg.cfg
```

insert the following config:

```
# Created by
# /usr/bin/cfgmaker --global "WorkDir: /var/www/html/mrtg" --output /etc/mrtg/mrtg.cfg veronagroen@127.0.0.1
# See: https://oss.oetiker.ch/mrtg/doc/mrtg-reference.en.html
# for information about the configuration options

RunAsDaemon: Yes
Interval: 5
EnableIPv6: no
WorkDir: /var/www/html/mrtg
LogDir: /var/log/mrtg
HtmlDir: /var/www/html/mrtg
ImageDir: /var/www/html/mrtg
Options[_]: growright, bits
Timezone[_]: Europe/Amsterdam
TimeStrPos[_]: RU
TimeStrFmt[_]: %a %d %b %H:%M %Y
PageFoot[_]: These pages are for personal use. If you stumbled on these by accident, please leave.
SnmpOptions: timeout => 10
LoadMIBs: /var/lib/snmp/mibs/SYNOLOGY*
Language: dutch
Include: /etc/mrtg/bespin.cfg
Include: /etc/mrtg/ahch-to.cfg
Include: /etc/mrtg/yavin.cfg
Include: /etc/mrtg/connection.cfg
```

The other config files and scripts will be added later in this instruction.

Now it’s time to create the web pages which display the MRTG graphs using the indexmaker command. Run the following commands:

```
sudo mkdir /var/www/html/mrtg
chown -R root:root /var/www/html/mrtg
sudo indexmaker --output=/var/www/html/mrtg/index.html /etc/mrtg/mrtg.cfg
```

It can happen that you receive the following error:

```
ERROR: did not find any matching data in cfg file
```

This can happen when all the interfaces are commented out. So try to uncomment at least one interface.

Also, There’s something important to keep in mind when starting MRTG, and that is that MRTG requires the environmental variable “LANG” to be C in order to run properly. Since most Linux systems these days, including Ubuntu server, use UTF-8 (run echo $LANG to see what your system uses), let’s change LANG to C and start MRTG using the following command:

```
sudo env LANG=C /usr/bin/mrtg /etc/mrtg/mrtg.cfg
```

Okay, so now that we have MRTG installed, configured and running let’s move on and discuss how to keep it running. You can automate the process of running MRTG by using a startup script in your system startup sequence. Here’s the script that I use:

```
nano /etc/init.d/mrtg
```

Insert the following script from the file [mrtg](http://192.168.1.2/wiki/./linux/././conf/mrtg)

Make it executable with

```
chmod +x mrtg
```

Now, link the mrtg script to all of Ubuntu server’s multi-user run levels (2-5):

```
sudo update-rc.d mrtg defaults
```

Now, let’s start MRTG using our script. If it’s currently running then substitute restart for start in the following command:

```
sudo service mrtg start
```

That’s it. Now if for some reason your server is rebooted, MRTG should fire up automatically. If you would like to remove the MRTG script from the server’s multi-user run levels, use the command `sudo update-rc.d -f mrtg remove`).

## Changing the config and reloading the service to activate it

When changing the mrtg config (adding or removing devices and such), reload the mrtg service:

Get the snmp oid and its value from a host:

```
snmpwalk -v2c -c veronagroen 192.168.1.3 1.3.6.1.4.1.6574.6.1.1.2
iso.3.6.1.4.1.6574.6.1.1.2.1 = STRING: "CIFS"
iso.3.6.1.4.1.6574.6.1.1.2.2 = STRING: "AFP"
iso.3.6.1.4.1.6574.6.1.1.2.3 = STRING: "NFS"
iso.3.6.1.4.1.6574.6.1.1.2.4 = STRING: "FTP"
iso.3.6.1.4.1.6574.6.1.1.2.5 = STRING: "SFTP"
iso.3.6.1.4.1.6574.6.1.1.2.6 = STRING: "HTTP/HTTPS"
iso.3.6.1.4.1.6574.6.1.1.2.7 = STRING: "TELNET"
iso.3.6.1.4.1.6574.6.1.1.2.8 = STRING: "SSH"
iso.3.6.1.4.1.6574.6.1.1.2.9 = STRING: "OTHER"

snmpget -v2c -c veronagroen 192.168.1.3 1.3.6.1.4.1.2021.4.5.0
```

```
cp mrtg.cfg{,.back.`date +'%F'`}
nano /etc/mrtg/mrtg.cfg
```

Recreate the index:

```
sudo indexmaker --output=/var/www/html/mrtg/index.html /etc/mrtg/mrtg.cfg
```

Reload the service:

```
bas@bespin:/etc/mrtg $ sudo service mrtg stop
bas@bespin:/etc/mrtg $ sudo service mrtg start
bas@bespin:/etc/mrtg $ sudo service mrtg status
```

## Adding mrtg to NGINX as virtual website

Make a new file, named mrtg in the directory /etc/nginx/sites-available

```
cd /etc/nginx/sites-available
nano mrtg
```

Insert the config below:

```
server {
        # listen 80 default_server;
        #listen [::]:80 default_server;

        root /var/www/html/mrtg;
        index index.html;
        server_name _;
        location / {
                try_files $uri $uri/ =404;
        }
}
```

To enable the mrtg virtual site, make a symbolic link in the sites-enabled directory and restart the webserver:

```
cd /etc/nginx/sites-enabled
sudo ln -s /etc/nginx/sites-available/mrtg . service nginx restart
```

### MRTG scripts for non-snmp monitoring en multiple configs voor multiple hosts

You can make multiple config files for multiple devices to separate them from each other, which eases management of devices and configs. See the [mrtg.cfg](http://192.168.1.2/wiki/./linux/././conf/mrtg/mrtg.cfg) file for details.

Also there are some scripts that can monitor your server (not tried on external hosts) which can be run by mrtg and insert the data in a graph. See the [mrtg](http://192.168.1.2/wiki/./linux/././conf/mrtg/) directory in this wiki for more details on that.
