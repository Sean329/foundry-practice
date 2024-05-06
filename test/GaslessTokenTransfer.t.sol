pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {GaslessTokenTransfer} from "../src/GaslessTokenTransfer.sol";
import {MyToken} from "../src/ERC20WithPermit.sol";
import {MessageHashUtils} from "../lib/openzeppelin-contracts/contracts/utils/cryptography/MessageHashUtils.sol";

contract TestGaslessTokenTransfer is Test {
    MyToken public token;
    GaslessTokenTransfer gaslessTokenTransfer;
    address sender;
    address receiver;
    uint constant AMOUNT = 1 ether;
    uint constant FEE = 0.01 ether;
    uint constant PRIVATEKEY = 111;
    uint deadline;

    bytes32 private constant PERMIT_TYPEHASH =
        keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");
    bytes32 private constant TYPE_HASH =
        keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)");


    function setUp() public {
        token = new MyToken();
        gaslessTokenTransfer = new GaslessTokenTransfer();
        
        sender = vm.addr(PRIVATEKEY);
        // console.log("sender address is: ", sender);
        // console.log("spender address is: ", address(gaslessTokenTransfer));
        // console.log("This address is: ", address(this));

        receiver = address(1);

        deal(address(token), sender, AMOUNT + FEE);


    }

    function _constructMsgHash(
        address _owner,
        address _spender,
        uint _amount,
        uint _fee,
        uint _nonce,
        uint _deadline
    ) private view returns(bytes32 hash){
        bytes32 structHash = keccak256(abi.encode(PERMIT_TYPEHASH, _owner, _spender, _amount+_fee, _nonce, _deadline));

        hash = MessageHashUtils.toTypedDataHash(_domainSeparatorV4(), structHash);
    }

    function _domainSeparatorV4() internal view returns (bytes32) {
        return keccak256(abi.encode(TYPE_HASH, keccak256(bytes("MyToken")), keccak256(bytes("1")), block.chainid, address(token)));
    } 

    function test_send() public {
        // Prepare permit message
        deadline = block.timestamp + 1 minutes;
        bytes32 msgHash = _constructMsgHash(sender, address(gaslessTokenTransfer), AMOUNT, FEE, token.nonces(sender), deadline);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(PRIVATEKEY, msgHash);

        // console.log("recovered sender address is: " , ecrecover(msgHash, v, r, s));
        // console.log("gaslessTokenTransfer address is: " , address(gaslessTokenTransfer));

        // Execute send() of the GasslessTokenTransfer contract
        assertEq(token.balanceOf(sender), AMOUNT+FEE , "sender's balance should be AMOUNT+FEE");
        assertEq(token.balanceOf(receiver), 0 , "receiver's balance should be 0");
        assertEq(token.balanceOf(address(this)), 0 , "This address's balance should be 0");

        gaslessTokenTransfer.send(address(token), sender, receiver, AMOUNT, FEE, deadline, v,r,s);

        //check balance of this contract
        assertEq(token.balanceOf(sender), 0 , "sender's balance should be 0");
        assertEq(token.balanceOf(receiver), AMOUNT , "receiver's balance should be AMOUNT");
        assertEq(token.balanceOf(address(this)), FEE , "This address's balance should be FEE");

    }
}