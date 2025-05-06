#!/bin/bash

# Enable detailed logging
exec > >(tee /var/log/eval.log|logger -t eval -s 2>/dev/console) 2>&1

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

yum install -y go
echo export PATH=$PATH:$HOME/go/bin >> $HOME/.bashrc
source $HOME/.bashrc
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
yum install -y libpcap-devel
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

log "Downloading lab files"
cd ~/
git clone https://github.com/vulhub/vulhub.git