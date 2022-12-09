# findora-validator-scripts
Findora Validator Script Repo!

## Findora Node Scripts
Below are our versions of findora scripts with upgrades.

## Findora Installer - easy_install.sh
Easy Node's updated easy_install.sh to create a **brand new server with a brand new wallet** in 1 command. **This script should only be run on a brand new server.**

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

#### Findora Installer by Easy Node
Once you're in the docker group, have sudo access and you've reconnected you are ready to run the installer. To start the installer choose the code for your network below:
```text
# For mainnet run
wget https://raw.githubusercontent.com/easy-node-one/findora-validator-scripts/main/easy_install_mainnet.sh -O easy_install.sh && bash -x easy_install.sh
# For testnet run
wget https://raw.githubusercontent.com/easy-node-one/findora-validator-scripts/main/easy_install_testnet.sh -O easy_install.sh && bash -x easy_install.sh
```

## Findora Update or Container Restart - easy_update.sh
Our version of the update_version script for Findora.

To check for updates or to simply restart your mainnet Findora node run the following code, choose the code for your network below:
```text
# For mainnet run
wget https://raw.githubusercontent.com/easy-node-one/findora-validator-scripts/main/easy_update_mainnet.sh -O easy_update.sh && bash -x easy_update.sh
# For testnet run
wget https://raw.githubusercontent.com/easy-node-one/findora-validator-scripts/main/easy_update_testnet.sh -O easy_update.sh && bash -x easy_update.sh
```

## Findora Safety Clean - safety_clean.sh
Our version of the safety_clean script for Findora.

To stop and reload the database on your server run the following code, choose the code for your network below:
```text
# For mainnet run
wget https://raw.githubusercontent.com/easy-node-pro/findora-validator-scripts/main/safety_clean_mainnet.sh -O safety_clean.sh && bash -x safety_clean.sh
# For testnet run
wget https://raw.githubusercontent.com/easy-node-pro/findora-validator-scripts/main/safety_clean_testnet.sh -O safety_clean.sh && bash -x safety_clean.sh
```

## Findora Stats - easy_stats.sh
Download our stats script with:
```text
wget https://raw.githubusercontent.com/easy-node-one/findora-validator-scripts/main/easy_stats.sh -O stats.sh
```

Run the script with:
```text
bash -x stats.sh
```

## Server Migration Help!
Check out our [guide on migration here](https://guides.easynode.pro/findora/moving).

## Findora Firewall Settings
Below are our configurations for different software firewalls.  

### [ufw.md](/ufw.md)
Firewall settings for using ufw with Findora for those of you on Contabo or other providers with software firewalls. Same ports should be opened on any provider with a web firewall (Hetzner, Contabo, Digital Ocean, AWS, GCP, Azure, etc...)