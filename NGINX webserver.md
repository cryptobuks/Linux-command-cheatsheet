# NGINX webserver
This page information about the NGINX lightweight webserver.

Om een wiki te hosten maak ik gebruik van een combinatie van nginx en [MDWiki](http://dynalon.github.io/mdwiki/#!index.md). MDWiki kan op elke willekeurige simpele webspace gebruikt worden en daarom heb ik voor een lichtgewicht als NGINX gekozen.

## Nginx installation
```
sudo apt-get update
sudo apt-get install nginx
```

## Firewall configuration
```
sudo ufw app list
# only allow http traffic
sudo ufw allow 'Nginx HTTP'
sudo ufw status
```

Check the status of the server:
```
systemctl status nginx
```

### Manage the Nginx service
Stop the webserver:
```
sudo systemctl stop nginx
```
start the webserver:
```
sudo systemctl start nginx
```
Restart the webserver:
```
sudo systemctl restart nginx
```
Reload the webserver configuration without restart:
```
sudo systemctl reload nginx
```
Disable starting the webserver at system boot:
```
sudo systemctl disable nginx
```
Enable starting the webserver at system boot:
```
sudo systemctl enable nginx
```

## Important files and directories
Content
```
/var/www/html
```
The actual web content, which by default only consists of the default Nginx page you saw earlier, is served out of the /var/www/html directory. This can be changed by altering Nginx configuration files.

Server Configuration
```
/etc/nginx
```
The Nginx configuration directory. All of the Nginx configuration files reside here.
```
/etc/nginx/nginx.conf
```
The main Nginx configuration file. This can be modified to make changes to the Nginx global configuration.
```
/etc/nginx/sites-available/
```
The directory where per-site “server blocks” can be stored. Nginx will not use the configuration files found in this directory unless they are linked to the sites-enabled directory (see below). Typically, all server block configuration is done in this directory, and then enabled by linking to the other directory.
```
/etc/nginx/sites-enabled/
```
The directory where enabled per-site “server blocks” are stored. Typically, these are created by linking to configuration files found in the sites-available directory.
```
/etc/nginx/snippets
```
This directory contains configuration fragments that can be included elsewhere in the Nginx configuration. Potentially repeatable configuration segments are good candidates for refactoring into snippets.

Server Logs
```
/var/log/nginx/access.log
```
Every request to your web server is recorded in this log file unless Nginx is configured to do otherwise.
```
/var/log/nginx/error.log
```
Any Nginx errors will be recorded in this log.
