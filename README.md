# findora-validator-scripts
Findora Validator Script Repo!

## Findora Node Scripts
Below is our version of the installer script (node_init.sh) and the update version script (update_version_mainnet.sh). Either script can be easily modified to be run on testnet, simply update the `NAMESPACE` variable at the start of either script.  

### node_init.sh
Easy Node's updated node_init.sh to create a **brand new server with a brand new wallet** in 1 swoop. **Do not run this on a server with your existing files or they will be overwritten!!!**  

We made some modifications to add a restart on boot and to also install the current version of `fn` during the script instead of separately.  

Install docker and configure your user by running following code. If you user isn't `servicefindora` update that to be your username in the following code before running it on your server:
```text
sudo apt update -y && sudo apt install apt-transport-https ca-certificates curl software-properties-common -y && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" && sudo apt install docker-ce -y && sudo usermod -aG docker servicefindora
```

Restart your shell session (disconnect and reconnect so your user account has docker group access), then grab the script and fire away!
```text
wget https://raw.githubusercontent.com/easy-node-one/findora-validator-scripts/main/node_init_mainnet.sh -O node_init.sh && bash -x node_init.sh
```

### update_version
Our version of the update_version script for mainnet. We added the option to restart on reboot.  

To check for updates & restart your mainnet Findora node:
```text
wget https://raw.githubusercontent.com/easy-node-one/findora-validator-scripts/main/update_version_mainnet.sh -O update_version_mainnet.sh && bash -x update_version_mainnet.sh
```

## Firewall Settings
Below are our configurations for different software firewalls.  

### ufw.sh
Firewall settings for using ufw with Findora for those of you on Contabo or other providers with software firewalls.