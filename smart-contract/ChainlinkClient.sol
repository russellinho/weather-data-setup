// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
import "@chainlink/contracts/src/v0.6/ChainlinkClient.sol";

contract OpenWeatherConsumer is ChainlinkClient {
    using Chainlink for Chainlink.Request;

    address private oracle;
    bytes32 private jobId;
    uint256 private fee;
    
    uint256 public result;
    
    constructor() public {
        setPublicChainlinkToken();
        oracle = 0xc0cBf87f62139264932086F57d7Bb08CEBE75590;
        jobId = "c21738989cb34f3f91684913213af300";
        fee = 0.1 * 10 ** 18;
    }
    
    /**
     * Initial request
     */
    function requestWeatherTemperature(string memory _city) public {
        Chainlink.Request memory req = buildChainlinkRequest(jobId, address(this), this.fulfillWeatherTemperature.selector);
        req.add("city", _city);
        sendChainlinkRequestTo(oracle, req, fee);
    }
    
    /**
     * Callback function
     */
    function fulfillWeatherTemperature(bytes32 _requestId, uint256 _result) public recordChainlinkFulfillment(_requestId) {
        result = _result;
    }

    // function withdrawLink() external {} - Implement a withdraw function to avoid locking your LINK in the contract
}
