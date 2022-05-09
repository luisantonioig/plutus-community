# ArchLinux
## Build and Run the Plutus Playground server and client

Clone the plutus-apps repository and change your working directory.

```
$ git clone https://github.com/input-output-hk/plutus-apps.git
$ cd plutus-apps
```

Based on the PPP week, checkout the desired commit.

Build the server:
```
$ GC_DONT_GC=1 nix-build -A plutus-playground.server
```

Build the client:
```
$ GC_DONT_GC=1 nix-build -A plutus-playground.client
```

Start an interactive shell based on the plutus-apps default Nix expression:
> This step could take a while.
```
$ nix-shell
```

Position into the server directory and start the server:
```
$ cd plutus-playground-server
$ GC_DONT_GC=1 plutus-playground-server
```

Wait for the server to log `Interpreter ready`.

Open a new terminal and position in the `plutus-apps` directory.
Again, start the shell:
```
$ nix-shell
```

Position into the client directory and start the client:
```
$ cd plutus-playground-client
$ GC_DONT_GC=1 npm run start
```

Wait for the client to log `ℹ ｢wdm｣: Compiled successfully.`.

## Usage

Navigate to [https://0.0.0.0:8009/](https://0.0.0.0:8009/) in your browser.
