Source: https://youtu.be/kgdoVeyoO2E

## Installeren

```bash
# Install fail2ban
sudo apt update
sudo apt install fail2ban
cd /etc/fail2ban/
```

## Backup maken van conf en jail file

```
sudo cp fail2ban.conf{,.org}
sudo cp jail.conf{,.org}
```

Local files maken voor configuratiewijzigingen

```
sudo cp fail2ban.conf fail2ban.local
sudo cp jail.conf jail.local
```


## Aanpassingen in jail.local

Onderstaande wijzigingen worden in de Youtube video aangemerkt. Later volgen mijn eigen wijzigingen/aanpassingen waarschijnlijk...

```
ignoreip = 127.0.0.1/8 ::1 192.168.1.0/24

# If 5 tries happen within 7 minutesm then a 10 minute ban follows:
maxretry = 5
findtime  = 7m
bantime  = 10m
```

### Set sshd jail aan in fail2ban

```
#
# JAILS
#

#
# SSH servers
#

[sshd]

# To use more aggressive sshd modes set filter parameter "mode" in jail.local:
# normal (default), ddos, extra or aggressive (combines all).
# See "tests/files/logs/sshd" or "filter.d/sshd.conf" for usage example and details.
#mode   = normal
enabled = true
port    = ssh
logpath = %(sshd_log)s
backend = %(sshd_backend)s

```

Tip: zet alleen jails aan voor services die je gebruikt!

## Waar luistert / kijkt fail2ban naar op het moment

```
$ sudo fail2ban-client status
Status
|- Number of jail:	1
`- Jail list:	sshd

# sshd is waar fail2ban naar kijkt...

```

## fail2ban herstarten

```
sudo systemctl restart fail2ban.service
```

## Voorbeeld nginx fail2ban aanzetten

Zet enabled = true bij service die bewaakt moet worden

```
[nginx-http-auth]
enabled = true
port    = http,https
logpath = %(nginx_error_log)s
```

Herstart fail2ban

```
sudo systemctl restart fail2ban.service
```

Check fail2ban client

```
$ sudo fail2ban-client status
Status
|- Number of jail:	2
`- Jail list:	nginx-http-auth, sshd
```

## Andere toepassing voor jali.local file

Uit: https://www.youtube.com/watch?v=9cHspiqCdsM&list=WL&index=73

Omdat jail.local de configuraties van jail.conf overschrijft, kan er ook een geheel schone jail.conf aangemaakt worden. Daarbinnen kan dan per service aangegeven worden hoe fail2ban moet omgaan met foutieve logins (waarvoor dan een firewall rule wordt aangemaakt).

```
vim jail.local

# in het bestand
[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
findtime = 300
bantime = 3600
```

## Controleren van een ban en deze opheffen

met het volgende commando kun je zien of een ip adres gebanned is

```
fail2ban-client status sshd
```

Opheffen van een ban

```
fail2ban-client set sshd unbanip <ip-address>
```

