#!/bin/bash
sudo apt-get update

# Ignore any intereactive dialog when doing upgrade
# sudo DEBIAN_FRONTEND=noninteractive sh -c 'echo $DEBIAN_FRONTEND'
DEBIAN_FRONTEND=noninteractive sudo apt-get upgrade -yq 

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
</body></html>
EOF