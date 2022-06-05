const Piggy = artifacts.require("Piggy");

module.exports = function (deployer) {
  deployer.deploy(Piggy, {
    from: '0xab4343DbC287a415c1c459815835a176Eb988B1d'
  });
};
