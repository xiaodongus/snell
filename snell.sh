#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
yum install unzip -y
cd ～
wget --no-check-certificate -O snell.zip https://github.com/surge-networks/snell/releases/download/1.0.1/snell-server-v1.0.1-linux-amd64.zip
unzip snell.zip -d snell
rm -f snell.zip
chmod +x /root/snell/snell-server
cd /etc/systemd/system

cat > snell.service<<-EOF
[Unit]
Description=Snell Server
After=network.target

[Service]
Type=simple
User=nobody
Group=nogroup
LimitNOFILE=32768
ExecStart=/root/snell/snell-server -c /root/snell/snell-server.conf
Restart=on-failure
RestartSec=1s

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl start snell
systemctl restart snell
cat /root/snell/snell-server.conf