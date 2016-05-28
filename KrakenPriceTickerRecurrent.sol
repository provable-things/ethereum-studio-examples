/*
   Kraken-based ETH/XBT price ticker

   This contract keeps in storage an updated ETH/XBT price,
   which is updated every ~60 seconds.
   
   WARNING: ensure the contract has enough ethers in its balance or the __callback tx will throw
*/

import "dev.oraclize.it/api.sol";

contract KrakenPriceTicker is usingOraclize {
    
    address owner;
    string public ETHXBT;
    

    function KrakenPriceTicker() {
        owner = msg.sender;
        oraclize_setProof(proofType_TLSNotary | proofStorage_IPFS);
        update(0);
    }

    function __callback(bytes32 myid, string result, bytes proof) {
        if (msg.sender != oraclize_cbAddress()) throw;
        ETHXBT = result;
        update(60); // schedule a new query after 60 seconds
    }
    
    function update(uint delay) {
        oraclize_query(delay, "URL", "json(https://api.kraken.com/0/public/Ticker?pair=ETHXBT).result.XETHXXBT.c.0");
    }
    
    function kill(){
        if (msg.sender == owner) suicide(msg.sender);
    }
    
} 
