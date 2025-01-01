#!/bin/bash

# Função para exibir o menu
show_menu() {
    echo "==========================="
    echo "      Menu Nginx Server    "
    echo "==========================="
    echo "1. Iniciar Nginx"
    echo "2. Parar Nginx"
    echo "3. Verificar status do Nginx"
    echo "4. Exibir IP do servidor"
    echo "5. Ligar automação cron de logs"
    echo "6. Desligar automação cron de logs"
    echo "7. Verificar automação do cron"
    echo "8. Sair"
    echo "==========================="
    echo -n "Escolha uma opção: "
}

# Loop para o menu
while true; do
    show_menu
    read -r choice

    case $choice in
        1)
            echo -e "\nIniciando Nginx...\n"
            sudo systemctl start nginx
            echo -e "\nNginx iniciado com sucesso!\n"
            ;;
        2)
            echo -e "\nParando Nginx...\n"
            # Garantindo que o Nginx foi parado corretamente
            sudo systemctl stop nginx
            sudo systemctl status nginx
	    # Verificando o status do serviço após parar
            status=$(sudo systemctl is-active nginx)
            if [ "$status" == "inactive" ]; then
                echo -e "\nNginx parado com sucesso!\n"
            else
                echo -e "\nFalha ao parar o Nginx. Status: $status\n"
            fi
            ;;
        3)
            echo -e "\nVerificando status do Nginx...\n"
            sudo systemctl status nginx
            echo -e "\nStatus exibido acima.\n"
            ;;
        4)
            echo -e "\nExibindo IP do servidor...\n"
            hostname -I
            echo -e "\nIPs exibidos acima.\n"
            ;;
        5)
            echo -e "\nLigando automação cron de logs...\n"
            sudo /etc/nginx/Scripts/control_cron.sh ligar
            echo -e "\nAutomação ativada!\n"
            ;;
        6)
            echo -e "\nDesligando automação cron de logs...\n"
            sudo /etc/nginx/Scripts/control_cron.sh desligar
            echo -e "\nAutomação desativada!\n"
            ;;
        7)
            echo -e "\nAbrindo o editor do cron para verificar automação...\n"
            sudo crontab -e
            echo -e "\nVerificação concluída. Pressione Enter para continuar."
            read -r
            ;;
        8)
            echo -e "\nSaindo...\n"
            exit 0
            ;;
        *)
            echo -e "\nOpção inválida! Tente novamente.\n"
            ;;
    esac

    # Adiciona uma linha em branco para separar a próxima exibição do menu
    echo -e "\n========================================\n"
done
