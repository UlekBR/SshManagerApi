#!/bin/bash

# Verifica se um processo está em execução
verificar_processo() {
    nome_processo=$1
    resultado=$(ps aux)
    if echo "$resultado" | grep -q "$nome_processo"; then
        return 0
    else
        return 1
    fi
}
# Cria o diretório se não existir
mkdir -p /opt/SshManagerApi

# Atualiza os repositórios e instala o curl se necessário
apt update
apt install -y curl

# Determina a arquitetura do sistema
arch=$(uname -m)
case $arch in
    x86_64 | amd64 | x86_64h)
        echo "Sistema baseado em x86_64 (64-bit Intel/AMD)"
        arquivo_ssh="https://raw.githubusercontent.com/UlekBR/SshManagerApi/main/sshmanager"
        ;;
    aarch64 | arm64 | armv8-a)
        echo "Sistema baseado em arm64 (64-bit ARM)"
        arquivo_ssh="https://raw.githubusercontent.com/UlekBR/SshManagerApi/main/sshmanagerarm"
        ;;
    *)
        echo "Arquitetura não reconhecida: $arch"
        exit 1
        ;;
esac

# Baixa os arquivos necessários
curl -o "/opt/SshManagerApi/sshmanagerapi" -f "$arquivo_ssh"
curl -o "/opt/SshManagerApi/menu.sh" -f "https://raw.githubusercontent.com/UlekBR/SshManagerApi/main/menu.sh"

# Dá permissão de execução aos scripts
chmod +x /opt/SshManagerApi/sshmanagerapi
chmod +x /opt/SshManagerApi/menu.sh

# Remove o processo se estiver em execução
if verificar_processo "sshmanagerapi"; then
  sudo systemctl restart sshmanager.service
fi



# Cria um link simbólico para o script de menu
ln -sf /opt/SshManagerApi/menu.sh /usr/local/bin/manager

echo -e "Para iniciar o menu, digite: manager"
