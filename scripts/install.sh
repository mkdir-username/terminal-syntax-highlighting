#!/usr/bin/env zsh

# ═══════════════════════════════════════════════════════════════
# TERMINAL SYNTAX HIGHLIGHTING - INSTALLATION SCRIPT
# Automated setup for universal syntax highlighting
# ═══════════════════════════════════════════════════════════════

set -e  # Exit on error

# Colors for installer output
RED='\033[38;5;203m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
BLUE='\033[1;34m'
NC='\033[0m'

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
CONFIGS_DIR="$REPO_DIR/configs"

# ═══════════════════════════════════════════════════════════════
# HELPER FUNCTIONS
# ═══════════════════════════════════════════════════════════════

print_header() {
  echo ""
  echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
  echo -e "${CYAN}  $1${NC}"
  echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
  echo ""
}

print_success() {
  echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
  echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
  echo -e "${RED}❌ $1${NC}"
}

print_info() {
  echo -e "${BLUE}ℹ️  $1${NC}"
}

ask_yes_no() {
  local prompt="$1"
  echo -ne "${YELLOW}❓ $prompt [y/N]: ${NC}"
  read -r response
  [[ "$response" =~ ^[Yy]$ ]]
}

# ═══════════════════════════════════════════════════════════════
# INSTALLATION STEPS
# ═══════════════════════════════════════════════════════════════

print_header "TERMINAL SYNTAX HIGHLIGHTING INSTALLER"

print_info "Installation directory: $REPO_DIR"
echo ""

# ───────────────────────────────────────────────────────────────
# Step 1: Check Prerequisites
# ───────────────────────────────────────────────────────────────

print_header "STEP 1: Checking Prerequisites"

# Check zsh
if command -v zsh &>/dev/null; then
  print_success "zsh is installed"
else
  print_error "zsh is not installed. Please install zsh first."
  exit 1
fi

# Check Oh My Zsh
if [[ -d "$HOME/.oh-my-zsh" ]]; then
  print_success "Oh My Zsh is installed"
else
  print_warning "Oh My Zsh not found. Installing is recommended."
  if ask_yes_no "Install Oh My Zsh now?"; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    print_success "Oh My Zsh installed"
  fi
fi

# Check zsh-syntax-highlighting plugin
if [[ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]]; then
  print_success "zsh-syntax-highlighting plugin is installed"
else
  print_warning "zsh-syntax-highlighting plugin not found"
  if ask_yes_no "Install zsh-syntax-highlighting plugin?"; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
      "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
    print_success "zsh-syntax-highlighting plugin installed"
    print_info "Don't forget to add it to plugins in .zshrc: plugins=(... zsh-syntax-highlighting)"
  fi
fi

# ───────────────────────────────────────────────────────────────
# Step 2: Install Core Configuration
# ───────────────────────────────────────────────────────────────

print_header "STEP 2: Installing Core Configuration"

# Backup existing .zshrc
if [[ -f "$HOME/.zshrc" ]]; then
  backup_file="$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
  cp "$HOME/.zshrc" "$backup_file"
  print_success "Backed up .zshrc to: $backup_file"
fi

# Add source line to .zshrc
LOADER_LINE="source $REPO_DIR/configs/zsh/syntax-highlighting.zsh"

if grep -qF "$LOADER_LINE" "$HOME/.zshrc" 2>/dev/null; then
  print_warning "Syntax highlighting already configured in .zshrc"
else
  echo "" >> "$HOME/.zshrc"
  echo "# ═══════════════════════════════════════════════════════════════" >> "$HOME/.zshrc"
  echo "# TERMINAL SYNTAX HIGHLIGHTING" >> "$HOME/.zshrc"
  echo "# ═══════════════════════════════════════════════════════════════" >> "$HOME/.zshrc"
  echo "$LOADER_LINE" >> "$HOME/.zshrc"
  print_success "Added syntax highlighting to .zshrc"
fi

# ───────────────────────────────────────────────────────────────
# Step 3: Install git-delta (optional)
# ───────────────────────────────────────────────────────────────

print_header "STEP 3: git-delta (Enhanced Git Diff)"

if command -v delta &>/dev/null; then
  print_success "git-delta is already installed"
else
  print_info "git-delta provides enhanced git diff visualization"
  if ask_yes_no "Install git-delta via Homebrew?"; then
    if command -v brew &>/dev/null; then
      brew install git-delta
      print_success "git-delta installed"
    else
      print_error "Homebrew not found. Please install Homebrew first or install git-delta manually."
    fi
  else
    print_warning "Skipping git-delta installation"
  fi
