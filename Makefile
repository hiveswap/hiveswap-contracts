deploy:
	forge script script/Deploy.s.sol:DeployScript --private-key ${HIVE_KEY} --broadcast --rpc-url ${MAKALU_RPC_URL}
