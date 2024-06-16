#!/bin/bash


# Função para verificar processo
verificar_processo() {
    nome_processo=$1
    resultado=$(ps aux)
    if echo "$resultado" | grep -q "$nome_processo"; then
        return 0
    else
        return 1
    fi
}


if [ -d "/opt/SshManagerApi" ]; then
    if verificar_processo "sshmanagerapi"; then
        pkill -9 "sshmanagerapi" >/dev/null 2>&1 &
        arch=$(uname -m)
        # Determine a arquitetura e faça o download do arquivo correspondente
        if [[ $arch == "x86_64" || $arch == "amd64" || $arch == "x86_64h" ]]; then
            echo "Sistema baseado em x86_64 (64-bit Intel/AMD)"
            curl -o "/opt/SshManagerApi/sshmanagerapi" -f "https://raw.githubusercontent.com/UlekBR/SshManagerApi/main/sshmanager"
        elif [[ $arch == "aarch64" || $arch == "arm64" || $arch == "armv8-a" ]]; then
            echo "Sistema baseado em arm64 (64-bit ARM)"
            curl -o "/opt/SshManagerApi/sshmanagerapi" -f "https://raw.githubusercontent.com/UlekBR/SshManagerApi/main/sshmanagerarm"
        else
            echo "Arquitetura não reconhecida: $arch"
            exit 1
        fi

        # Faça o download de outros scripts necessários
        curl -o "/opt/SshManagerApi/menu.sh" -f "https://raw.githubusercontent.com/UlekBR/SshManagerApi/main/menu.sh"

        # Dê permissão de execução aos scripts
        chmod +x /opt/SshManagerApi/sshmanagerapi
        chmod +x /opt/SshManagerApi/menu.sh
        /opt/SshManagerApi/sshmanagerapi >/dev/null 2>&1 &

        echo -e "Para iniciar o menu, digite: sshmanager"


    else
        arch=$(uname -m)
        # Determine a arquitetura e faça o download do arquivo correspondente
        if [[ $arch == "x86_64" || $arch == "amd64" || $arch == "x86_64h" ]]; then
            echo "Sistema baseado em x86_64 (64-bit Intel/AMD)"
            curl -o "/opt/SshManagerApi/sshmanagerapi" -f "https://raw.githubusercontent.com/UlekBR/SshManagerApi/main/sshmanager"
        elif [[ $arch == "aarch64" || $arch == "arm64" || $arch == "armv8-a" ]]; then
            echo "Sistema baseado em arm64 (64-bit ARM)"
            curl -o "/opt/SshManagerApi/sshmanagerapi" -f "https://raw.githubusercontent.com/UlekBR/SshManagerApi/main/sshmanagerarm"
        else
            echo "Arquitetura não reconhecida: $arch"
            exit 1
        fi

        # Faça o download de outros scripts necessários
        curl -o "/opt/SshManagerApi/menu.sh" -f "https://raw.githubusercontent.com/UlekBR/SshManagerApi/main/menu.sh"

        # Dê permissão de execução aos scripts
        chmod +x /opt/SshManagerApi/sshmanagerapi
        chmod +x /opt/SshManagerApi/menu.sh

        echo -e "Para iniciar o menu, digite: sshmanager"
fi
else
   mkdir -p /opt/SshManagerApi
    # Atualize os repositórios e instale dependências
    apt update
    apt install -y curl

    arch=$(uname -m)
    # Determine a arquitetura e faça o download do arquivo correspondente
    if [[ $arch == "x86_64" || $arch == "amd64" || $arch == "x86_64h" ]]; then
        echo "Sistema baseado em x86_64 (64-bit Intel/AMD)"
        curl -o "/opt/SshManagerApi/sshmanagerapi" -f "https://raw.githubusercontent.com/UlekBR/SshManagerApi/main/sshmanager"
    elif [[ $arch == "aarch64" || $arch == "arm64" || $arch == "armv8-a" ]]; then
        echo "Sistema baseado em arm64 (64-bit ARM)"
        curl -o "/opt/SshManagerApi/sshmanagerapi" -f "https://raw.githubusercontent.com/UlekBR/SshManagerApi/main/sshmanagerarm"
    else
        echo "Arquitetura não reconhecida: $arch"
        exit 1
    fi

    # Faça o download de outros scripts necessários
    curl -o "/opt/SshManagerApi/menu.sh" -f "https://raw.githubusercontent.com/UlekBR/SshManagerApi/main/menu.sh"

    # Dê permissão de execução aos scripts
    chmod +x /opt/SshManagerApi/sshmanagerapi
    chmod +x /opt/SshManagerApi/menu.sh

    # Crie um link simbólico para o script de menu
    ln -s /opt/SshManagerApi/menu.sh /usr/local/bin/sshmanager

    echo -e "Para iniciar o menu, digite: sshmanager"
fi

