#!/bin/bash

set -eufo pipefail

echo ""
echo "🤚  This script will setup .dotfiles for you."
read -n 1 -r -s -p $'    Press any key to continue or Ctrl+C to abort...\n\n'

while true; do
  read -p "Is this a work machine [Y/n]?" yn
  case $yn in
  [Yy]*)
    MACHINE_TYPE="work"
    break
    ;;
  [Nn]*)
    MACHINE_TYPE="personal"
    break
    ;;
  *) echo "Please answer yes or no." ;;
  esac
done

# Install Homebrew
command -v brew >/dev/null 2>&1 ||
  (echo '🍺  Installing Homebrew' && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)")

# Install brew packages and casks
if command -v brew &>/dev/null; then
  echo '🍺  Installing packages and casks'
  /bin/bash -c "./install_brew_packages.sh $MACHINE_TYPE"
fi

# run gnu stow
if command -v stow >/dev/null; then
  echo '🐃  Stowing dotfiles' && stow "~/dotfiles"
fi

echo ""
echo "Done."
