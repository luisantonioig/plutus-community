# MacOS setup for Plutus Pioneer Program

This is a step by step guide for getting the playground client and server running in the [plutus-apps](https://github.com/input-output-hk/plutus-apps.git) repository.
It should work on Catalina and Big Sur. (Was tested on 2 Macs with Big Sur).
However, if you run on an M1 Mac, you will need to add additional Nix configuration for your build to succeed. See [this guide](https://github.com/renzwo/cardano-plutus-apps-install-m1/blob/main/README.md).

## Credits
Cloned from [Reddit](https://www.reddit.com/r/cardano/comments/mmzut6/macos_plutus_playground_build_instructions/)

Go give u/RikAlexander karma!

## Setup

1 - Install Nix

    [$] sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume


2 - Close terminal & reopen (to make sure that all environment variables are set)

3 - Check Nix installation / version with

    [$] nix --version


4 - Edit the /etc/nix/nix.conf file

    [$] nano /etc/nix/nix.conf


5 - Add these lines to the file:

    substituters        = https://hydra.iohk.io https://iohk.cachix.org https://cache.nixos.org/
    trusted-public-keys = hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ= iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo= cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=


_**Note:**_ These lines are there to avoid very long build times

_**Note 2:**_ if the file /etc/nix/nix.conf doesn't exist: create it. (`[$] mkdir /etc/nix` for the directory and `[$] touch /etc/nix/nix.conf` for the file)

6 - Restart your computer