fi

# Configure git-delta
if command -v delta &>/dev/null; then
  if ask_yes_no "Configure git to use delta?"; then
    # Backup existing .gitconfig
    if [[ -f "$HOME/.gitconfig" ]]; then
      backup_file="$HOME/.gitconfig.backup.$(date +%Y%m%d_%H%M%S)"
      cp "$HOME/.gitconfig" "$backup_file"
      print_success "Backed up .gitconfig to: $backup_file"
    fi

    # Append delta configuration
    cat "$CONFIGS_DIR/git/gitconfig" >> "$HOME/.gitconfig"
    print_success "git-delta configured"
  fi
fi

# ───────────────────────────────────────────────────────────────
# Step 4: Install grc (optional)
# ───────────────────────────────────────────────────────────────

print_header "STEP 4: grc (Generic Colouriser)"

if command -v grc &>/dev/null; then
  print_success "grc is already installed"
else
  print_info "grc provides automatic highlighting for system commands (ping, netstat, etc.)"
  if ask_yes_no "Install grc via Homebrew?"; then
    if command -v brew &>/dev/null; then
      brew install grc
      print_success "grc installed"
    else
      print_error "Homebrew not found. Please install grc manually."
    fi
  else
    print_warning "Skipping grc installation"
  fi
fi

# ───────────────────────────────────────────────────────────────
# Step 5: Install Terminal Themes (optional)
# ───────────────────────────────────────────────────────────────

print_header "STEP 5: Terminal Themes"

# Warp themes
if ask_yes_no "Install Warp terminal themes?"; then
  mkdir -p "$HOME/.warp/themes"
  cp "$REPO_DIR/themes/warp"/*.yaml "$HOME/.warp/themes/"
  print_success "Warp themes installed to ~/.warp/themes/"
  print_info "Activate in Warp: Cmd + , → Appearance → Theme"
fi

# iTerm2 themes
if ask_yes_no "Install iTerm2 color schemes?"; then
  mkdir -p "$HOME/.iterm2_colors"
  cp "$REPO_DIR/themes/iterm2"/*.itermcolors "$HOME/.iterm2_colors/"
  print_success "iTerm2 themes installed to ~/.iterm2_colors/"
  print_info "Import in iTerm2: Cmd + , → Profiles → Colors → Color Presets → Import"
fi

# VSCode settings
if ask_yes_no "Show VSCode terminal configuration?"; then
  echo ""
  echo -e "${CYAN}VSCode Terminal Configuration:${NC}"
  echo ""
  echo "1. Open: ~/Library/Application Support/Code/User/settings.json"
  echo "2. Merge with: $CONFIGS_DIR/vscode/terminal-settings.json"
  echo "3. Restart VSCode"
  echo ""
  if ask_yes_no "Open VSCode settings file now?"; then
    code "$HOME/Library/Application Support/Code/User/settings.json" 2>/dev/null || \
      print_warning "Could not open VSCode. Please open settings.json manually."
  fi
fi

# ═══════════════════════════════════════════════════════════════
# INSTALLATION COMPLETE
# ═══════════════════════════════════════════════════════════════

print_header "INSTALLATION COMPLETE"

print_success "Terminal syntax highlighting installed successfully!"
echo ""
print_info "Next steps:"
echo ""
echo "  1. Reload your shell configuration:"
echo -e "     ${CYAN}source ~/.zshrc${NC}"
echo ""
echo "  2. Try some commands to see highlighting:"
echo -e "     ${CYAN}gst${NC}                    # Pretty git status"
echo -e "     ${CYAN}npm install${NC}            # npm with error highlighting"
echo -e "     ${CYAN}show_error \"test\"${NC}      # Test error display"
echo ""
echo "  3. Run the demo script:"
echo -e "     ${CYAN}$REPO_DIR/demos/demo_js_syntax_v2.sh${NC}"
echo ""
echo "  4. Test edge cases:"
echo -e "     ${CYAN}$REPO_DIR/demos/test_edge_cases.sh${NC}"
echo ""

print_info "For more information, see: $REPO_DIR/README.md"
echo ""

if ask_yes_no "Reload .zshrc now?"; then
  source "$HOME/.zshrc"
  print_success "Configuration reloaded!"
else
  print_warning "Remember to reload: source ~/.zshrc"
fi

echo ""
print_success "Enjoy your colorful terminal! 🌈"
echo ""
