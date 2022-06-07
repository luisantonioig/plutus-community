# Welcome to the Plutus Challenge Track 

This is the repo for the Plutus Challenge Track post-Consensus in Austin, TX, 2022. The goal of this challenge is to implement Plutus v2 capabilities that support major improvements of the Cardano Blockchain such as CIPs 31, 32, 33.

If you want to learn more please check out [Cardano Improvement Proposals](https://cips.cardano.org/)

# Getting started

To go through this track you MUST have your environment set up with Nix. If you are a Plutus Pioneer this might be familiar and you have this step sorted out already. If not, then follow along [this guide](https://plutus-community.readthedocs.io/en/latest/) for your personal operating system, under:


- Environment Setup
    - Build instructions

We will demonstrate the capabilities 

# Oracle

Oracles are a crucial service for developing any software application. They are data providers that provide information about real-world events so we can then do something useful with this.

In this challenge we are implementing an Oracle service to get the price feed of the USDT-ADA pair and then perform swaps. This is the same problem presented in the Plutus Pioneers Iterations 1 & 2.

**The Goal** here is to now re-implement the Oracle using the more powerful Vasil capabilities.
