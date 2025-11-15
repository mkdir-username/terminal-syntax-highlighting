#!/usr/bin/env zsh

# ═══════════════════════════════════════════════════════════════
# TERMINAL SYNTAX HIGHLIGHTING - MAIN LOADER
# Universal syntax highlighting for all terminals
# Optimized for JavaScript/TypeScript development workflow
# ═══════════════════════════════════════════════════════════════

# Get the directory where this script is located
SYNTAX_DIR="${0:A:h}"

# ═══════════════════════════════════════════════════════════════
# 1. LOAD ERROR HIGHLIGHTING
# ═══════════════════════════════════════════════════════════════

if [[ -f "$SYNTAX_DIR/error_highlighting.zsh" ]]; then
  source "$SYNTAX_DIR/error_highlighting.zsh"
else
  echo "⚠️  Warning: error_highlighting.zsh not found"
fi

# ═══════════════════════════════════════════════════════════════
# 2. LOAD COMMAND WRAPPERS
# ═══════════════════════════════════════════════════════════════

if [[ -f "$SYNTAX_DIR/command_wrappers.zsh" ]]; then
  source "$SYNTAX_DIR/command_wrappers.zsh"
else
  echo "⚠️  Warning: command_wrappers.zsh not found"
fi

# ═══════════════════════════════════════════════════════════════
# 3. LOAD GIT VISUALIZATION
# ═══════════════════════════════════════════════════════════════

if [[ -f "$SYNTAX_DIR/git_visualization.zsh" ]]; then
  source "$SYNTAX_DIR/git_visualization.zsh"
else
  echo "⚠️  Warning: git_visualization.zsh not found"
fi

# ═══════════════════════════════════════════════════════════════
# 4. GRC INTEGRATION (if available)
# ═══════════════════════════════════════════════════════════════

if command -v grc &>/dev/null; then
  alias ping='grc ping'
  alias traceroute='grc traceroute'
  alias netstat='grc netstat'
  alias ps='grc ps'
  alias df='grc df'
  alias du='grc du'
  alias mount='grc mount'
  alias ifconfig='grc ifconfig'
  alias dig='grc dig'
  alias nmap='grc nmap'
  alias make='grc make'
  alias gcc='grc gcc'
  alias configure='grc configure'
  alias env='grc env'
fi

# ═══════════════════════════════════════════════════════════════
# SUCCESS MESSAGE
# ═══════════════════════════════════════════════════════════════

echo "✅ Terminal syntax highlighting loaded successfully"
