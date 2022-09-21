# findora-validator-scripts
Findora Validator Script Repo!

## ufw.sh
Firewall settings for using ufw with Findora

## node_init.sh
Easy Node's updated node_init.sh to create a brand new server with wallet in 1 swoop.

Install docker and configure your user by running following code. If you user isn't `servicefindora` update that to be your username in the following code before running it on your server:
```text
sudo apt update -y && sudo apt install apt-transport-https ca-certificates curl software-properties-common -y && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" && sudo apt install docker-ce -y && sudo usermod -aG docker servicefindora
```

Restart your shell session (disconnect and reconnect so your user account has docker group access), then grab the script and fire away!
```text
wget https://raw.githubusercontent.com/easy-node-one/findora-validator-scripts/main/node_init.sh -O node_init.shell && bash -x node_init.sh
```