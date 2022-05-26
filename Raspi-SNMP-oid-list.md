http://www.net-snmp.org/docs/mibs/ucdavis.html

https://www.debianadmin.com/linux-snmp-oids-for-cpumemory-and-disk-statistics.html

http://www.oidview.com/mibs/2021/UCD-SNMP-MIB.html

## Raspberri Pi

CPU Load : snmpwalk -v2c -c veronagroen 192.168.1.2 .1.3.6.1.4.1.2021.11.11.0
iso.3.6.1.4.1.2021.11.11.0 = INTEGER: 92

- **CPU Load - Last 1 Minute - %**
    - OID: 1.3.6.1.4.1.2021.10.1.3.1
- **CPU Load - Last 5 Minutes - %**
    - OID: 1.3.6.1.4.1.2021.10.1.3.2
- **Total RAM Free**
    - OID: 1.3.6.1.4.1.2021.4.11.0
- **Total RAM in machine - kB**
    - OID: 1.3.6.1.4.1.2021.4.5.0
- **Percentage of space used on disk**
    - OID: 1.3.6.1.4.1.2021.9.1.9.1

## Linux SNMP OID’s for CPU,Memory and Disk Statistics

 CPU Statistics

Load
1 minute Load: .1.3.6.1.4.1.2021.10.1.3.1
5 minute Load: .1.3.6.1.4.1.2021.10.1.3.2
15 minute Load: .1.3.6.1.4.1.2021.10.1.3.3

CPU
percentage of user CPU time: .1.3.6.1.4.1.2021.11.9.0
raw user cpu time: .1.3.6.1.4.1.2021.11.50.0
percentages of system CPU time: .1.3.6.1.4.1.2021.11.10.0
raw system cpu time: .1.3.6.1.4.1.2021.11.52.0
percentages of idle CPU time: .1.3.6.1.4.1.2021.11.11.0
raw idle cpu time: .1.3.6.1.4.1.2021.11.53.0
raw nice cpu time: .1.3.6.1.4.1.2021.11.51.0

Memory Statistics

Total Swap Size: .1.3.6.1.4.1.2021.4.3.0
Available Swap Space: .1.3.6.1.4.1.2021.4.4.0
Total RAM in machine: .1.3.6.1.4.1.2021.4.5.0
Total RAM used: .1.3.6.1.4.1.2021.4.6.0
Total RAM Free: .1.3.6.1.4.1.2021.4.11.0
Total RAM Shared: .1.3.6.1.4.1.2021.4.13.0
Total RAM Buffered: .1.3.6.1.4.1.2021.4.14.0
Total Cached Memory: .1.3.6.1.4.1.2021.4.15.0

Disk Statistics

The snmpd.conf needs to be edited. Add the following (assuming a machine with a single ‘/’ partition):

disk / 100000 (or)

includeAllDisks 10% for all partitions and disks

The OIDs are as follows

Path where the disk is mounted: .1.3.6.1.4.1.2021.9.1.2.1
Path of the device for the partition: .1.3.6.1.4.1.2021.9.1.3.1
Total size of the disk/partion (kBytes): .1.3.6.1.4.1.2021.9.1.6.1
Available space on the disk: .1.3.6.1.4.1.2021.9.1.7.1
Used space on the disk: .1.3.6.1.4.1.2021.9.1.8.1
Percentage of space used on disk: .1.3.6.1.4.1.2021.9.1.9.1
Percentage of inodes used on disk: .1.3.6.1.4.1.2021.9.1.10.1

System Uptime: .1.3.6.1.2.1.1.3.0
