# Ubuntu (Fresh Install)
## Build and Run the Plutus Playground server and client

With Nix now installed and configured,  we will clone the appropriate repositories from github. We will be cloning the plutus-apps and the plutus-pioneer program.
First, let’s clone plutus-apps:
```
totinj@penguin:~$ git clone https://github.com/input-output-hk/plutus-apps.git
```
Next, let’s clone the plutus-pioneer-program repo:
```
totinj@penguin:~$ git clone https://github.com/input-output-hk/plutus-pioneer-program.git
```
You can now navigate to the current week01 directory in the plutus-pioneer-program folder and open the cabal.project file:
```
totinj@penguin:~/plutus-pioneer-program/code/week01$ cat cabal.project
```
 Grab the plutus-apps tag inside the cabal.project file:
```
location: https://github.com/input-output-hk/plutus-apps.git
 tag:41149926c108c71831cfe8d244c83b0ee4bf5c8a
```
Head back to  to the plutus-apps directory and update it to the  current git tag:
```
totinj@penguin:~/plutus-apps$ git checkout main
```
```
totinj@penguin:~/plutus-apps$ git pull
```
```
totinj@penguin:~/plutus-apps$ git checkout 41149926c108c71831cfe8d244c83b0ee4bf5c8a
```


You should now be up to date and can run nix-shell in this directory. Run nix-shell:
```
totinj@penguin:~/plutus-apps$ nix-shell
```
Nix-shell will take a good amount of time to build the first time you are running it, so be patient. If you have setup your caches correctly, you will notice it building from https://hydra.iohk.io.
If successful, you should see the nix-shell:
```
[nix-shell:~/plutus-apps]$ 
```


Head back to the week01 folder to start running the cabal commands:
```
[nix-shell:~/plutus-pioneer-program/code/week01]$ cabal update
```
```
[nix-shell:~/plutus-pioneer-program/code/week01]$ cabal build
```
```
[nix-shell:~/plutus-pioneer-program/code/week01]$ cabal repl
```
These will also take a long time to run the first time. If successful,  you should now be ready to start the lecture:
```haskell
Ok, one module loaded.
Prelude Week01.EnglishAuction> 
```
