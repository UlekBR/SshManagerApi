#!/bin/bash

# Definição de Cores
cor_vermelha='\033[91m'
cor_verde='\033[92m'
cor_amarela='\033[93m'
cor_azul='\033[94m'
cor_reset='\033[0m'

# Função para obter IP público
get_public_ip() {
    local url="https://ipinfo.io"
    local response=$(curl -s "$url")
    if [[ $? -eq 0 ]]; then
        local ip=$(echo "$response" | grep -oP '"ip": "\K[^"]+')
        if [[ -n "$ip" ]]; then
            echo "$ip"
        else
            echo "Endereço IP público não encontrado na resposta."
        fi
    else
        echo "Falha na solicitação ao servidor."
    fi
}

# Função para verificar processo
verificar_processo() {
    nome_processo=$1
    resultado=$(ps aux)
    if echo "$resultado" | grep -q "$nome_processo" && echo "$resultado" | grep -q "python"; then
        return 0
    else
        return 1
    fi
}

nome_do_script="sshmanagerapi"

# Loop principal
while true; do
    clear
    echo -e "S-S-H--M-A-N-A-G-E-R"
    echo -e "By @UlekBR"

    if verificar_processo "$nome_do_script"; then
        status="${cor_verde}ativo${cor_reset}"
        acao="Parar"
        link_sinc="Link de sincronização: http://$(get_public_ip):$(cat /opt/SshManagerApi/port.txt)"
        token="Token: $(cat /opt/SshManagerApi/token.txt)"
    else
        status="${cor_vermelha}parado${cor_reset}"
        acao="Iniciar"
        link_sinc=""
        token=""
    fi

    echo -e "Status: $status"

    if [[ -n "$link_sinc" ]]; then
        echo -e "\n$link_sinc"
    fi
    if [[ -n "$token" ]]; then
        echo -e "$token"
    fi

    echo -e "\nSelecione uma opção:"
    echo -e " 1 - $acao API"
    echo -e " 0 - Sair do menu"

    read -p "Digite a opção: " option

    case $option in
        1)
            if verificar_processo "$nome_do_script"; then
                sudo systemctl stop sshmanagerapi.service
                sudo systemctl disable sshmanagerapi.service
                sudo rm /etc/systemd/system/sshmanagerapi.service
                sudo systemctl daemon-reload
                rm -rf /opt/SshManagerApi/port.txt
                rm -rf /opt/SshManagerApi/token.txt
            else
                read -p $'\nDigite a porta que deseja usar: ' port
                echo $port >> /opt/SshManagerApi/port.txt
                echo $(cat /proc/sys/kernel/random/uuid) >> /opt/SshManagerApi/token.txt
                clear
                echo -e "Porta escolhida: $(cat /opt/SshManagerApi/port.txt)"

                echo "[Unit]
Description=SshManagerApiService
After=network.target

[Service]
Type=simple
ExecStart=/opt/SshManagerApi/api.sh
Restart=always

[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/sshmanagerapi.service > /dev/null

                sudo systemctl daemon-reload
                sudo systemctl enable sshmanagerapi.service
                sudo systemctl start sshmanagerapi.service
                echo -e "O Link estará no Menu\n"
            fi
            
            read -p "Pressione a tecla enter para voltar ao menu "
            ;;
        0)
            exit 0
            ;;
        *)
            clear
            echo -e "Opção inválida, tente novamente!"
            read -p "Pressione a tecla enter para voltar ao menu"
            ;;
    esac
done
