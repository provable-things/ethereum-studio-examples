/*
    Eth USD
    
    This contract keeps in storage the current ETH/USD price (from cryptocompare.com)
*/

// import the oraclize API
import "oraclizeAPI.sol";

contract EthUsd is usingOraclize {

    string public ethusdRate;
    address owner;
    
    function EthUsd(){
        owner = msg.sender;
        // set consensys network
        oraclize_setNetwork(networkID_consensys);
        // call update function
        update();
    }

    // __callback function called by Oraclize
    function __callback(bytes32 myid, string result) {
        if (msg.sender != oraclize_cbAddress()) throw;
        // update rate
        ethusdRate = result;
    }
    
    function update() private {
        oraclize_query("URL", "json(https://www.cryptocompare.com/api/data/price?fsym=ETH&tsyms=USD).Data.0.Price");
    }

    function kill(){
        if (msg.sender == owner) suicide(msg.sender);
    }
}