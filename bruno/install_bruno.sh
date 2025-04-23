#!/usr/bin/env bash
set -ex

# Install Bruno
mkdir -p /home/kasm-default-profile/.gnupg
gpg --no-default-keyring --keyring /etc/apt/keyrings/bruno.gpg --keyserver keyserver.ubuntu.com --recv-keys 9FA6017ECABE0266
echo "deb [signed-by=/etc/apt/keyrings/bruno.gpg] http://debian.usebruno.com/ bruno stable" | sudo tee /etc/apt/sources.list.d/bruno.list
apt-get update
apt-get install -y bruno
rm -rf \
  /var/lib/apt/lists/* \
  /var/tmp/*

# Default settings and desktop icon
# mkdir -p $HOME/.bruno-data/
# cp /dockerstartup/install/bruno/bruno.cfg $HOME/.bruno-data/
cp /usr/share/applications/bruno.desktop $HOME/Desktop/
chmod +x $HOME/Desktop/bruno.desktop

# Cleanup for app layer
chown -R 1000:0 $HOME
find /usr/share/ -name "icon-theme.cache" -exec rm -f {} \;
if [ -z ${SKIP_CLEAN+x} ]; then
  apt-get autoclean
  rm -rf \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*
fi