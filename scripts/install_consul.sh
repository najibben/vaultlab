#!/usr/bin/env bash
set -x

IFACE=`route -n | awk '$1 == "192.168.2.0" {print $8;exit}'`
CIDR=`ip addr show ${IFACE} | awk '$2 ~ "192.168.2" {print $2}'`
IP=${CIDR%%/24}

if [ -d /vagrant ]; then
  mkdir -p /vagrant/logs
  LOG="/vagrant/logs/consul_${HOSTNAME}.log"
else
  LOG="consul.log"
fi


PKG="wget unzip"
which ${PKG} &>/dev/null || {
  export DEBIAN_FRONTEND=noninteractive
  apt-get update
  apt-get install -y ${PKG}
}

# check consul binary
[ -f /usr/local/bin/consul ] &>/dev/null || {
    pushd /usr/local/bin
    [ -f consul_1.2.2_linux_amd64.zip ] || {
        sudo wget https://releases.hashicorp.com/consul/1.2.2/consul_1.2.2_linux_amd64.zip
    }
    sudo unzip consul_1.2.2_linux_amd64.zip
    sudo chmod +x consul
    popd
}

# check consul-template binary
[ -f /usr/local/bin/consul-template ] &>/dev/null || {
    pushd /usr/local/bin
    [ -f consul-template_0.19.5_linux_amd64.zip ] || {
        sudo wget https://releases.hashicorp.com/consul-template/0.19.5/consul-template_0.19.5_linux_amd64.zip
    }
    sudo unzip consul-template_0.19.5_linux_amd64.zip
    sudo chmod +x consul-template
    popd
}

# check envconsul binary
[ -f /usr/local/bin/envconsul ] &>/dev/null || {
    pushd /usr/local/bin
    [ -f envconsul_0.7.3_linux_amd64.zip ] || {
        sudo wget https://releases.hashicorp.com/envconsul/0.7.3/envconsul_0.7.3_linux_amd64.zip
    }
    sudo unzip envconsul_0.7.3_linux_amd64.zip
    sudo chmod +x envconsul
    popd
}

# dnsmasq
which dnsmasq 2>/dev/null || {
  export DEBIAN_FRONTEND=noninteractive
  apt-get update
  apt-get install -y dnsmasq
}

# dnsmasq conf
if [ ! -f "/etc/dnsmasq.d/10-consul" ]; then
	# Creates folder
	sudo mkdir -p /etc/dnsmasq.d
	sudo chmod a+w /etc/dnsmasq.d	
	
	echo 'server=/consul/127.0.0.1#8600' | tee /etc/dnsmasq.d/10-consul
	mv /etc/resolv.conf /etc/resolv.conf.orig
  echo domain consul | tee /etc/resolv.conf
  echo search consul | tee -a /etc/resolv.conf
  echo nameserver 127.0.0.1 | tee -a /etc/resolv.conf
	service dnsmasq restart
fi

AGENT_CONFIG="-config-dir=/etc/consul.d -enable-script-checks=true"
sudo mkdir -p /etc/consul.d
# check for consul hostname => server
if [[ "${HOSTNAME}" =~ "leader" ]] ; then
  echo server


  /usr/local/bin/consul members 2>/dev/null || {

      sudo /usr/local/bin/consul agent -server -ui -client=0.0.0.0 -bind=${IP} ${AGENT_CONFIG} -data-dir=/usr/local/consul -bootstrap-expect=1 >${LOG} &
    
    sleep 5


  }
else
  echo agent
  /usr/local/bin/consul members 2>/dev/null || {
    /usr/local/bin/consul agent -client=0.0.0.0 -bind=${IP} ${AGENT_CONFIG} -data-dir=/usr/local/consul -join=${LEADER_IP} >${LOG} &
    sleep 10
  }
fi

echo consul started
