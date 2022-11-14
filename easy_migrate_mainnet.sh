#!/usr/bin/env bash
USERNAME=$USER
ENV=prod
NAMESPACE=mainnet
SERV_URL=https://${ENV}-${NAMESPACE}.${ENV}.findora.org
LIVE_VERSION=$(curl -s https://${ENV}-${NAMESPACE}.${ENV}.findora.org:8668/version | awk -F\  '{print $2}')
FINDORAD_IMG=findoranetwork/findorad:${LIVE_VERSION}
export ROOT_DIR=/data/findora/${NAMESPACE}
keypath=${ROOT_DIR}/${NAMESPACE}_node.key
migratepath=/home/${USERNAME}/migrate
FN=${ROOT_DIR}/bin/fn

check_env() {
    for i in wget curl; do
        which $i >/dev/null 2>&1
        if [[ 0 -ne $? ]]; then
            echo -e "\n\033[31;01m${i}\033[00m has not been installed properly!\n"
            exit 1
        fi
    done

    if ! [ -f "$migratepath" ]; then
        echo -e "Migrate folder found, preparing to copy files..."
    else
        echo -e "Create the folder ~/migrate with your node.mnemonic, priv_validator_key.json and tmp.gen.keypair files to continue."
    fi

    if ! [ -f "$migratepath/tmp.gen.keypair"]; then
        cp ${migratepath}/tmp.gen.keypair ${ROOT_DIR}/${NAMESPACE}_node.key
    else
        echo -e "tmp.gen.keypair file not found at ~/migrate/tmp.gen.keypair - Add this file to ~/migrate to continue"
        exit 1
    fi

    if ! [ -f "$migratepath/priv_validator_key.json"]; then
        cp ${migratepath}/priv_validator_key.json ${ROOT_DIR}/tendermint/config/priv_validator_key.json
    else
        echo -e "priv_validator_key.json file not found at ~/migrate/priv_validator_key.json - Add this file to ~/migrate to continue"
        exit 1
    fi

    if ! [ -f "$migratepath/node.mnemonic"]; then
        cp ${migratepath}/node.mnemonic ${ROOT_DIR}/node.mnemonic
    else
        echo -e "node.mnemonic not found at ~/migrate/node.mnemonic - Creating from ~/migrate/tmp.gen.keypair file."
        node_mnemonic=$(cat ${keypath} | grep 'Mnemonic' | sed 's/^.*Mnemonic:[^ ]* //')
        echo $node_mnemonic > ${ROOT_DIR}/node.mnemonic || exit 1
    fi
}

set_binaries() {
    # OS=$1
    docker pull ${FINDORAD_IMG} || exit 1
    wget -T 10 https://github.com/FindoraNetwork/findora-wiki-docs/raw/main/.gitbook/assets/fn || exit 1

    new_path=${ROOT_DIR}/bin

    rm -rf $new_path 2>/dev/null
    mkdir -p $new_path || exit 1
    mv fn $new_path || exit 1
    chmod -R +x ${new_path} || exit 1
}

############################
# Check for existing files #
############################
check_env

if [[ "Linux" == `uname -s` ]]; then
    set_binaries linux
# elif [[ "FreeBSD" == `uname -s` ]]; then
    # set_binaries freebsd
elif [[ "Darwin" == `uname -s` ]]; then
    set_binaries macos
else
    echo "Unsupported system platform!"
    exit 1
fi

#####################
# Config local node #
#####################
$FN setup -S ${SERV_URL} || exit 1
$FN setup -K ${ROOT_DIR}/tendermint/config/priv_validator_key.json || exit 1
$FN setup -O ${ROOT_DIR}/node.mnemonic || exit 1

# clean old data and config files
sudo rm -rf ${ROOT_DIR}/findorad || exit 1
mkdir -p ${ROOT_DIR}/findorad || exit 1

docker run --rm -v ${ROOT_DIR}/tendermint:/root/.tendermint ${FINDORAD_IMG} init --${NAMESPACE} || exit 1

# reset permissions on tendermint folder after init
sudo chown -R ${USERNAME}:${USERNAME} ${ROOT_DIR}/tendermint

###################
# get snapshot    #
###################

# download latest link and get url
wget -O "${ROOT_DIR}/latest" "https://${ENV}-${NAMESPACE}-us-west-2-chain-data-backup.s3.us-west-2.amazonaws.com/latest"
CHAINDATA_URL=$(cut -d , -f 1 "${ROOT_DIR}/latest")
echo $CHAINDATA_URL

# reset permissions on all files before startup
sudo chown -R ${USERNAME}:${USERNAME} ${ROOT_DIR}

# remove old data 
rm -rf "${ROOT_DIR}/findorad"
rm -rf "${ROOT_DIR}/tendermint/data"
rm -rf "${ROOT_DIR}/tendermint/config/addrbook.json"

wget -O "${ROOT_DIR}/snapshot" "${CHAINDATA_URL}" 
mkdir "${ROOT_DIR}/snapshot_data"
tar zxvf "${ROOT_DIR}/snapshot" -C "${ROOT_DIR}/snapshot_data"

mv "${ROOT_DIR}/snapshot_data/data/ledger" "${ROOT_DIR}/findorad"
mv "${ROOT_DIR}/snapshot_data/data/tendermint/mainnet/node0/data" "${ROOT_DIR}/tendermint/data"

rm -rf ${ROOT_DIR}/snapshot_data

#####################
# Create local node #
#####################
docker run -d \
    -v ${ROOT_DIR}/tendermint:/root/.tendermint \
    -v ${ROOT_DIR}/findorad:/tmp/findora \
    -p 8669:8669 \
    -p 8668:8668 \
    -p 8667:8667 \
    -p 8545:8545 \
    -p 26657:26657 \
    -e EVM_CHAIN_ID=2152 \
    --name findorad \
    ${FINDORAD_IMG} node \
    --ledger-dir /tmp/findora \
    --tendermint-host 0.0.0.0 \
    --tendermint-node-key-config-path="/root/.tendermint/config/priv_validator_key.json" \
    --enable-query-service \
    --enable-eth-api-service

sleep 15

#############################
# Post Install Stats Report #
#############################
curl 'http://localhost:26657/status'; echo
curl 'http://localhost:8669/version'; echo
curl 'http://localhost:8668/version'; echo
curl 'http://localhost:8667/version'; echo

echo "Local node initialized, please stake your FRA tokens after syncing is completed."