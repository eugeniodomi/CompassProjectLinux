#!/bin/bash

# Define o comando que será gerenciado pelo crontab
COMMAND="*/5 * * * * /etc/nginx/Scripts/server_validate.sh"


# Função para adicionar a linha no crontab de root, se ela não existir
add_cron_if_needed() {
  # Verifica se a linha já está no crontab, se não, adiciona
  if ! sudo crontab -l | grep -qF "$COMMAND"; then
    # Adiciona o comando ao crontab, mantendo o conteúdo atual
    (sudo crontab -l; echo "$COMMAND") | sudo crontab -
    echo "Linha adicionada ao crontab de root."
  fi
}

# Função para comentar a linha no crontab de root
comment_cron() {
  # Usar sudo para garantir que estamos modificando o crontab de root
  sudo crontab -l | grep -v -F "$COMMAND" > temp_cron
  sudo crontab -l | grep -F "$COMMAND" | sed 's/^/#/' >> temp_cron
  sudo crontab temp_cron
  rm temp_cron
  echo "Automatização desligada (Linha comentada no crontab de root)"
}

# Função para descomentar a linha no crontab de root
uncomment_cron() {
  # Usar sudo para garantir que estamos modificando o crontab de root
  sudo crontab -l | grep -v -F "$COMMAND" > temp_cron
  sudo crontab -l | grep -F "$COMMAND" | sed 's/^#//' >> temp_cron
  sudo crontab temp_cron
  rm temp_cron
  echo "Automatização ligada! (Linha descomentada no crontab de root)"
}

# Verifica se a automação está sendo ligada ou desligada
if [[ "$1" == "desligar" ]]; then
  add_cron_if_needed
  comment_cron
elif [[ "$1" == "ligar" ]]; then
  add_cron_if_needed
  uncomment_cron
else
  echo "Uso: $0 [ligar|desligar]"
fi
