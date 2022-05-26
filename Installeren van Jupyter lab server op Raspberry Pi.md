# Installeren van Jupyter lab server op Raspberry Pi

Bronnen:

* https://towardsdatascience.com/setup-your-home-jupyterhub-on-a-raspberry-pi-7ad32e20eed
* https://medium.com/analytics-vidhya/jupyter-lab-on-raspberry-pi-22876591b227
* https://blog.domski.pl/jupyter-notebook-server-on-raspberry-pi/

## Python aanpassen

``python`` verwijst nu naar Python versie 2. Dat wordt veranderd naar versie 3 door:

```
# python --version
Python 2.7.16

# whereis python3
python3: /usr/bin/python3.7m-config /usr/bin/python3.7m /usr/bin/python3.7-config /usr/bin/python3 /usr/bin/python3.7 /usr/lib/python3 /usr/lib/python3.7 /etc/python3 /etc/python3.7 /usr/local/lib/python3.7 /usr/include/python3.7m /usr/include/python3.7 /usr/share/python3 /usr/share/man/man1/python3.1.gz

# ls -alh pyt*
lrwxrwxrwx 1 root root    7 Mar  4  2019 python -> python2
lrwxrwxrwx 1 root root    9 Mar  4  2019 python2 -> python2.7
-rwxr-xr-x 1 root root 2.9M Oct 11  2019 python2.7
lrwxrwxrwx 1 root root    9 Mar 26  2019 python3 -> python3.7
```

Symbolic links aanpassen

```
# rm /usr/bin/python
# ln -s /usr/bin/python3.7 /usr/bin/python


# ls -alh pyt*
lrwxrwxrwx 1 root root   18 Nov 13 11:00 python -> /usr/bin/python3.7
lrwxrwxrwx 1 root root    9 Mar  4  2019 python2 -> python2.7
-rwxr-xr-x 1 root root 2.9M Oct 11  2019 python2.7
lrwxrwxrwx 1 root root    9 Mar 26  2019 python3 -> python3.7

# python --version
Python 3.7.3
```

## Benodigde software installeren

Onderstaande software dient geinstalleerd te worden:

```
sudo apt-get update 
sudo apt-get install python3-pip 
sudo pip3 install --upgrade pip
```

### Jupyter lab

Installeren van Juppyter labs

```
pip3 install jupyterlab
```

Directory maken voor het opslaan van notebooks.

```
root@tatooine:/opt# cd /var
root@tatooine:/var# ls
agentx  backups  cache  lib  local  lock  log  mail  opt  run  spool  swap  tmp  www
root@tatooine:/var# mkdir notebooks
root@tatooine:/var# cd notebooks/
root@tatooine:/var/notebooks# 
```

Starten van Jupyter lab als test

```
jupyter lab --notebook-dir=/var/notebooks --allow-root
```

Programma start. Nu testen vanaf een externe PC. Daarvoor moet wel de firewall aangepast worden:

```root@tatooine:/var# ufw allow 8888/tcp
Rule added
Rule added (v6)

root@tatooine:/var# ufw status
Status: active

To                         Action      From
--                         ------      ----
Nginx HTTP                 ALLOW       Anywhere
8181/tcp                   ALLOW       Anywhere
8888/tcp                   ALLOW       Anywhere
```

### Setup Jupyter lab as a service

Run below command to locate your jupyter lab binary:

```
$ which jupyter-lab
/usr/local/bin/jupyter-lab
```

Create a file /etc/systemd/system/jupyter.service

```
$ sudo nano /etc/systemd/system/jupyter.service
```

With below content.

```
[Service]
ExecStart=/bin/bash -c "/usr/local/bin/jupyter-lab --ip="0.0.0.0" --no-browser --allow-root --notebook-dir=/var/notebooks"
Description=Jupyter Lab[Service]
Restart=always
RestartSec=10
StandardOutput=syslog
StandardError=syslog
User=root
Group=root
Type=simple
PIDFile=/run/jupyter.pid
WorkingDirectory=/var/notebooks

[Install]
WantedBy=multi-user.target
```

Enable the service to start it whenever the raspberry pi boots

```
# chmod ugo+x /etc/systemd/system/jupyter.service 
# systemctl enable jupyter.service

Created symlink /etc/systemd/system/multi-user.target.wants/jupyter.service → /etc/systemd/system/jupyter.service.

# systemctl daemon-reload
```

Start the service:

```
# systemctl start jupyter.service
```

You can also stop the service using command:

```
# systemctl stop jupyter.service
```

Check the status of the service:

```
 systemctl status jupyter.service

● jupyter.service
   Loaded: loaded (/etc/systemd/system/jupyter.service; enabled; vendor preset: enabled)
   Active: active (running) since Fri 2020-11-13 11:41:45 CET; 5s ago
 Main PID: 2761 (jupyter-lab)
    Tasks: 8 (limit: 2200)
   Memory: 53.0M
   CGroup: /system.slice/jupyter.service
           ├─2761 /usr/bin/python3 /usr/local/bin/jupyter-lab --ip=0.0.0.0 --no-browser --allow-root --notebook-dir=/var/notebooks
           └─2775 /usr/bin/node /usr/local/lib/python3.7/dist-packages/jupyterlab/staging/yarn.js config list --json

Nov 13 11:41:45 tatooine systemd[1]: Started jupyter.service.
```

Login on http://192.168.1.2:8888/login?next=%2Flab%3F also works !

### Setting a password

To set a password,do the following:

Check to see if you have a notebook configuration file,jupyter_notebook_config.py. The default location for this file is your Jupyter folder located in your home directory:

```
/root/.jupyter/jupyter_notebook_config.py
```

If you don’t already have a Jupyter folder, or if your Jupyter folder doesn’t contain a notebook configuration file, run the following command:

```
root@tatooine:~# jupyter notebook --generate-config
Writing default config to: /root/.jupyter/jupyter_notebook_config.py
root@tatooine:~# jupyter notebook password
Enter password: 
Verify password: 
[NotebookPasswordApp] Wrote hashed password to /root/.jupyter/jupyter_notebook_config.json
```

This can be used to reset a lost password; or if you believe your credentials have been leaked and desire to change your password. Changing your password will invalidate all logged-in sessions after a server restart.

![Jupyter server on tatooine](./images/Jupyter-server.png)

## Disable the terminal

Seeing this, there is a HUUUGGEE security gap. It seems that you can open a terminal screen to the server. And I'm running it as root. This does not seem right...

So what I did, I changed all the references to root to the user I normally log in to.

```
[Service]
ExecStart=/bin/bash -c "/usr/local/bin/jupyter-lab --ip="0.0.0.0" --no-browser --notebook-dir=/home/bas/notebooks"
Description=Jupyter Lab[Service]
Restart=always
RestartSec=10
StandardOutput=syslog
StandardError=syslog
User=bas
Group=bas
Type=simple
PIDFile=/run/jupyter.pid
WorkingDirectory=/home/bas/notebooks

[Install]
WantedBy=multi-user.target
```

Restart server

```
bas@tatooine:~ $ jupyter-notebook --generate-config
Writing default config to: /home/bas/.jupyter/jupyter_notebook_config.py
bas@tatooine:~ $ jupyter-notebook password         
Enter password: 
Verify password: 
[NotebookPasswordApp] Wrote hashed password to /home/bas/.jupyter/jupyter_notebook_config.json

```

## Errors

I encountered an error when running matplotlib

``ImportError: libopenjp2.so.7: cannot open shared object file: No such file or directory``

Solved it by installing:

```
sudo apt-get install libopenjp2-7
```
