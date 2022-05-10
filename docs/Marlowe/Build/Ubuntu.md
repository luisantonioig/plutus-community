# Installing Marlowe CLI and Associated Tools on Ubuntu

These instructions describe how to install a version of the Daedalus wallet and
Marlowe CLI tools configured for use with the Marlowe Pioneers Program.

These tools will be interacting with the Marlowe Pioneers testnet.

## 1 Prerequisites

You will need these some packages installed

- curl
- git
- wget (optional but will make downloading easier)

    sudo sh -c 'apt update && apt install curl git wget'

## 2 Daedalus wallet for the Marlowe Pioneers Program

Daedalus is the cardano full-node wallet. The version for Marlowe Pioneers runs
a Cardano node on the Marlowe Pioneers test network.

### 2.1 Installing Daedalus

Download the Daedalus Linux installer

If `wget` is installed on your system, we can get the specific file you need
for Ubuntu with one simple command

    wget -O daedalus-4.9.0-marlowe_pioneers-21668.bin "[URL to be supplied]"

Alternatively, you can browse for it on the website manually

- Navigate to <[URL to be supplied]>
- In the section at the top named `[DDW-1039] Update \`marlowe_pioneers\` icons`
  click the `daedalus-x86_64-linux-nix` button.
- In the info that expands, click the `Artifacts` tab
- In the list that expands, click the link for
  `csl-daedalus/daedalus-4.9.0-marlowe_pioneers-21668.bin` and the file download will start.

Either way, you should have a file now called `daedalus-4.9.0-marlowe_pioneers-21668.bin`

In a bash shell, run that file with `sh`. Note: as a regular user, NOT root

    sh daedalus-4.9.0-marlowe_pioneers-21668.bin

The installer will put the daedalus launcher at

    $HOME/.local/bin/daedalus-marlowe_pioneers

Run this to start the Daedalus wallet. It will sync with the testnet
blockchain.

### 2.2 Creating a Cardano Wallet using Daedalus

To use Daedalus we'll need to create or restore a wallet. Once the Daedalus
wallet is ready, click `Add wallet` on the main screen.

Click `Create`

Enter a nickname for the wallet and a password that will be used for spending.
Make a note of this password somewhere.

Daedalus will display a seed phrase and instructions for securing it. Keep a
record of this phrase as well so you can use the wallet at the command line or
in Marlowe Run.

While this would not be a safe idea for the mainnet, consider putting the
phrase in a file right now called `my-wallet.seed` which we will use later for
the command-line tools.

If you previously created a wallet using Marlowe Run, instead of creating a new
wallet, you can use the "Restore" function in place of "Create"

**Never reuse the seed phrase from any mainnet wallet on a test network like
the Marlowe Pioneers testnet.**

## 3 The Marlowe CLI and Cardano Tools

This section is needed if you want to use Marlowe from a Nix shell.

### 3.1 Installing Marlowe CLI and Cardano Tools

You will need to have Nix installed for your platform which is covered
elsewhere in this documentation:

    Environment Setup > Build Instructions > Ubuntu

Cloning the Git Repository for Marlowe

The `marlowe-cardano` repository contains the Marlowe source code,
documentation, examples and test cases. It's needed if you want to use Marlowe
from a Nix shell.

    git clone https://github.com/input-output-hk/marlowe-cardano.git -b mpp-cli-lectures

To use the tools in this directory, we'll need to be in a nix shell. Be
patient, this will take a while the first time.

    nix-shell marlowe-cardano/shell.nix

Once in the shell, query the versions of things

    marlowe-cli --version
    cardano-cli --version
    cardano-wallet version

If these look good, you're all set

### 3.2 Creating Payment and Signing Keys and the Wallet Address

In order to sign transactions with `marlowe-cli`, we'll need access to payment
and signing keys. We can create those for the wallet we created earlier with
Daedalus, here's how:

Let's say you put the seed passphrase into a text file called `my-wallet.seed`

    # View the seed phrase.
    cat my-wallet.seed

    broccoli tool napkin scale lab liquid staff turn equal city sail company govern hold rent act nurse orbit torch normal update master valley twenty

Store the payment signing key in a file `my-wallet.skey`

    cat my-wallet.seed | cardano-wallet key from-recovery-phrase Shelley | cardano-wallet key child 1852H/1815H/0H/0/0 > my-wallet.prv
    cardano-cli key convert-cardano-address-key --shelley-payment-key --signing-key-file my-wallet.prv --out-file my-wallet.skey
    rm my-wallet.prv

Store the payment verification key in a file `my-wallet.vkey`

    cardano-cli key verification-key --signing-key-file my-wallet.skey --verification-key-file my-wallet.vkey

Compute the address

    cardano-cli address build --testnet-magic 1567 --payment-verification-key-file my-wallet.vkey > my-wallet.address

We should have something similar to this now

    ls -l my-wallet.*

    -rw-r--r-- 1 bob bob  63 May  7 09:37 my-wallet.address
    -rw-rw-r-- 1 bob bob 143 May  6 16:48 my-wallet.seed
    -rw------- 1 bob bob 367 May  7 09:36 my-wallet.skey
    -rw------- 1 bob bob 244 May  7 09:36 my-wallet.vkey

### 3.3 Funding the Address of the Daedalus Wallet

You should have received an API key for the Marlowe Pioneers faucet. Make an
environment variable for this

    export FAUCET_KEY="<the API key>"

Run the following command to request test ADA

    curl -k -X POST https://faucet.pioneers.testnet.marlowe-finance.io/send-money/$(cat my-wallet.address)?apiKey=$FAUCET_KEY

You should see something like this

    {"success":true,"amount":1000000000000,"unit":"lovelace","fee":167965,"minLovelace":999978,"txid":"d8c062e3d350723938cae4f1708c4c5521ad349cd345c923f52f2ccba87fe311"}

In a minute or so, Daedalus should list the transaction that sent the fund and
update the wallet's balance.

### 3.4 Finding the cardano Node Socket

Start Daedalus, which will run a Cardano node on the Marlowe Pioneers test
networK. Some `marlowe-cli` commands require a connection to the `node_socket`.

Set an environment variable

    export CARDANO_NODE_SOCKET_PATH="$HOME/.local/share/Daedalus/marlowe_pioneers/cardano-node.socket"

Now we can check that `marlowe-cli` can communicate with the cardano node.

    marlowe-cli util select --testnet-magic 1567 --socket-path "$CARDANO_NODE_SOCKET_PATH" $(cat my-wallet.address)

Also check that `cardano-cli` can communicate with the cardano node.

    cardano-cli query utxo --testnet-magic 1567 --address $(cat my-wallet.address)
