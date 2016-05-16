/*
   Poloniex-based ETH/XBT price ticker

   This contract keeps in storage the latest ETH/XBT price (from poloniex)
*/


// import the oraclize API
import "oraclizeAPI.sol";

contract PoloniexPriceTicker is usingOraclize {
    
    address owner;
    string public ETHXBT;

    function PoloniexPriceTicker () {
        owner = msg.sender;
        // set consensys network
        oraclize_setNetwork(networkID_consensys);
        // call update function
        update();
    }

    // __callback function called by Oraclize
    function __callback(bytes32 myid, string result) {
        if (msg.sender != oraclize_cbAddress()) throw;
        // update the BTC/ETH price
        ETHXBT = result;
    }
    
    function update() private {
        // call oraclize and retrieve the latest price of BTC/ETH 
        oraclize_query(60, "URL", "json(https://poloniex.com/public?command=returnTicker).BTC_ETH.last");
    }

    function kill(){
        if (msg.sender == owner) suicide(msg.sender);
    }
    
}