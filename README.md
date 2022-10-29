# findora-validator-scripts
Findora Validator Script Repo!

## Findora Node Scripts
Below are our versions of the installer script (node_init.sh) and the update version script (update_version.sh). Either script can be easily modified to be run on testnet, simply update the `NAMESPACE` variable at the start of either script.  

### Findora Installer - easy_install.sh
Easy Node's updated easy_install.sh to create a **brand new server with a brand new wallet** in 1 command. **This script should only be run on a brand new server/image.**

Here's the modifications we've made to the script:
- Detect username who launched script for use in permissions later
- Install `fn` automatically
- Create new wallet and move to proper locations for use after download to allow sync to run
- Fix permissions so they will work on non-root account

#### Software Requirements
User account must have sudo access. As root run `usermod -aG sudo serviceuser` to add your user account to the root users group. Replace `serviceuser` with your user account name before running the code.

Install docker and configure your user by running following code. If you user isn't `servicefindora` update that to be your username in the following code before running it on your server:
```text
sudo apt update -y && sudo apt install apt-transport-https ca-certificates curl software-properties-common -y && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" && sudo apt install docker-ce -y && sudo usermod -aG docker servicefindora && exit
```

#### Run installer
Once you're in the docker group, have sudo access and you've reconnected you are ready to run the installer. If you want to run testnet, just update the word `mainnet` in the code below to be `testnet` instead:
```text
wget https://raw.githubusercontent.com/easy-node-one/findora-validator-scripts/main/easy_install_mainnet.sh -O easy_install.sh && bash -x easy_install.sh
```

### update_version.sh
Our version of the update_version script for mainnet. We added the option to restart on reboot.  

To check for updates & restart your mainnet Findora node run the following code. If you want to run testnet, just update the word `mainnet` in the code below to be `testnet` instead:
```text
wget https://raw.githubusercontent.com/easy-node-one/findora-validator-scripts/main/update_version_mainnet.sh -O update_version.sh && bash -x update_version.sh
```

## Firewall Settings
Below are our configurations for different software firewalls.  

### [ufw.md](/ufw.md)
Firewall settings for using ufw with Findora for those of you on Contabo or other providers with software firewalls. Same ports should be opened on any provider with a web firewall (Hetzner, Contabo, Digital Ocean, AWS, GCP, Azure, etc...)