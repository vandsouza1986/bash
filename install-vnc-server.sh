#!/usr/bin/env bash
# Baseado no video de David Bomball
# link https://www.youtube.com/watch?v=3K1hUwxxYek
# 13/04/2025

export DEBIAN_FRONTEND=noninteractive

sudo apt update
sudo apt install -y lightdm
sudo reboot
sudo apt install -y x11vnc


touch /lib/systemd/system/x11vnc.service
echo <<EOF> /lib/systemd/system/x11vnc.service

!Copy and paste these commands - change the password
[Unit]
Description=x11vnc service
After=display-manager.service network.target syslog.target

[Service]
Type=simple
ExecStart=/usr/bin/x11vnc -forever -display :0 -auth guess -passwd password
ExecStop=/usr/bin/killall x11vnc
Restart=on-failure

[Install]
WantedBy=multi-user.target

EOF


systemctl daemon-reload
systemctl enable x11vnc.service
systemctl start x11vnc.service
systemctl status x11vnc.service
