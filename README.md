# Findora Validator Node Scripts by EasyNode.PRO

## Validator Toolbox

We've released the [Validator Toolbox](https://guides.easynode.pro/findora/toolbox) for Findora which now includes everything we host here.

We will preserve this script repo for those who prefer to do things manually.

## Validator Script Repo

Below are our versions of findora scripts with upgrades.

## Findora Installer - easy_install.sh

Easy Node's updated easy_install.sh to create a **brand new server with a brand new wallet** in 1 command. **This script should only be run on a brand new server.**

Here's the modifications we've made to the script:

- Detect username who launched script for use in permissions later
- Install `fn` automatically
- Create new wallet and move to proper locations for use after download to allow sync to run
- Fix permissions so they will work on non-root account

See our [guide page here](https://guides.easynode.pro/findora/script) for pre-requirements and installation instructions.

## Findora Container Update or Restart - easy_update.sh

See our [Post Install guide page](https://guides.easynode.pro/findora/post#validator-software-version-updates) for info on running the image update script.

## Findora Safety Clean - safety_clean.sh

See our [Post Install guide page](https://guides.easynode.pro/findora/post#safety-clean) for info on running the safety clean script.

## Findora fn Wallet Update - fn_update.sh

See our [Post Install guide page](https://guides.easynode.pro/findora/post#fn-update) for info on running the fn update script.

## Findora Stats - easy_stats.sh

Download our stats script with:

```text
wget https://raw.githubusercontent.com/easy-node-one/findora-validator-scripts/main/easy_stats.sh -O stats.sh
```

Re run the script to get updated stats anytime with:

```text
bash -x stats.sh
```

## Findora Tendermint Reset - easy_tenermint_reset.sh

If you see the following error in your `docker logs findorad`:
`open /root/.tendermint/data/priv_validator_state.json: no such file or directory`

Run the Tendermint reset script to reset your tendermint files:
`wget https://raw.githubusercontent.com/easy-node-pro/findora-validator-scripts/main/easy_tendermint_reset_mainnet.sh -O tendermint_reset_mainnet.sh && bash -x tendermint_reset_mainnet.sh`

## Server Migration Help!

See our [Migration guide page](https://guides.easynode.pro/findora/moving) to get the information to migrate to a brand new server using the Validator Toolbox.

## Findora Firewall Settings

Below are our configurations for different software firewalls.

### [ufw.md](/ufw.md)

Firewall settings for using ufw with Findora for those of you on Contabo or other providers with software firewalls. Same ports should be opened on any provider with a web firewall (Hetzner, Contabo, Digital Ocean, AWS, GCP, Azure, etc...)
