sudo apt-get update
sudo apt-get install -y build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libffi-dev

wget https://www.python.org/ftp/python/3.8.0/Python-3.8.0.tar.xz
tar xf Python-3.8.0.tar.xz
cd Python-3.8.0
./configure --prefix=/usr/local/opt/python-3.8.0
make -j 4

sudo make install

cd ..
sudo rm -r Python-3.8.0
rm Python-3.8.0.tar.xz
. ~/.bashrc

sudo update-alternatives --config python

python -V

=======================

First install the dependencies needed to build:

sudo apt-get update
sudo apt-get install -y build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libffi-dev

Compile (yes… it takes a while, grab a coffee and get me one to!!)

wget https://www.python.org/ftp/python/3.8.0/Python-3.8.0.tar.xz
tar xf Python-3.8.0.tar.xz
cd Python-3.8.0
./configure --enable-optimizations --prefix=/usr
make

Let’s install what was compiled!

sudo make altinstall

And remove the files you don’t need anymore

cd ..
sudo rm -r Python-3.8.0
rm Python-3.8.0.tar.xz
. ~/.bashrc

And yes!!! Let’s make Python 3.8 the default version, make aliases

sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.8 1

And verify:

python -V

Your are ready to go!
