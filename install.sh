#!/bin/bash

set -e  # Exit on any error

echo "==> Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "==> Running commands from installs.txt..."
while IFS= read -r cmd || [ -n "$cmd" ]; do
    if [[ -z "$cmd" || "$cmd" =~ ^# ]]; then
        continue  # Skip empty lines and comments
    fi
    echo "Running: $cmd"
    eval "$cmd"
done < installs.txt

echo "==> Copying .config/ to \$HOME..."
cp -r .config "$HOME/.config"

echo "==> Copying .tmux.conf to \$HOME..."
cp .tmux.conf "$HOME/.tmux.conf"

echo "✅ Setup complete!"

