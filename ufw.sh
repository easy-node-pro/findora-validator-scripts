#!/bin/bash
sudo ufw allow 22
sudo ufw allow 8545/tcp
sudo ufw allow 8667/tcp
sudo ufw allow 8668/tcp
sudo ufw allow 8669/tcp
sudo ufw allow 26657/tcp
sudo ufw enable -y
sudo ufw status