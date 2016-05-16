/*
    Diesel price
    
    This contract keeps in storage the current diesel price (from fueleconomy.gov)
*/

// import the oraclize API
import "oraclizeAPI.sol";

contract DieselPricePeg is usingOraclize {
    
    uint public DieselPriceUSD;

    function DieselPricePeg() {
        // set consensys network
        oraclize_setNetwork(networkID_consensys);
        // set proof (Oraclize will return the proof)
        oraclize_setProof(proofType_TLSNotary | proofStorage_IPFS);
        update(0); // first check at contract creation
    }

    // __callback function called by Oraclize
    function __callback(bytes32 myid, string result, bytes proof) {
        if (msg.sender != oraclize_cbAddress()) throw;
        DieselPriceUSD = parseInt(result, 2); // let's save it as $ cents
        // do something with the USD Diesel price ?
    }
    
    function update(uint delay) private {
        oraclize_query(delay, "URL", "xml(https://www.fueleconomy.gov/ws/rest/fuelprices).fuelPrices.diesel");
    }
    
}