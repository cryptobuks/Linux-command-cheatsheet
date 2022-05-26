## Installing and configuring SNMP

Follow the installation instructions to install and configure an snmp daemon:

```
sudo apt-get install snmp sudo apt-get install snmpd
sudo cp /etc/snmp/snmpd.conf{,.org}
sudo nano /etc/snmp/snmpd.conf
```

insert the following [snmpd.conf](http://192.168.1.2/wiki/./linux/././conf/snmpd.conf)

```
sudo service snmpd status
sudo service snmpd stop
sudo service snmpd start
```

If everything is correctly set up, you can walk the snmp tree, or specific interface value with:

```
snmpwalk -v 1 -c veronagroen localhost
snmpget -v 1 -c veronagroen localhost .1.3.6.1.2.1.25.2.3.1.6.1
```

Configure the firewall for snmp gets from a server

```
sudo ufw allow 161/udp
sudo ufw status
```

To test snmp from a remote server use:

```
snmpwalk -v 1 -c veronagroen 192.168.1.64
snmpget -v 1 -c veronagroen 192.168.1.64 1.3.6.1.2.1.2.2.1.10.1
```

Install the mibs with:

```
sudo apt-get install snmp-mibs-downloader
sudo snmpwalk -Dparse-mibs -c public -v 1 localhost
```
