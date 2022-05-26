#!/usr/bin/env bash
set -euo pipefail

# This script downloads, compiles, and installs python3.8 as the system default

export VERSION=3.8.5

apt install -y       \
    build-essential  \
    libbz2-dev       \
    libffi-dev       \
    liblzma-dev      \
    libncurses5-dev  \
    libncursesw5-dev \
    libreadline-dev  \
    libsqlite3-dev   \
    libssl-dev       \
    llvm             \
    python-openssl   \
    python-pip       \
    tk-dev           \
    xz-utils         \
    zlib1g-dev

export OLD_PIP=$(which pip)
export NEW_PIP=${OLD_PIP}2.7

mv ${OLD_PIP} ${NEW_PIP}
ln -s ${NEW_PIP} ${OLD_PIP}

export PYENV_ROOT=/etc/pyenv
export PATH="$PYENV_ROOT/bin:$PATH"

if [[ -d "${PYENV_ROOT}" ]]; then
    rm -rfv -- "${PYENV_ROOT}"
fi

git clone https://github.com/pyenv/pyenv.git ${PYENV_ROOT}

# Can't fit in /tmp because it's a ramfs
export TMPDIR=${PYENV_ROOT}/tmp
mkdir ${TMPDIR}

# The latest version as of now
echo "Setting system python to ${VERSION}. This may take several minutes..."
CFLAGS="-O2" TMPDIR=${TMPDIR} pyenv install ${VERSION}

rm -rf -- "${TMPDIR}"

# Set the global version
pyenv global ${VERSION}

# Latest
update-alternatives --install $(which python) python /etc/pyenv/versions/${VERSION}/bin/python 1
update-alternatives --install $(which pip) pip /etc/pyenv/versions/${VERSION}/bin/pip 1

# 2.7
update-alternatives --install $(which python) python /usr/bin/python2.7 2
update-alternatives --install $(which pip) pip /usr/bin/pip2.7 2

# Lastly, set the system python to our new version
update-alternatives --set python /etc/pyenv/versions/${VERSION}/bin/python
update-alternatives --set pip /etc/pyenv/versions/${VERSION}/bin/pip

pip install -U pip

cat <<"HELP"

Python${VERSION} is now your system default.

If you want to roll your system back to 2.7, simply run:

    sudo update-alternatives --set python /usr/bin/python2.7
    sudo update-alternatives --set pip /usr/bin/pip2.7

HELP
