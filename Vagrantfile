# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2010"

  # La siguiente configuración de la red será ignorada si utilizas hyperv
  # Más información: https://www.vagrantup.com/docs/providers/hyperv/limitations#limited-networking
  config.vm.network "forwarded_port", guest: 8080, host: 8080

  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = "2048"
  end
  
  config.vm.provider "hyperv" do |hv|
    hv.memory = "2048"
    hv.cpus = 2
  end
  
  # Script de aprovisionamiento de la máquina virtual.
  config.vm.provision "shell", inline: <<-SHELL
    # Instala Jenkins
    curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/ | tee /etc/apt/sources.list.d/jenkins.list > /dev/null
    apt update
    apt install -y openjdk-11-jre
    apt install -y jenkins

    # Instala packer
    curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    apt update
    apt install -y packer
    adduser vagrant docker

    # Instala ansible
    apt install -y python3-pip
    pip3 install ansible

    # Instala SDK de Google Cloud (comando gcloud)
    apt install -y apt-transport-https ca-certificates gnupg
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | tee /usr/share/keyrings/cloud.google.gpg
    apt update
    apt install install apt-transport-https ca-certificates gnupg
    apt install google-cloud-cli

    # Instala docker compose
    sudo -u vagrant mkdir -p /home/vagrant/.docker/cli-plugins
    sudo -u vagrant curl -SL https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-linux-x86_64 -o /home/vagrant/.docker/cli-plugins/docker-compose
    sudo -u vagrant chmod 755 /home/vagrant/.docker/cli-plugins/docker-compose
  SHELL
end
