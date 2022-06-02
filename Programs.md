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

### Jupyter notebooks

More information is available on [https://fedoramagazine.org/jupyter-and-data-science-in-fedora/](https://fedoramagazine.org/jupyter-and-data-science-in-fedora/)

Install essential Jupyter packages with: 

```
sudo dnf install python3-notebook mathjax sscg
```

Install additional datascience packages with: 

```
sudo dnf install python3-seaborn python3-lxml python3-basemap python3-scikit-image python3-scikit-learn python3-sympy python3-dask+dataframe python3-nltk
```

Optional, set a password to log into the notebook interface:

```
$ mkdir -p $HOME/.jupyter
$ jupyter notebook password
```

Type a password for yourself. This will create the file $HOME/.jupyter/jupyter_notebook_config.json with your encrypted password.

Next, prepare for SSLby generating a self-signed HTTPS certificate for Jupyter’s web server: 

```
$ cd $HOME/.jupyter; sscg
```

Finish configuring Jupyter by editing your $HOME/.jupyter/jupyter_notebook_config.json file. Make it look like this:

```
{
   "NotebookApp": {
     "password": "sha1:abf58...87b",
     "ip": "*",
     "allow_origin": "*",
     "allow_remote_access": true,
     "open_browser": false,
     "websocket_compression_options": {},
     "certfile": "/home/[YOURNAME]/.jupyter/service.pem",
     "keyfile": "/home/[YOURNAME]/.jupyter/service-key.pem",
     "notebook_dir": "/home/[YOURNAME]/Notebooks"
   }
} 
```

Change [YOURNAME]. The password and service... keys are the crypto files made by sscg.

Create a folder for your notebook files, as configured in the notebook_dir setting above: 

```
mkdir $HOME/Notebooks
```

Now you are all set. Just run Jupyter Notebook from anywhere on your system by typing: 

```
jupyter notebook
```

Or add this line to your $HOME/.bashrc file to create a shortcut command called jn:

```
alias jn='jupyter notebook'
```

After running the command jn, access https://your-fedora-host.com:8888 from any browser on the network to see the Jupyter user interface. You’ll need to use the password you set up earlier. 

Other optional tools used by data scientists are:

* Numpy
* Pandas
* Matplotlib
* Plotly
* Seaborn
* StatsModels
* Scikit-learn
* XGBoost
* Imbalanced Learn
* NLTK
* SHAP
* Keras
* Tensorflow
* 

## Technical analysis packages

Pandas-ta

```
pip install pandas-ta
```

TA-lib

See also:

* https://pypi.org/project/TA-Lib/
* https://mrjbq7.github.io/ta-lib/install.html

Download [ta-lib-0.4.0-src.tar.gz](http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz) and:

```
$ untar and cd
$ ./configure --prefix=/usr
$ make
$ sudo make install
```
    If you build TA-Lib using make -jX it will fail but that's OK! Simply rerun make -jX followed by [sudo] make install.


## Other installations

