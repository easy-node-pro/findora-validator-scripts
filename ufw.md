These commands configure `ufw` firewall on Ubuntu 20.04LTS, use at your own risk:

Configure the needed ports:
```bash
sudo ufw allow 22
sudo ufw allow 8545/tcp
sudo ufw allow 8667/tcp
sudo ufw allow 8668/tcp
sudo ufw allow 8669/tcp
sudo ufw allow 26657/tcp
```

Enable `ufw`:
```bash
sudo ufw enable
```

`ufw` Status:
```bash
sudo ufw status
```