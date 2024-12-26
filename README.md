# Documentação Atividade Linux

## **Introdução**

**Configuração de um Servidor NGINX no WSL com Monitoramento Automatizado**

Este projeto tem como objetivo configurar um servidor NGINX utilizando o Windows Subsystem for Linux (WSL) com uma distribuição Ubuntu, possibilitando o uso de um ambiente Linux diretamente no Windows para hospedar e gerenciar serviços web. Além da configuração do servidor, o projeto implementa uma solução robusta para monitorar automaticamente o status do serviço NGINX, fornecendo registros claros e organizados sobre sua operação.

O WSL permite rodar distribuições Linux em sistemas Windows de maneira integrada, eliminando a necessidade de máquinas virtuais ou dual-boot. Neste projeto, utilizamos a distribuição Ubuntu como base para instalar e configurar o NGINX, um dos servidores web mais populares devido ao seu desempenho e versatilidade. A configuração do NGINX inclui a instalação de pré-requisitos, configuração inicial, e testes para garantir seu funcionamento no ambiente Windows.
Este projeto individual foi desenvolvido como entrega final de uma sprint para a empresa **Compass UOL**, com foco na trilha de **Linux**, demonstrando competências em administração de servidores, automação de tarefas e desenvolvimento de scripts Bash.

## Requisitos básicos

Um dos diferenciais deste projeto é a criação de um script Bash chamado `validate_service.sh`, desenvolvido para validar automaticamente o status do serviço NGINX. Este script:

- Verifica se o serviço NGINX está **ONLINE** ou **OFFLINE**.
- Gera mensagens personalizadas para ambas as condições, fornecendo feedback claro ao usuário.
- Cria dois arquivos de saída separados para armazenar os registros:
    - Um arquivo para status **ONLINE**.
    - Outro arquivo para status **OFFLINE**.
- Os arquivos gerados são organizados no diretório definido pelo usuário, neste caso, `/nginx/logs`.

Para garantir que o monitoramento ocorra de maneira contínua e sem intervenção manual, o script é configurado para ser executado automaticamente a cada 5 minutos, utilizando o agendador de tarefas `crontab`. Essa automação permite acompanhar o status do serviço em tempo real, facilitando a identificação de problemas e ações corretivas.

Extras:

Além das etapas básicas do projeto, foi adicionada uma funcionalidade extra:

- **Controle de Automação:** Scripts adicionais permitem ativar ou desativar a execução automática do monitoramento diretamente, sem a necessidade de edições manuais no `crontab`.
- **Menu Interativo para Gerenciamento:** Um menu interativo foi desenvolvido para facilitar o gerenciamento do servidor NGINX e da automação de logs, centralizando os principais comandos em uma interface simples e acessível. O menu adicional contém estes recursos:

```bash
      Menu Nginx Server
===========================
1. Iniciar Nginx
2. Parar Nginx
3. Verificar status do Nginx
4. Exibir IP do servidor
5. Ligar automação cron de logs
6. Desligar automação cron de logs
7. Verificar automação do cron
8. Sair
```

