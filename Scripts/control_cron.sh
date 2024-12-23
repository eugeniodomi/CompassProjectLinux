#!/bin/bash

# Caminho para o script que será automatizado
SCRIPT_PATH="etc\nginx\Scripts\server_validate.sh"

# Cron schedule (exemplo: a cada 5 minutos)
CRON_SCHEDULE="*/5 * * * *"

# Função para ligar a automação
ligar_automacao() {
    # Adiciona o cron job para executar o script
    (crontab -l 2>/dev/null; echo "$CRON_SCHEDULE $SCRIPT_PATH") | crontab -
    echo "Automação ligada! O script será executado a cada 5 minutos."
}

# Função para desligar a automação
desligar_automacao() {
    # Remove o cron job que executa o script
    crontab -l 2>/dev/null | sed "s|$SCRIPT_PATH|# $SCRIPT_PATH|" crontab -
    echo "Automação desligada! O script não será mais executado."
}

# Verificar o argumento fornecido
if [ "$1" == "ligar" ]; then
    ligar_automacao
elif [ "$1" == "desligar" ]; then
    desligar_automacao
else
    echo "Uso: $0 {ligar|desligar}"
    exit 1
fi
