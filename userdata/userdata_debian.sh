#!/bin/bash
apt update -y
apt install apache2 -y
apt install jq -y
systemctl enable apache2
systemctl start apache2

TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/local-ipv4 &> /tmp/local_ipv4 &
curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/placement/availability-zone &> /tmp/az &
curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/ &> /tmp/macid &
wait
macid=$(cat /tmp/macid)
local_ipv4=$(cat /tmp/local_ipv4)
az=$(cat /tmp/az)
vpc=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/$macid/vpc-id)

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
        <p><b>Instance Private Ip Address: </b> $local_ipv4</p>
        <p><b>Availability Zone: </b> $az</p>
    </div>
    </body>
</html>
EOF
wait

