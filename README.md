# CirnOS
- These files are taken from https://github.com/end-4/CirnOS and they include my own hardware configuration which might not 
work for you. 

# Installation
## Installing the whole system
Follow the following steps(Please file a bug if it doesn't work) - 
1. Change the hosts/<username>/hardware-configuration.nix with your own
2. Change the name of folders inside home/ and hosts/ to your own username
3. Change the username, home-manager username and hostname in `./homes/default.nix`, `./hosts/default.nix` & if it 
occurs at any other place. Note that if you don't, you might end up with a TTY session with no desktop. 
4. Install home-manager and hyprland in your /etc/nixos/configuration.nix before you install dotFiles.

```bash
git clone https://github.com/kaljitism/CirnOS.git && cd CirnOS
```

```bash
IMPURITY_PATH=$(pwd) sudo --preserve-env=IMPURITY_PATH nixos-rebuild switch --flake . --impure
```

