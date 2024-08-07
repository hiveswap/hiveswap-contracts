include .env

# https://rpc.maplabs.io
deploy-hive:
	forge script script/Deploy.s.sol:DeployScript --private-key ${HIVE_KEY} --broadcast --rpc-url ${MAKALU_RPC_URL}

deploy-weth9:
	forge script script/DeployWETH9.s.sol:DeployWETH9Script --private-key ${HIVE_KEY} --broadcast --rpc-url ${MAKALU_RPC_URL}

deploy-multicall3:
	forge script script/DeployMulticall3.s.sol:DeployMulticall3Script --private-key ${HIVE_KEY} --broadcast --rpc-url ${ETH_RPC_URL} --legacy

deploy-makaluToken:
	forge script script/DeployMakaluToken.s.sol:DeployMakaluTokenScript --private-key ${HIVE_KEY} --broadcast --rpc-url ${MAKALU_RPC_URL}

deploy-pancakeMulticallV2:
	forge script script/DeployPancakeMulticallV2.s.sol:DeployPancakeMulticallV2Script --private-key ${HIVE_KEY} --broadcast --rpc-url ${MAKALU_RPC_URL} --legacy

set-receiver:
	forge script script/MasterchefV3.s.sol:MasterchefV3 --private-key ${HIVE_KEY} --broadcast --rpc-url ${MAKALU_RPC_URL}

add:
	forge script script/MasterchefV3.s.sol:MasterchefV3 --sig "add()" --private-key ${HIVE_KEY} --broadcast --rpc-url ${MAKALU_RPC_URL}

deploy-locked:
	forge script script/DeployLockedToken.s.sol:DeployLockedTokenScript --private-key ${HIVE_KEY} --broadcast --rpc-url ${MAKALU_RPC_URL}

upkeep:
	forge script script/MasterchefV3.s.sol:MasterchefV3 --sig "upkeep()" --private-key ${HIVE_KEY} --broadcast --rpc-url ${MAKALU_RPC_URL}

printAll:
	forge script script/MasterchefV3.s.sol:MasterchefV3 --sig "printAll()" --private-key ${HIVE_KEY} --rpc-url ${MAKALU_RPC_URL}

printFees:
	forge script script/MasterchefV3.s.sol:MasterchefV3 --sig "printProtocolFees()" --private-key ${HIVE_KEY} --rpc-url ${MAP_RPC_URL}

send:
	forge script script/MasterchefV3.s.sol:MasterchefV3 --sig "send()" --private-key ${HIVE_KEY} --rpc-url ${MAKALU_RPC_URL} --broadcast

collectFees:
	forge script script/MasterchefV3.s.sol:MasterchefV3 --sig "collectProtocol()" --private-key ${HIVE_KEY} --rpc-url ${MAP_RPC_URL} --broadcast

setFee:
	forge script script/MasterchefV3.s.sol:MasterchefV3 --sig "setProtocolFee()" --private-key ${HIVE_KEY} --rpc-url ${MAP_RPC_URL} --broadcast

prepare:
	forge script script/MasterchefV3.s.sol:MasterchefV3 --sig "prepare()" --private-key ${HIVE_KEY} --broadcast --rpc-url ${MAKALU_RPC_URL}

deploy-merkle:
	forge script script/MerkleDistributor.s.sol:MerkleDistributorScript --private-key ${HIVE_KEY} --broadcast --rpc-url ${MAP_RPC_URL}

deploy-claim:
	forge script script/ClaimDistributor.s.sol:ClaimDistributorScript --private-key ${HIVE_KEY} --broadcast --rpc-url ${MAP_RPC_URL}

deploy-tester:
	forge script script/MerkleDistributor.s.sol:MerkleDistributorScript --sig "tester()" --private-key ${HIVE_KEY} --broadcast --rpc-url ${MAP_RPC_URL}

withdraw-merkle:
	forge script script/MerkleDistributor.s.sol:MerkleDistributorScript --sig "withdraw()" --private-key ${HIVE_KEY} --broadcast --rpc-url ${MAP_RPC_URL}

withdraw-claim:
	forge script script/ClaimDistributor.s.sol:ClaimDistributorScript --sig "withdraw()" --private-key ${HIVE_KEY} --broadcast --rpc-url ${MAP_RPC_URL}

set-merkle:
	forge script script/MerkleDistributor.s.sol:MerkleDistributorScript --sig "setMerkleRoot()" --private-key ${HIVE_KEY} --broadcast --rpc-url ${MAP_RPC_URL}

set-claim-merkle:
	forge script script/ClaimDistributor.s.sol:ClaimDistributorScript --sig "setMerkleRoot()" --private-key ${HIVE_KEY} --broadcast --rpc-url ${MAP_RPC_URL}

printAll-merkle:
	forge script script/MerkleDistributor.s.sol:MerkleDistributorScript --sig "printAll()" --private-key ${HIVE_KEY} --broadcast --rpc-url ${MAP_RPC_URL}
