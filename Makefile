# https://rpc.maplabs.io
deploy-hive:
	forge script script/Deploy.s.sol:DeployScript --private-key ${HIVE_KEY} --broadcast --rpc-url ${MAKALU_RPC_URL}

deploy-weth9:
	forge script script/DeployWETH9.s.sol:DeployWETH9Script --private-key ${HIVE_KEY} --broadcast --rpc-url ${MAKALU_RPC_URL}

deploy-multicall3:
	forge script script/DeployMulticall3.s.sol:DeployMulticall3Script --private-key ${HIVE_KEY} --broadcast --rpc-url ${MAKALU_RPC_URL} --legacy

deploy-makaluToken:
	forge script script/DeployMakaluToken.s.sol:DeployMakaluTokenScript --private-key ${HIVE_KEY} --broadcast --rpc-url ${MAKALU_RPC_URL}

deploy-pancakeMulticallV2:
	forge script script/DeployPancakeMulticallV2.s.sol:DeployPancakeMulticallV2Script --private-key ${HIVE_KEY} --broadcast --rpc-url ${MAKALU_RPC_URL} --legacy

set-receiver:
	forge script script/MasterchefV3.s.sol:MasterchefV3 --private-key ${HIVE_KEY} --broadcast --rpc-url ${MAKALU_RPC_URL}

add:
	forge script script/MasterchefV3.s.sol:MasterchefV3 --sig "add()" --private-key ${HIVE_KEY} --broadcast --rpc-url ${MAKALU_RPC_URL}

upkeep:
	forge script script/MasterchefV3.s.sol:MasterchefV3 --sig "upkeep()" --private-key ${HIVE_KEY} --broadcast --rpc-url ${MAKALU_RPC_URL}

printAll:
	forge script script/MasterchefV3.s.sol:MasterchefV3 --sig "printAll()" --private-key ${HIVE_KEY} --rpc-url ${MAKALU_RPC_URL}

printFees:
	forge script script/MasterchefV3.s.sol:MasterchefV3 --sig "printProtocolFees()" --private-key ${HIVE_KEY} --rpc-url ${MAKALU_RPC_URL}

send:
	forge script script/MasterchefV3.s.sol:MasterchefV3 --sig "send()" --private-key ${HIVE_KEY} --rpc-url ${MAKALU_RPC_URL} --broadcast

collectFees:
	forge script script/MasterchefV3.s.sol:MasterchefV3 --sig "collectProtocol()" --private-key ${HIVE_KEY} --rpc-url ${MAKALU_RPC_URL} --broadcast

prepare:
	forge script script/MasterchefV3.s.sol:MasterchefV3 --sig "prepare()" --private-key ${HIVE_KEY} --broadcast --rpc-url ${MAKALU_RPC_URL}
