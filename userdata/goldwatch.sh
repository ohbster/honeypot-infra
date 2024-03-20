#!/bin/bash
    apt update -y
    apt install apache2 -y
    apt install php libapache2-mod-php php-mysql -y
    apt install jq -y
    systemctl enable apache2
    systemctl start apache2

    cat <<EOF > /var/www/html/index.html &
<html>
    <body>
    <h1>We must stay focused, my brothers!!!</h1><br/>
    <video width="406" height="720" autoplay controls loop>
        <source src="https://ohbster-homework-bucket.s3.amazonaws.com/dance.mp4" type="video/mp4">
    </video>
    <br/><h1>Stay focused Theo's class</h1>
    <div>
        <p><b>Instance Name:</b> $(hostname -f) </p>
        <p><b>Instance Private Ip Address: </b> $(curl -s -H Metadata:true --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2021-02-01" | jq '.network.interface[0].ipv4.ipAddress[0].privateIpAddress')</p>
        <p><b>Availability Zone: </b> $(curl -s -H Metadata:true --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2021-02-01" | jq '.compute.zone')</p>
        <p><B>$(cat /etc/os-release)</p>
    </div>
    </body>
</html>
EOF
wait

echo 'echo <?php "hello world" ?>' >> /var/www/html/test.php      
            # #Create www group and make /var/www writable to www group
            # groupadd www
            # usermod -a -G www ubuntu
            # #chown -R root:www /var/www
            # chown -R root:www /var/www #will colon cause problem in yaml?
            # chmod 2775 /var/www
            # find /var/www -type d -exec sudo chmod 2775 {} +
            # find /var/www -type f -exec sudo chmod 0664 {} +
            # #goldwatch setting directery
            # mkdir /etc/goldwatch
            # chown root:apache goldwatch
            # chmod 755 goldwatch
            # echo '[{"hostname":"x", "dbname":"x", "username":"x","password":"x" }]' | cat > dbconfig.json
            # chmod 640 /etc/goldwatch/dbconfig.json
            
            # #install composer for php
            # php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
            # php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
            # php composer-setup.php
            # php -r "unlink('composer-setup.php');"
            # mv composer.phar /usr/local/bin/composer
            # cd /var/www/html
            # composer require aws/aws-sdk-php
            
       