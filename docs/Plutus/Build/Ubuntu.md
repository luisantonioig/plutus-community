# Ubuntu
## Build and Run the Plutus Playground server and client

We now need to get the plutus-apps repo which contains the libraries for
working on Plutus and the Plutus Playground server.

```ssh
git clone https://github.com/input-output-hk/plutus-apps
cd plutus-apps
```

**Note** If you will be working on the Plutus Pioneer Project, it will be
necessary at this point to `git checkout ...` a specific commit to match the
class materials. That commit hash is listed in the exercises week## directory
in the `cabal.project` file. For more info on this, see [Working on contracts with and without cabal build](https://plutus-community.readthedocs.io/en/latest/Environment/Build/CabalBuild/)

Now we will run the Plutus Playground servers. We start these in a `nix-shell`
which sets up the environment and has working versions of tools.

**Note** Optionally, a project exists to control the two Plutus Playground
servers as a systemd service, making start/stop/restart much less manual. See
[plutus-playground-systemd](https://github.com/dino-/plutus-playground-systemd)
for installation and configuration. If you use this, skip past the "terminal
window" instructions below and access your new playground server in a browser.

Open two terminal windows

In terminal window 1

```ssh
cd plutus-apps
nix-shell
cd plutus-playground-server
plutus-playground-server
```

If it's successful, you should see `Interpreter ready`

In terminal window 2

```ssh
cd plutus-apps
nix-shell
cd plutus-playground-client
npm run start
```

If it's successful, you should see `[wdm]: Compiled successfully.`

You should now be able to navigate to <https://localhost:8009>. The browser
will complain about it being a risky website, allow it.

