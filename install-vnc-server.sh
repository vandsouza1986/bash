#!/usr/bin/env bash
# Autor: Vanderson Souza
# Data: 13/04/2025
# Versao: 1.0
# Roadmap -> validação sobre usuario root e verificar se diretorios/arquivos existem

#Variaveis Global
ATUALIZA="apt update"
INSTALA="apt install -y"
ARQUIVO="/lib/systemd/system/x11vnc.service"
RECARREGA="systemctl daemon-reload"
HABILITA="systemctl enable x11vnc.service"
INICIA="systemctl start x11vnc.service"
VERIFICA="systemctl status x11vnc.service"
LOG_STATUS="/var/log/x11vnc.log"
LOG_ERRO="/var/log/x11vnc.error"


#Variaveis arquivo configuracao
USUARIO="guess"
SENHA=qweasd"

export DEBIAN_FRONTEND=noninteractive

$ATUALIZA
$INSTALA lightdm
#sudo reboot
$INSTALA x11vnc


touch $ARQUIVO
cat <<EOF> $ARQUIVO

[Unit]
Description=x11vnc service
After=display-manager.service network.target syslog.target

[Service]
Type=simple
ExecStart=/usr/bin/x11vnc -forever -display :0 -auth $USUARIO -passwd $SENHA
ExecStop=/usr/bin/killall x11vnc
Restart=on-failure

[Install]
WantedBy=multi-user.target

EOF


$RECARREGA *>> $LOG_STATUS
$HABILITA *>> $LOG_STATUS
$INICIA *>> $LOG_STATUS
$VERIFICA *>> $LOG_STATUS

echo -e "Recomenda-se reiniciar o computador"
