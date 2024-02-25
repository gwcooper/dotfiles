#!/bin/bash

set -eufo pipefail

formulae=(
  awscli
  fzf
  git
  git-lfs
  lazygit
  maccy
  neovim
  pyenv
  ripgrep
  zoxide
  zsh-autosuggestions
  zsh-syntax-highlighting
  tree-sitter
  stow
  starship
  ruff
  luarocks
  eza
  bat
)

casks=(
  apparency
  appcleaner
  arc
  cheatsheet
  firefox
  jupyter-notebook-viewer
  netron
  obsidian
  qlcolorcode
  qlmarkdown
  qlstephen
  qlvideo
  quicklook-json
  slack
  suspicious-package
  syntax-highlight
  the-unarchiver
  visual-studio-code
  vlc
  wezterm
  whatsapp
  zoom
)

# Machine specific installs
if [[ "$1" = "work" ]]; then
  echo "💼  Adding additional work formulae and casks"
  forumulae+=(
    hdf5
  )

  casks+=(
    tunnelblick
  )
fi

if [[ "$1" = "personal" ]]; then
  echo "🤸  Adding additional personal formulae and casks"
  casks+=(
    arduino-ide
    autodesk-fusion360
    discord
    steam
  )
fi

brew update

brew install ${formulae[@]}
brew install --cask ${casks[@]}

brew cleanup
