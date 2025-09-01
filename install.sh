#!/bin/bash

set -e  # Exit on any error

USER_HOME="$HOME"

echo "==> Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "==> Configuring Homebrew environment for user: $USER"
echo >> "$USER_HOME/.zprofile"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$USER_HOME/.zprofile"
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "==> Reading installs.txt into command list..."
mapfile -t commands < installs.txt

for cmd in "${commands[@]}"; do
    # Skip empty lines or comments
    [[ -z "$cmd" || "$cmd" =~ ^# ]] && continue

    echo "🔧 Running: $cmd"
    eval "$cmd"
done

echo "==> Copying .config/ to $USER_HOME/.config..."
cp -r .config "$USER_HOME/.config"

echo "==> Copying .tmux.conf to $USER_HOME/.tmux.conf..."
cp .tmux.conf "$USER_HOME/.tmux.conf"

echo "==> Copying .zshrc to $USER_HOME/.zshrc..."
cp .zshrc "$USER_HOME/.zshrc"

echo "==> Setting Git Username"
git config --global user.name "0xlgmz"

echo "==> Setting Git Email"
git config --global user.email lgomez13677@gmail.com

echo "✅ Environment setup complete for $USER!"

