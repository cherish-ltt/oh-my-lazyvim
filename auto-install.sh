#!/bin/bash
# Auto-install Neovim + LazyVim + Catppuccin Latte theme
# For macOS (uses Homebrew)

set -e

# 1. Check Homebrew
if ! command -v brew &>/dev/null; then
  echo "ERROR: Homebrew not found. Please install Homebrew first."
  exit 1
fi

# 2. Install Neovim
echo "Installing Neovim..."
brew install nvim

# 3. Backup existing configs (if any)
echo "Backing up existing Neovim configs..."
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null || true
mv ~/.local/share/nvim ~/.local/share/nvim.bak 2>/dev/null || true
mv ~/.local/state/nvim ~/.local/state/nvim.bak 2>/dev/null || true
mv ~/.cache/nvim ~/.cache/nvim.bak 2>/dev/null || true

# 4. Clone LazyVim starter template
echo "Cloning LazyVim template..."
git clone https://github.com/LazyVim/starter ~/.config/nvim

# 5. Remove .git directory (for customisation)
echo "Removing .git directory..."
rm -rf ~/.config/nvim/.git

# 6. Add Catppuccin Latte theme plugin
echo "Creating Catppuccin theme config..."
mkdir -p ~/.config/nvim/lua/plugins
cat >~/.config/nvim/lua/plugins/catppuccin.lua <<'EOF'
return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  opts = {
    flavour = "latte",
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin-nvim")
  end,
}
EOF

# 7. Done
echo ""
echo "SUCCESS: Installation and configuration complete!"
echo "Start Neovim to let LazyVim install all plugins:"
echo "  nvim"
echo ""
echo "After startup, to enable LSP support, run inside Neovim:"
echo "  :LazyExtras"
echo "Then press 'x' to select desired LSP extras, and restart Neovim."
