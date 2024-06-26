#!/bin/bash
#SET the web password from inside terraform
#user webuser
WEBPASS='myrandomstring!@!' # TODO: need to pull this value from secrets. 
WORKDIR="/root"
sudo apt-get update

# Ignore any intereactive dialog when doing upgrade
# sudo DEBIAN_FRONTEND=noninteractive sh -c 'echo $DEBIAN_FRONTEND'
DEBIAN_FRONTEND=noninteractive sudo apt-get upgrade -yq 

#install git
sudo apt install git -y && \

sudo apt install -y nginx  && \
sudo cat <<EOF > /var/www/html/index.html
<html><body>
<h1>Hello, Class 5.5</h1>
<br/>
Hostname: $(curl "http://metadata.google.internal/computeMetadata/v1/instance/hostname" -H "Metadata-Flavor: Google")
<br/>
Instance ID: $(curl "http://metadata.google.internal/computeMetadata/v1/instance/id" -H "Metadata-Flavor: Google")
<br/>
Project ID: $(curl "http://metadata.google.internal/computeMetadata/v1/project/project-id" -H "Metadata-Flavor: Google")
<br/>
Zone ID: $(curl "http://metadata.google.internal/computeMetadata/v1/instance/zone" -H "Metadata-Flavor: Google")
<br/>
Click Here: <a href="https://$(curl "http://metadata/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip" -H "Metadata-Flavor: Google"):64297">Free honey</a>
<br/>User: webuser

</body></html>
EOF

# work from the home directory and clone tpot
#cd $ADMINHOME
cd $WORKDIR
git clone https://github.com/telekom-security/tpotce.git && \

# make a copy of the default tpot.conf file. 
#cp ./tpotce/iso/installer/tpot.conf.dist ./tpot.conf
cp $WORKDIR/tpotce/iso/installer/tpot.conf.dist $WORKDIR/tpot.conf && \
# set the password to random string generated by terraform
sed "s/myCONF_WEB_PW[^ ]*/myCONF_WEB_PW='$WEBPASS'/g" -i $WORKDIR/tpot.conf && \

sudo cd $WORKDIR/tpotce
sudo ./install.sh --type=auto --conf="$WORKDIR/tpot.conf" && \
sudo systemctl start tpot && \
sudo systemctl enable tpot && \
sudo rm $WORKDIR/tpot.conf && \
sudo /sbin/reboot

