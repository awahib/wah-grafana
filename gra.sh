#!/bin/bash
#echo 'https://https://packages.grafana.com/oss/rpm' >> /etc/yum.repos.d/
#curl https://packages.grafana.com/gpg.key | sudo apt-key add -
#sudo apt-get update
#sudo apt-get -y install grafana

cat <<EOF | sudo tee /etc/yum.repos.d/grafana.repo
[grafana]
name=grafana
baseurl=https://packages.grafana.com/oss/rpm
repo_gpgcheck=1
enabled=1
gpgcheck=1
gpgkey=https://packages.grafana.com/gpg.key
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
EOF

yum makecache
yum -y install grafana
systemctl enable --now grafana-server.service
firewall-cmd --add-port=3000/tcp --permanent
firewall-cmd --reload

systemctl daemon-reload
systemctl start grafana-server
systemctl enable grafana-server.service
