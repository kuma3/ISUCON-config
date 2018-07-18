#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# make a directory for backup
mkdir ~/backup

# create shimamon and simamon commands
# shimamonがいなかったら書き込む
if ! grep -q "shimamon" ~/.bash_profile 2>/dev/null; then
  cat ~/config/bash_profile >> ~/.bash_profile;
fi

# make mysql and nginx backup
cd ${SCRIPT_DIR}
make backup-all

# editor
sudo apt install -y emacs vim

# alp
sudo apt install -y unzip
cd /tmp
wget https://github.com/tkuchiki/alp/releases/download/v0.3.1/alp_linux_amd64.zip
unzip alp_linux_amd64
sudo mv -f alp /usr/local/bin/
rm -f alp_linux_amd64.zip

# pt-query
sudo apt install -y libdbd-mysql-perl libdbi-perl libio-socket-ssl-perl libnet-ssleay-perl
cd /tmp
wget https://www.percona.com/downloads/percona-toolkit/3.0.4/binary/debian/xenial/x86_64/percona-toolkit_3.0.4-1.xenial_amd64.deb
sudo dpkg -i percona-toolkit_3.0.4-1.xenial_amd64.deb
rm -f percona-toolkit_3.0.4-1.xenial_amd64.deb

# htop
sudo apt install -y htop

# restart services
cd ${SCRIPT_DIR}
make restart