# **Índice**
1. **Instalação do Ubuntu via WSL no Windows**  
   
   1.1. [Ativar o WSL no Windows](#ativar-o-wsl-no-windows)  
   
   1.2. [Configurar o WSL 2 como padrão (opcional, mas recomendado)](#configurar-o-wsl-2-como-padrão-opcional-mas-recomendado)

2. **Configurar o Ubuntu no Primeiro Uso**  
   
   2.1. [Abrir o Ubuntu](#abrir-o-ubuntu)  
   
   2.2. [Criar um Usuário e Senha](#criar-um-usuário-e-senha)  
   
   2.3. [Atualizar o Sistema](#atualizar-o-sistema)  
   
   2.4. [Configurar o Ubuntu para a Versão WSL 2](#configurar-o-ubuntu-para-a-versão-wsl-2)  
   
   2.5. [Instalar ferramentas essenciais](#instalar-ferramentas-essenciais)

3. **Instalação do Git para Versionamento**  
   
   3.1. [Instale o Git](#instale-o-git)  
   
   3.2. [Configure seu usuário e e-mail no Git](#configure-seu-usuário-e-e-mail-no-git)  
   
   3.3. [Crie ou navegue até a pasta do projeto](#crie-ou-navegue-ate-a-pasta-do-projeto)  
   
   3.4. [Inicialize o repositório Git na pasta do projeto](#inicialize-o-repositório-git-na-pasta-do-projeto)  
   
   3.5. [Adicione um arquivo `.gitignore` (opcional)](#adicione-um-arquivo-gitignore-opcional)

4. **Instalação dos pré-requisitos do NGINX**  
   
   4.1. [Instale os pré-requisitos](#instale-os-pré-requisitos)  
   
   4.2. [Importe uma chave de assinatura oficial do nginx](#importe-uma-chave-de-assinatura-oficial-do-nginx)  
   
   4.3. [Verifique a chave baixada](#verifique-a-chave-baixada)  
   
   4.4. [Configure o repositório apt](#configure-o-repositório-apt)  
   
   4.5. [Configuração de fixação do repositório](#configuração-de-fixação-do-repositório)

5. **Instalação do NGINX**  
   
   5.1. [Atualize o sistema](#atualize-o-sistema)  
   
   5.2. [Instale o NGINX](#instale-o-nginx)  
   
   5.3. [Inicie o serviço NGINX](#inicie-o-serviço-nginx)  
   
   5.4. [Verifique o status do serviço](#verifique-o-status-do-serviço)

6. **Instalação do UFW (opcional)**  
   
   6.1. [Atualize o sistema](#atualize-o-sistema-2)  
   
   6.2. [Instale o UFW](#instale-o-ufw)  
   
   6.3. [Permitir conexões de entrada e saída para NGINX](#permitir-conexões-de-entrada-e-saída-para-nginx)  
   
   6.4. [Verifique as regras do firewall](#verifique-as-regras-do-firewall)

7. **Teste do Server**  
   
   7.1. [Obtenha o endereço IP do servidor](#obtenha-o-endereço-ip-do-servidor)  
   
   7.2. [Acesse o servidor pelo navegador](#acesse-o-servidor-pelo-navegador)  
   
   7.3. [Resultados esperados](#resultados-esperados)

8. **Script Bash para Captura de Log**  
   
   8.1. [Detalhes do script](#detalhes-do-script)

9. **Automatização dos Scripts de Logs**  
   
   9.1. [Automatizando a execução do script](#automatizando-a-execução-do-script)

10. **Criação de Menu Interativo**  
   
    10.1. [Detalhes do menu interativo](#detalhes-do-menu-interativo)



# **Instalação do Ubuntu via WSL no Windows**

### **1 - Ativar o WSL no Windows**

1. **Abrir o PowerShell como Administrador**:
    - Pressione `Win + S` e digite "PowerShell".
    - Clique com o botão direito em "Windows PowerShell" e selecione "Executar como Administrador".
2. **Ativar o WSL**:
Execute o seguinte comando no PowerShell:
    
    ```bash
    wsl --install
    ```
    

Este comando instala o WSL, incluindo o kernel Linux e a distribuição padrão (geralmente o Ubuntu).

1. **Configurar o WSL 2 como padrão (opcional, mas recomendado)**:

```bash
wsl --set-default-version 2
```

### **2.1 - Configurar o Ubuntu no Primeiro Uso**

1. **Abrir o Ubuntu**:
    - Após a instalação, abra o aplicativo "Ubuntu" pelo menu Iniciar.
2. **Criar um Usuário e Senha**:
Durante a inicialização, o Ubuntu solicitará:
    - **Nome de usuário**: Escolha um nome curto, como `computer1`.
    - **Senha**: Escolha uma senha forte para uso administrativo.
3. **Atualizar o Sistema**:
Após o login, execute:
    
    ```bash
    sudo apt update && sudo apt upgrade -y
    ```
    

### **2.2 -  Configurar o Ubuntu para a Versão WSL 2 (Opcional)**

1. Caso queira garantir que o Ubuntu está rodando na versão WSL 2, execute no PowerShell:

```bash
wsl -l -v
```

1. Se o Ubuntu estiver listado como WSL 1, altere para WSL 2:

```bash
wsl --set-version Ubuntu-22.04 2
```

1. **Instalar ferramentas essenciais**

Caso necessário, instale esta ferramenta:

```bash
sudo apt install git build-essential curl -y
```

### 3 - Instalação do Git para Versionamento

Instalação do Git para gerenciamento de versionamento e controle do projeto, permitindo rastrear alterações no código de forma eficiente.

1. **Instale o Git (caso ainda não tenha em seu SO):**

```bash
sudo apt update
sudo apt install git -y
```

1. **Configure seu usuário e e-mail no Git:**

```bash
git config --global [user.name](http://user.name/) "Seu Nome"
git config --global user.email "[seuemail@exemplo.com](mailto:seuemail@exemplo.com)"
```

1. Crie ou navegue até a pasta do projeto onde fara o versionamento dos arquivos, neste caso a pasta raiz do server nginx, como não ainda não foi criada (Etapa 5 - **Instalação do NGINX** ), incialize o diretório:
    
    Diretório padrão criado pelo nginx é : /etc/nginx
    

```bash
cd /etc
mkdir nginx
cd nginx
```

1. Inicialize o repositório Git na pasta do projeto:

```bash
git init
```

1. Adicione um arquivo `.gitignore` para excluir arquivos desnecessários, como logs temporários: (não necessário)

```bash
echo "logs/*.log" > .gitignore
git add .gitignore
git commit -m "Adiciona .gitignore para logs"
```

## **4 - Instalação dos pré-requisitos do NGINX**

Instalação de dependências essenciais para a compilação e execução do servidor NGINX. Esses pacotes garantem que o sistema esteja preparado para suportar o serviço.

 1. Instale os pré-requisitos:

```bash
sudo apt install curl gnupg2 ca-certificates lsb-release ubuntu-keyring
```

1. Importe uma chave de assinatura oficial do nginx para que o apt possa verificar a autenticidade dos pacotes. Pegue a chave:

```bash
curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
    | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
```

1. Verifique se o arquivo baixado contém a chave adequada:

```bash
gpg --dry-run --quiet --no-keyring --import --import-options import-show /usr/share/keyrings/nginx-archive-keyring.gpg
```

1. A saída deve conter a impressão digital completa `573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62` da seguinte forma:

```bash
pub   rsa2048 2011-08-19 [SC] [expires: 2027-05-24]
      573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
uid                      nginx signing key <signing-key@nginx.com>
```

Observe que a saída pode conter outras chaves usadas para assinar os pacotes.

1. Para configurar o repositório apt para pacotes nginx estáveis, execute o seguinte comando (recomendado):

```bash
echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list
```

1. Se você quiser usar pacotes nginx da linha principal, execute o seguinte comando:

```bash
echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
http://nginx.org/packages/mainline/ubuntu `lsb_release -cs` nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list
```

1. Configure a fixação do repositório para preferir nossos pacotes aos fornecidos pela distribuição:

```bash
echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" \
    | sudo tee /etc/apt/preferences.d/99nginx
```

## **5 - Instalação do NGINX**

Configuração e instalação do servidor web NGINX.

**Passos para instalar  o NGINX:**

1. Atualize o sistema:

```bash
sudo apt update
```

1. **Instale o NGINX:**

```bash
sudo apt install nginx -y
```

1. Primeiro, deixe o sistema em execução:

```bash
sudo systemctl start nginx
```

1. **Verifique o status do serviço:**

```bash
sudo systemctl status nginx
```

## **6 - Instalação do UFW (opcional)**

Configuração do UFW (Uncomplicated Firewall), um serviço que facilita o gerenciamento de regras de firewall, protegendo o servidor contra acessos não autorizados.

1. Atualize o sistema:

```bash
sudo apt update && sudo apt upgrade
```

1. Instale o Uncomplicated Firewall:

```bash
sudo apt install ufw
```

1. Permitir conexões de entrada e saída associadas ao perfil **"Nginx Full":**

```bash
sudo ufw allow 'Nginx Full'
```

1. Verifique as regras do firewall:

```bash
sudo ufw status
```

## **7 - Teste do Server**

Verificação da funcionalidade do servidor, utilizando o comando `hostname -I` para identificar o IP e testando o acesso pelo navegador para confirmar que o NGINX está em execução.

1. Use o seguinte comando para obter o endereço IP do servidor:

```bash
hostname -I
```

Esse comando retornará o endereço IP local do servidor.

 3. Abrir a página padrão no navegador de sua preferência (no caso utilizado Firefox 133.0.3 navegando através de Windows 11 para testes do mesmo):

Abra um navegador web no seu computador ou dispositivo.

1. Insira o endereço IP do servidor no campo de URL:

Exemplo: Se o IP for `192.168.1.10`, acesse:

```bash
http://192.168.1.10
```

**Resultados Esperados:**

- Você deve ver a página padrão do NGINX com uma mensagem como:**"Welcome to nginx!"**

## **8 - Script bash  para captura de log**

Criação de um script Bash para monitorar logs do servidor e automatizar a execução com o agendador de tarefas `crontab`, otimizando o gerenciamento do servidor.

1. Caso não tenho repositório para os Scripts, adicionar:

```bash
sudo mkdir /etc/nginx/Scripts

```

1. **Crie o script em bash**:

```bash
sudo nano /etc/nginx/Scripts/validate_service.sh

```

1. **Alocar código contido no repositório** 

Incluir o código do repositório no script `validate_service.sh`. Este script será responsável por validar o status do serviço NGINX periodicamente, garantindo sua funcionalidade. Ele será integrado ao ambiente do servidor e configurado para executar verificações automáticas por meio do `crontab`.

Código está no repositório, dentro do script criado (validate_service.sh)

1. **Dar permissão de execução ao script**:

```bash
sudo chmod +x /etc/nginx/Scripts/validate_service.sh
```

1. **Testar o script**:

```bash
sudo /etc/nginx/Scripts/validate_service.sh
```

1. Automatizar o script:

**Automatizar com o cron para salvar logs (manual)**:
Para executar o script periodicamente (por exemplo, a cada 5 minutos), configure o **cron**:

```bash
sudo crontab -e
```

1. Adicione a linha no arquivo de texto:

```bash
*/5 * * * * /etc/nginx/Scripts/validate_service.sh
```

## **9 - Automatização do Script de logs**

Desenvolvimento de um recurso extra que permite ligar e desligar a execução automática do script de logs diretamente por comandos via script Bash. Essa funcionalidade oferece flexibilidade na ativação e desativação da automação configurada no `crontab`, sem a necessidade de editar manualmente o agendador, aprimorando a gestão e o controle do servidor.

---

### 1- Automatizar o script (script de liga e desliga automação de captura dos logs):

1. Criar um script chamado crontrol_cron.sh

```bash
sudo nano /etc/nginx/Scripts/crontrol_cron.sh
```

1. Adicione o código localizado no repositório salvo no mesmo diretório acima (/nginx/Scripts/control_cron.sh) ao arquivo de script criado.

### 2 - **Como Usar o Script**

1. **Torne o script executável**:

```bash
chmod +x control_cron.sh
```

1. **Para ligar a automação** (adicionar o cron job):

```bash
./control_cron.sh ligar
```

1. **Para desligar a automação** (remover o cron job):

```bash
./control_cron.sh desligar
```

1. **Verificar se o cron job foi adicionado ou removido**:

```bash
crontab -l
```

### 3 - **Como Funciona**

- Quando você executa `./control_cron.sh ligar`, o cron job será adicionado e o script será executado conforme o agendamento (a cada 5 minutos, no caso do exemplo).
- Quando você executa `./control_cron.sh desligar`, o cron job será removido e o script não será mais executado automaticamente.

Isso facilita o controle da automação sem precisar editar manualmente o cron job ou reiniciar o sistema.

### Breve explicação do Script:

1. **Variáveis do Serviço e Diretório**:
    - `SERVICE`: Define o nome do serviço a ser monitorado (no exemplo, "nginx").
    - `LOG_DIR` e `LOG_FILE`: Definem o diretório e o arquivo onde os registros serão armazenados.
2. **Criação do Diretório**:
O script verifica se o diretório existe e o cria, caso contrário.
3. **Validação do Serviço**:
    - Usa o comando `systemctl is-active` para verificar o status do serviço.
    - Retorna `ONLINE` ou `OFFLINE` com mensagens personalizadas.
4. **Registro no Log**:
    - Inclui Data, Hora, Nome do Serviço, Status e a Mensagem Personalizada.
    - Usa o comando `tee` para gravar a saída no arquivo de log.
5. **Automatização com o cron**:
Permite executar o script automaticamente em intervalos regulares.

Após isso, o arquivo `/var/log/service_status/status.log` terá registros como:

```bash
2024-12-18 14:30:00 - Serviço: nginx - Status: ONLINE - Mensagem: O serviço nginx está funcionando normalmente.
2024-12-18 14:35:00 - Serviço: nginx - Status: OFFLINE - Mensagem: O serviço nginx está fora do ar!
```

## 10 - Criação de menu interativo

**1. Crie o Script - S**alve o código acima em um arquivo chamado `nginx_menu.sh` dentro da pasta Scripts ou na de sua preferência.

```bash
sudo nano /etc/nginx/Scripts/crontrol_cron.sh
```

 

1. Adicione o código contido neste repositório no seu arquivo criado.

1. **Dê Permissões de Execução**:

```bash
chmod +x nginx_menu.sh
```

**3Execute o Script**:

```bash
./nginx_menu.sh
```
