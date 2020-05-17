#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# Exit on first error, print all commands.

rm -rf ./config
mkdir config
rm -rf crypto-config

export PATH=$HOME/fabric-samples/bin:$PATH
cryptogen generate --config=./crypto-config.yaml

configtxgen -profile SampleMultiNodeEtcdRaft -outputBlock ./config/genesis.block

configtxgen -profile OneOrgChannel -outputCreateChannelTx ./config/channel.tx -channelID mychannel

configtxgen -profile OneOrgChannel -outputAnchorPeersUpdate ./config/Org1MSPanchors.tx -channelID mychannel -asOrg Org1MSP

export SK_NAME=$(cd crypto-config/peerOrganizations/org1.example.com/ca && ls *_sk)
SK_NAME=$SK_NAME docker-compose -f docker-compose.yml up -d ca.example.com orderer.example.com peer0.org1.example.com couchdb cli peer1.org1.example.com orderer2.example.com orderer3.example.com

sleep 1
echo "Sleeping 15s to allow $CONSENSUS_TYPE cluster to complete booting"
sleep 14

docker exec cli ./scripts/script.sh mychannel 3 golang

#create channel
# docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.example.com/msp" peer0.org1.example.com peer channel create -o orderer.example.com:7050 -c mychannel -f /etc/hyperledger/configtx/channel.tx
# sleep 5

# docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.example.com/msp" peer0.org1.example.com peer channel join -b mychannel.block

# docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.example.com/msp" peer1.org1.example.com peer channel join -b mychannel.block
