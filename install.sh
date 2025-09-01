#!/bin/bash

set -e  # Exit on any error

USER_HOME="$HOME"

echo "==> Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "==> Configuring Homebrew environment for user: $USER"
echo >> "$USER_HOME/.zprofile"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$USER_HOME/.zprofile"
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "==> Running commands from install.txt..."
while IFS= read -r cmd || [ -n "$cmd" ]; do
    if [[ -z "$cmd" || "$cmd" =~ ^# ]]; then
        continue  # Skip empty lines and comments
    fi
    echo "Running: $cmd"
    eval "$cmd"
done < install.txt

echo "==> Copying .config/ to $USER_HOME/.config..."
cp -r .config "$USER_HOME/.config"

echo "==> Copying .tmux.conf to $USER_HOME/.tmux.conf..."
cp .tmux.conf "$USER_HOME/.tmux.con_

