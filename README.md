# Dotfile Stow Repo

This repository houses the dotfiles that I use to configure my system, as well as installation scripts to install all the brew formulae and packages that I use.

It relies on:
- 🍺 [Homebrew](https://brew.sh/) - my preferred MacOS package manager, and
- 🐃 [GNU Stow](https://www.gnu.org/software/stow/manual/) - a simple yet powerful dotfile manager.

I am lazy, so I've automated installing both of those along with everything else. 

## How to use this repo

1. [fork this repo](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo) to make your own copy. Call it `dotfiles` to make your life easy. Or don't - it's your machine.
2. Clone your repo into `~/dotfiles`:
    ```bash
    git clone git@github.com:<YOUR_GITHUB_USERNAME>/dotfiles.git
    ```
3. Examine the package lists in `install_brew_packages.sh` and change them accordingly. Note that you can specify them on a work / personal basis machine basis.
4. Change, add or remove any config files to your liking.
5. Move or rename any existing dotfiles on your system that may conflict with the stowed dotfiles.
6. Run the installer script. It will prompt you to say whether this is a work or personal machine.
    ```bash 
    cd ~/dotfiles/scripts && bash ./install.sh
    ```
And you're done! Confirm that everything worked as it should by confirming that your dotfiles symlinks are where they should be. 

## Notes
1. It's possible to store your dotfiles elsewhere than in your home repo.
2. If you want machine-specific configs, you can use `stow` to stow specific subfolders based on the machine you're working on.
3. Include anything stored in your repo that isn't meant to be symlinked in the `stow-local-ignore` file.
4. Refer to either the [Homebrew](https://brew.sh/) or [GNU Stow](https://www.gnu.org/software/stow/manual/) docs for other options if required.
