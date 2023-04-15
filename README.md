# dotfiles

This repository contains the dotfiles for all the main tools that I use for the development on my
MacBook. It focuses on making the macOS experience to be more keyboard-centric and, therefore
productive/efficient, by using a tile window manager, removing unnecessary animations, etc.

However, my setup also tries to be minimal and not require additional macOS security configuration
shenanigans.

You're more than welcome to try my configuration for yourself - more details in the [Setup](#setup)
section.

## Mentions

Thanks to:
* [@FelixKratz](https://github.com/FelixKratz) and his
[dotfiles repository](https://github.com/FelixKratz/dotfiles). A lot of ideas were ~~stolen~~
borrowed from his dotfiles repo.
* [@Marcoleni](https://github.com/MarcoIeni) and his
[intellimacs](https://github.com/MarcoIeni/intellimacs) project. I wouldn't have had the
required patience to search up all the action mappings in IntelliJ IDEA myself, so, I ended up
using this repository as a reference for my own [.ideavimrc](./.ideavimrc) configuration file.

## Setup

If you're interested in checking out my setup, all you need to do is to:
1. Have ssh set up on your machine for GitHub communication.
2. Run the [.install.sh](./.install.sh) script.

The installation of tools and setup process is automated, you'll only have to answer two terminal
prompts and that's it.

NOTE: If you're using the default Macbook keyboard -> consider installing Karabiner Elements. I've
migrated to a mechanical keyboard -
[Keyboardio Atreus](https://shop.keyboard.io/products/keyboardio-atreus). However, I've used
the native keyboard before that with the following
[Karabiner's complex modifications](./other/karabiner-complex-modifications.png) before that for
productivity.

## Other Cool Tools I Use

* [SurfingKeys](https://github.com/brookhong/Surfingkeys) extension for Google Chrome.

