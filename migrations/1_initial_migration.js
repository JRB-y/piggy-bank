const Migrations = artifacts.require("Migrations");

module.exports = function (deployer) {
  deployer.deploy(Migrations, {
    from: '0xab4343DbC287a415c1c459815835a176Eb988B1d'
  });
};
