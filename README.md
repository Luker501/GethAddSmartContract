# Using Geth's javascript console to add a smart contract

This tutorial assumes that you are using geth as a command line tool to run a full Quorum node. *note that it is not advised to use this tutorial for public blockchain networks like Ethereum as we will be unlocking accounts to post transactions, and anyone with an RPC connection to your node will be able to use the unlocked account*.

## Attach to your node

In this tutorial we will add the HelloWorld.sol smart contract to the Quorum blockchain. To do so, firstly, attach to your node javascript console using

```
geth attach new-node-1/geth.ipc
```

## Load Contract Definitions

Now we need to add our the ABI interface definition of the contract, along with it's bytecode. Note that there are multiple ways to generate the ABI and bytecode, perhaps the easiest for a new user is by adding the smart contract code into https://remix.ethereum.org then moving to the Complie tab, clicking on the details button and looking in the Web3Deploy section.

Anyway, instantiate the ABI and byte code by entering the following commands into the geth javascript console:

```
var helloworldContract = eth.contract([{"constant":false,"inputs":[{"name":"newWord","type":"string"}],"name":"setWord","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"getWord","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"}]);

var bytecode = '0x60806040526040805190810160405280600b81526020017f48656c6c6f20576f726c640000000000000000000000000000000000000000008152506000908051906020019061004f929190610062565b5034801561005c57600080fd5b50610107565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106100a357805160ff19168380011785556100d1565b828001600101855582156100d1579182015b828111156100d05782518255916020019190600101906100b5565b5b5090506100de91906100e2565b5090565b61010491905b808211156101005760008160009055506001016100e8565b5090565b90565b61044a806101166000396000f3fe608060405260043610610046576000357c010000000000000000000000000000000000000000000000000000000090048063cd048de61461004b578063ed40a8c81461018c575b600080fd5b34801561005757600080fd5b506101116004803603602081101561006e57600080fd5b810190808035906020019064010000000081111561008b57600080fd5b82018360208201111561009d57600080fd5b803590602001918460018302840111640100000000831117156100bf57600080fd5b91908080601f016020809104026020016040519081016040528093929190818152602001838380828437600081840152601f19601f82011690508083019250505050505050919291929050505061021c565b6040518080602001828103825283818151815260200191508051906020019080838360005b83811015610151578082015181840152602081019050610136565b50505050905090810190601f16801561017e5780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b34801561019857600080fd5b506101a16102d7565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156101e15780820151818401526020810190506101c6565b50505050905090810190601f16801561020e5780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b60608160009080519060200190610234929190610379565b5060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156102cb5780601f106102a0576101008083540402835291602001916102cb565b820191906000526020600020905b8154815290600101906020018083116102ae57829003601f168201915b50505050509050919050565b606060008054600181600116156101000203166002900480601f01602080910402602001604051908101604052809291908181526020018280546001816001161561010002031660029004801561036f5780601f106103445761010080835404028352916020019161036f565b820191906000526020600020905b81548152906001019060200180831161035257829003601f168201915b5050505050905090565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106103ba57805160ff19168380011785556103e8565b828001600101855582156103e8579182015b828111156103e75782518255916020019190600101906103cc565b5b5090506103f591906103f9565b5090565b61041b91905b808211156104175760008160009055506001016103ff565b5090565b9056fea165627a7a72305820dde42f0124f39f91f44cfacaabb85291d7b8ffc39a535f2802a57a94a0734ee70029'
```

## Unlock Account

Now the transaction that we are in the process of creating needs to be sent from an account. The easiest way to do this is to temporarily unlock an account through the following command: 

```
web3.personal.unlockAccount('<the account address here>', '<the password here>')
```

*Note that when unlocked, anyone with an RPC connection to this node can use the account. Also the password will be stored in the terminal history until cleared*.

## Deploy Contract

Next we need to Deploy the contract onto the blockchain (the following assumes that the unlocked account was your nodes first account):

```
var deployContract = helloworldContract.new(
   {
     from: eth.accounts[0], 
     data: bytecode,
     gas: '4700000'
   }, function (e, contract){
    console.log(e, contract);
    if (typeof contract.address !== 'undefined') {
         console.log('Contract mined! address: ' + contract.address + ' transactionHash: ' + contract.transactionHash);
    }
 })
````

## Check Contract is Deployed

If you deployed the contract correctly, it will have been assigned a transaction hash which you can view through:

```
deployContract.transactionHash
```

For further details on your transaction, try:

```
eth.getTransaction("<Your transaction Hash>")
```

if the transaction has been added to a block then the following command will return something:

```
 eth.getTransactionReceipt("<Your transaction Hash>")
```

Note that you have to have a certain number of nodes in the network before the blockchain can be built.

## Lock Account

Now you have added the transaction, remember to clear the terminal screen and relock the account through:

```
web3.personal.lockAccount('0x76182383726f4c5b8ef5288456c146d27676190a')
```

To confirm that the account has been locked try:

```
personal.listWallets
```



