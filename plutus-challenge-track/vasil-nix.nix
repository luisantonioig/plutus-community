{ version ? "testnet", pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/6525bbc06a39f26750ad8ee0d40000ddfdc24acb.tar.gz") { }}:
let
  cardano-node-repo = import ./. { };

in pkgs.mkShell {
  buildInputs = with pkgs; [
    libsodium
    cabal-install
    zlib
    haskell.compiler.ghc8104
    haskellPackages.haskell-language-server

    cardano-node-repo.cardano-node
    cardano-node-repo.cardano-cli
  ];

  CARDANO_NODE_SOCKET_PATH = "/home/antonio/projects2/haskell/cardano-world/node.socket";

}
