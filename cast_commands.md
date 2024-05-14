cast wallet import web3_practice --private-key $PRIVATE_KEY

cast wallet list
rm -rf ~/.foundry/keystores/web3_practice

DST = some contract address
FUNC_SIG = "set(uint256)"
ARGS = "111"
PRC = $SEPOLIA_URL

cast send --account web3_practice --rpc-url $PRC $DST $FUNC_SIG $ARGS
cast call --rpc-url $PRC $DST "val()(unit256)"



cast send --ledger vitalik.eth --value 0.1ether

cast format-bytes32-string "helloworld"
cast parse-bytes32-string 0x68656c6c6f776f726c6400000000000000000000000000000000000000000000

cast from-utf8 hello
cast to-utf8 0x68656c6c6f
