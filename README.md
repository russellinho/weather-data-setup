# weather-data-setup

## External Adapter
First, I created an external adapter using the external adapter framework, which can be found here along with my added adapter: https://github.com/russellinho/weather-adapter.

After creating the adapter, I made sure it worked by running it locally and hitting it with curl and Postman. I made sure it worked and then I added some error handling for a more pleasant user experience.

## AWS
After it worked locally, I fired up a free Linux EC2 VM on AWS to host the adapter on. I set up the VM with the necessary packages and plugins and then started the adapter as a background process listening on port 8080 using nohup.

I then hit the external adapter on this host via curl and Postman to ensure it worked.

## Docker
After I set up the external adapter, I then had to set up the Chainlink node in order to connect the ETH smart contract with the external adapter. This was difficult for me as it was something I have never done before, but after reading up on some documentation and tutorials, I pieced together the proper environment in Docker to run my jobs on the Ropsten testnet. I used this testnet because there was already a lot of existing documentation/tutorials for it. In retrospect, this was a mistake because the Ropsten testnet is basically deprecated and I could not retrieve test LINK for it in order to run my smart contract. If I do this again, I will use Kovan testnet instead.

Infura (to create a test Ethereum block) and Postgres (container DB) were the dependencies I needed to get the node running.

I then composed my Docker environment and made sure I could get to the dashboard at http://localhost:6688.

The next thing for me to set up on my Chainlink node was something called a bridge. A bridge is what connects the job of a Chainlink node to the external adapter API endpoint. Setting that up was fairly straightforward.

[![](https://i.imgur.com/wqJ0XYL.png)]()

With the bridge set up, the last thing to do was set up a job on the node to use this bridge in order to retrieve the temperature for a given city, so I set that up in a JSON format. I was then able to test it by creating an additional job that ran this job with the city I provided. I tested it using Raleigh, Los Angeles, and a string of random letters (to check if the error handling worked). They all passed and returned the correct data and responses.

[![](https://i.imgur.com/FvSdej2.png)]()

## Smart Contract
For the stretch requirement, I wanted to see if I could get the smart contract working. This was probably the most difficult part since I have never deployed on a smart contract before. However, after enough documentation and tinkering around with it, I was able to get my first smart contract deployed on the Ropsten testnet using the Remix online compiler and deployment tool.

This is where I messed up, as after I deployed it, it did not work because I was unable to fund my node with any LINK token. The Ropsten faucets were not working for LINK token for whatever reason. I'm also unsure as to whether I set the correct addresses or not.

## Conclusion
In conclusion, this was an excellent learning experience and deep-dive into how Chainlink works and I had a lot of fun. I was already a huge proponent of Ethereum beforehand, but learning how it works behind the scenes gives me an even greater appreciation for it. As stated previously, if I were to do this again, I would use the Kovan testnet instead of the Ropsten testnet as there is more support for it.
