#!/bin/bash
apt update -y && apt upgrade -y
apt install git -y
git clone https://github.com/telekom-security/tpotce.git

cd  ./tpotce
sudo ./install.sh --type=user -y