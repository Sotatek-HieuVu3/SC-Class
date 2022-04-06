const Web3 = require("web3");
const WALLET_ADDRESS = "0x33BA8fcDF199350954acDf0D41Fc170bc9021f0C";
const PRIVATE_KEY =
  "c087f91f0f0de5f93e69be44c34588918be6166547b63e4439a28f2d74c814cb";
const PROVIDER =
  "https://rinkeby.infura.io/v3/47d45e20effa4a55afa62f5d7bdea482";

(async () => {
  const web3 = new Web3(PROVIDER);

  const nonce = await web3.eth.getTransactionCount(WALLET_ADDRESS, "latest");

  const transaction = {
    to: "0x1BaB8030249382A887F967FcAa7FE0be7B390728",
    value: 100000000000,
    gas: 30000,
    maxFeePerGas: 2600000000,
    nonce: nonce,
  };

  const signedTx = await web3.eth.accounts.signTransaction(
    transaction,
    PRIVATE_KEY
  );

  web3.eth.sendSignedTransaction(
    signedTx.rawTransaction,
    function (error, hash) {
      if (!error) {
        console.log("🎉 The hash of your transaction is: ", hash);
      } else {
        console.log(
          "❗Something went wrong while submitting your transaction:",
          error
        );
      }
    }
  );
})();
