#!/bin/bash

# Nome do serviço monitorado com logs (NGINX)
SERVICE="nginx" # 

# Diretório onde os logs serão armazenados
LOG_DIR="/etc/nginx/logs/service_status"
LOG_ONLINE="$LOG_DIR/status_online.log"
LOG_OFFLINE="$LOG_DIR/status_offline.log"

# Criar o diretório 
if [ ! -d "$LOG_DIR" ]; then
    sudo mkdir -p "$LOG_DIR" #Cria diretorio de log se nao inicializada
    sudo chmod 755 "$LOG_DIR" #Permissoes para o log
fi

# Verificar o status do serviço
if systemctl is-active --quiet $SERVICE; then
    STATUS="ONLINE"
    MESSAGE="O serviço $SERVICE está funcionando normalmente."
    LOG_FILE=$LOG_ONLINE
else
    STATUS="OFFLINE"
    MESSAGE="O serviço $SERVICE está fora do ar!"
    LOG_FILE=$LOG_OFFLINE
fi

# Data e Hora atual
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Registro no log
echo "$TIMESTAMP - Serviço: $SERVICE - Status: $STATUS - Mensagem: $MESSAGE" | sudo tee -a $LOG_FILE


