# Ovyerus' dotfiles

Dotfiles and other home configuration for my Unix machines. As of writing I only
apply this to my Darwin desktops, and as such this purely assumes such an
environment. I may expand this to work on my Linux servers (and desktops
eventually) in the future.

## Installing

Make sure you have [Nix](https://nixos.org/) installed on your machine -
[nix-installer](https://github.com/DeterminateSystems/nix-installer) is the
easiest method - or use NixOS.

If you don't use nix-installer, you will need to enable the
[`flakes`](https://nixos.org/manual/nix/stable/contributing/experimental-features#xp-feature-flakes)
and
[`nix-command`](https://nixos.org/manual/nix/stable/contributing/experimental-features#xp-feature-nix-command)
experimental features.

```
git clone https://github.com/Ovyerus/dotfiles.git ~/.config/home-manager
nix run home-manager/master -- init --switch
```

## License

All data in this repository is available under the [MIT-0 License](./LICENSE).
