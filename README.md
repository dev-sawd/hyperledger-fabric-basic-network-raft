## Basic Network Config using raft

This project is for hyperledger fabric study.

### docker list
- ca.org1.example.com
- peer0.org1.example.com
- peer1.org1.example.com
- couchdb
- couchdb2
- orderer.example.com
- orderer2.example.com
- orderer3.example.com
- cli

### Ordering service
- raft

To start the basic network run ``start.sh``.

### sequence
- generating orderer genesis block
- generating channel configuration transaction 'channel.tx'
- generating anchor peer update for Org1MSP
- docker-compose up

below step is scripts/script.sh excuting in cli
- createChannel
- joinChannel
- updateAnchorPeers
- installChaincode
- instantiateChaincode
- chaincodeQuery
- chaincodeInvoke
- chaincodeQuery (check invoke result)

clear docker container and chaincode ``teardown.sh``.

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>
