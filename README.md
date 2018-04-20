# Pré requisitos

1. Docker
2. Docker Compose

# Instalação do docker npo UBuntu 16.04
``
sudo apt-get update
``

``
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
``

``
sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
``

``
sudo apt-get update
``

``
apt-cache policy docker-engine
``

Você deverá ver uma saída semelhante à seguinte:

``
docker-engine:
  Installed: (none)
  Candidate: 1.11.1-0~xenial
  Version table:
     1.11.1-0~xenial 500
        500 https://apt.dockerproject.org/repo ubuntu-xenial/main amd64 Packages
     1.11.0-0~xenial 500
        500 https://apt.dockerproject.org/repo ubuntu-xenial/main amd64 Packages
``

Instale o Docker:

``
sudo apt-get install -y docker-engine
``

``
sudo systemctl status docker
``

A saída deve ser similar ao seguinte, mostrando que o serviço está ativo e em execução:

``
[ secondary_label Output]
● docker.service - Docker Application Container Engine
   Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
   Active: active (running) since Sun 2016-05-01 06:53:52 CDT; 1 weeks 3 days ago
     Docs: https://docs.docker.com
 Main PID: 749 (docker)
``

Adicione o seu usuário ao grupo docker:

``
sudo usermod -aG docker $(whoami)
``

# Instalando Docker Compose

Primeiro cheque qual é a [release atual](https://github.com/docker/compose/releases).

``
sudo curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
``

Set permissões:

``
sudo chmod +x /usr/local/bin/docker-compose
``

Cheque se aversão está ok:

``
docker-compose --version
``
# Configurando os Containers

Faça o clone do repositório com as imagens necessárias:

``
git clone https://github.com/paulociecomp/docker-jenkins.git
``

Entre no diretório do projeto:

``
cd docker-jenkins
``

Altere o arquivo jenkins-composer:

IP_DA_MAQUINA_COM_TOMCAT para o endereço ip do host.

DOMAIN para o dominio configurado para acessar o host

Altere o usuario e senha no arquivo ./tomcat/conf/tomcat-users.xml.

No arquivo ./nginx/conf.d/default.conf, altere example.com para o nome do domínio:

``
ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
ssl_certificate_key "/etc/letsencrypt/live/example.com/privkey.pem";
``

# Configurar SSL com letsencrypt 

Faça o clone do repositório:

``
sudo git clone https://github.com/letsencrypt/letsencrypt /opt/letsencrypt
``

Obtenha o certificado:

``
sudo /opt/letsencrypt/letsencrypt-auto certonly --standalone --email your@email.com -d nbellocam.me -d www.nbellocam.me
``

Ecxecute o comando:

``
docker-compose -f jenkins-compose.yml up -d
``

Verifique se foram criados 3 containers docker:

``
docker ps
``

# COnfigurando Jenkins:

Acesse http://IP_DO_HOST:8081 para acessar o jenkins.

No acesso inicial ele irá pedir o digest.

No console, execute o comando docker ps e identifique o id do container do jenkins.

Execute o seguinte comando e identifique o hash digest do jenkins:

``
docker logs id_do_container
``

Informe o digest na tela do jenkins.

Instale todos os plugins recomendados do Jenkins.

Crie um usuário e senha para o Jenkins.

Na tela inicial, acesse Gerenciar Jenkins/Gerenciar plugins/Disponíveis. Busque pelo plugin Deploy to container Plugin e instale-o.

Em seguida, retorne para Gerenciar Jenkins e acesse Global Tool Configuration. Na seção Gradle, clique em Adicionar Gradle e desmarque a opção Instalar automaticamente. Em Nome, informe Gradle e no caminho, /opt/gradle/gradle-4.6.

Salve as alterações.

Então, retorne para as Gerenciar Jenkins, acessando posteriormente Configurar o Sistema. Na seção Propriedades globais, marque a caixa Variáveis de ambiente e adicione as seguintes variáveis:

Nome: JAVA_OPTS
Valor: -Dfile.encoding=ISO-8859-1

Nome: JAVA_TOOL_OPTIONS
Valor: -Dfile.encoding=ISO-8859-1

Quando for informar a url do tomcat informar o host setado no docker-compose file. Ex:

http://dockerhost:8080


 
