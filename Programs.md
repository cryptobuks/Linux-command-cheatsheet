This file is a remake of older installer instructions.

# Installing programs on Fedora

## Packages

### Visual studio code

See https://code.visualstudio.com/docs/setup/linux#_rhel-fedora-and-centos-based-distributions

Add repository

```
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
```

Update repository and install VS Code

```
dnf check-update
sudo dnf install code
```

Or with yum on older systems:

```
yum check-update
sudo yum install code
```

### Dropbox

Download .deb or .rpm from following site:

[https://www.dropbox.com/install](https://www.dropbox.com/install)

## Other installations

