# 🎨 Terminal Syntax Highlighting

Universal terminal syntax highlighting system optimized for **JavaScript/TypeScript development workflow**.

Enhanced visual feedback for errors, warnings, success messages, and file paths across **all major terminals**: Warp, iTerm2, VSCode integrated terminal, and standard terminals.

## ✨ Features

### 🎯 Smart Error Detection
- **Instant visibility** of errors and warnings
- **Context-aware** highlighting (doesn't color "terrored" when looking for "error")
- **Multiple error formats** supported: JavaScript, TypeScript, Jest, ESLint, React, Next.js

### 🚀 Optimized for Modern JS/TS Stack
- **React** error boundaries and component highlighting
- **Next.js** compilation status and errors
- **Jest** test results with pass/fail indicators
- **TypeScript** compiler errors with coordinates
- **ESLint** warnings and errors
- **npm/yarn** build status and dependency warnings

### 🌈 Color Philosophy
Inspired by **GitHub AMOLED** theme:
- **Bright accents** (#f38ba8) for critical information (errors)
- **Muted secondary** (#585b70) for stack traces and timing
- **Yellow warnings** (#f9e2af) for non-critical issues
- **Green success** (#a6e3a1) for completed operations
- **Cyan paths** (#94e2d5) for file locations

### 🎨 Universal Terminal Support
- ✅ **Warp Terminal** - 3 custom themes included
- ✅ **iTerm2** - 3 color schemes included
- ✅ **VSCode Terminal** - Full configuration
- ✅ **Standard terminals** - Works with any ANSI-compatible terminal

## 📸 Screenshots

### Errors & Warnings
```
❌ Build failed
⚠️  Critical dependency detected
✖ 3 errors
⚠  2 warnings
```

### Test Results
```
✓ PASS  2 passed
✗ FAIL  1 failed
      3 total
```

### React Errors
```
SyntaxError: Unexpected token
    in ErrorBoundary
    at Object.<anonymous> (App.tsx:12:5)
```

## 🚀 Quick Start

### One-Line Installation

```bash
git clone https://github.com/mkdir-username/terminal-syntax-highlighting.git ~/terminal-syntax-highlighting
cd ~/terminal-syntax-highlighting
./scripts/install.sh
```

### Manual Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/mkdir-username/terminal-syntax-highlighting.git ~/terminal-syntax-highlighting
   ```

2. **Add to your `.zshrc`**
   ```bash
   echo 'source ~/terminal-syntax-highlighting/configs/zsh/syntax-highlighting.zsh' >> ~/.zshrc
   ```

3. **Configure git-delta** (optional but recommended)
   ```bash
   cat ~/terminal-syntax-highlighting/configs/git/gitconfig >> ~/.gitconfig
   brew install git-delta
   ```

4. **Install grc** (optional - for system commands)
   ```bash
   brew install grc
   ```

5. **Apply terminal themes** (choose your terminal below)

## 🎨 Terminal-Specific Setup

### Warp Terminal

1. Copy themes to Warp config:
   ```bash
   mkdir -p ~/.warp/themes
   cp ~/terminal-syntax-highlighting/themes/warp/*.yaml ~/.warp/themes/
   ```

2. Activate theme:
   - Open Warp
   - `Cmd + ,` → Appearance → Theme
   - Select one of:
     - **Enhanced Errors** (balanced)
     - **High Contrast Errors** (maximum visibility)
     - **Monokai Errors** (Monokai style)

### iTerm2

1. Import color schemes:
   - Open iTerm2
   - `Cmd + ,` → Profiles → Colors
   - Color Presets → Import
   - Select files from `~/terminal-syntax-highlighting/themes/iterm2/`

2. Apply imported scheme

### VSCode Integrated Terminal

1. Open VSCode settings:
   ```bash
   code ~/Library/Application\ Support/Code/User/settings.json
   ```

2. Merge with the config from:
   ```
   ~/terminal-syntax-highlighting/configs/vscode/terminal-settings.json
   ```

3. Restart VSCode or open new terminal (`Ctrl + \``)

## 📦 What's Included

### Configuration Files
```
configs/
├── zsh/
│   ├── syntax-highlighting.zsh   # Main loader
│   ├── error_highlighting.zsh    # Error detection
│   ├── command_wrappers.zsh      # npm, jest, tsc, etc.
│   └── git_visualization.zsh     # Git commands
├── git/
│   └── gitconfig                 # Git-delta settings
└── vscode/
    └── terminal-settings.json    # VSCode terminal colors
```

### Themes
```
themes/
├── warp/                         # 3 Warp themes
│   ├── enhanced_errors.yaml
│   ├── high_contrast_errors.yaml
│   └── monokai_errors.yaml
└── iterm2/                       # 3 iTerm2 color schemes
    ├── Enhanced_Errors.itermcolors
    ├── High_Contrast_Errors.itermcolors
    └── Monokai_Errors.itermcolors
```

### Demo Scripts
```
demos/
├── demo_js_syntax_v2.sh         # Visual demonstration
└── test_edge_cases.sh           # Edge case testing
```

## 🛠️ Available Functions

### Visual Indicators
```bash
show_error "текст"      # ❌ red error message
show_warning "текст"    # ⚠️  yellow warning
show_success "текст"    # ✅ green success
show_info "текст"       # ℹ️  blue information
```

### Enhanced Git Commands
```bash
gst / gsp              # Pretty git status
glog / glp             # Formatted git log
gdiff / gdp            # Enhanced git diff
gmod                   # Show modified files
guntr                  # Show untracked files
```

### Command Wrappers (with auto-highlighting)
```bash
npm <args>             # npm with error highlighting
yarn <args>            # yarn with highlighting
jest <args>            # jest with test result colors
tsc <args>             # TypeScript compiler
eslint <args>          # ESLint
next <args>            # Next.js dev server
python3 <args>         # Python
docker <args>          # Docker
```

## 🎯 What Gets Highlighted

### 🔴 Errors (Bright Red)
- `error`, `Error`, `ERROR`
- `failed`, `Failed`, `FAILED`
- `fatal`, `Fatal`, `FATAL`
- `SyntaxError`, `TypeError`, `ReferenceError`
- `Build failed`
- `No such file or directory`
- `permission denied`
- `[FAIL]`, `[ERROR]`, `[FATAL]`

### 🟡 Warnings (Yellow)
- `warning`, `Warning`, `WARNING`
- `warn`, `Warn`, `WARN`
- `deprecated`
- `Critical dependency` (warning, not error!)
- `[WARN]`, `[WARNING]`

### 🟢 Success (Green)
- `success`, `Success`
- `done`, `Done`
- `passed` (with numbers: `2 passed`)
- `[OK]`, `[PASS]`, `[SUCCESS]`

### 🔵 Information (Cyan)
- `info`, `Info`, `INFO`
- `note`, `Note`, `NOTE`
- File paths (underlined)
- React component names (`in ErrorBoundary`)
- `[INFO]`, `[NOTE]`

### Numbers with Context
- `2 passed` → green (both number and word)
- `1 failed` → red
- `3 total` → cyan
- `Just number: 2` → white (no context, not colored)

### Symbols
- `✖ 3 errors` → entire phrase red
- `⚠ 2 warnings` → entire phrase yellow

## 🧪 Testing

Run the demo script to see all highlighting in action:
```bash
~/terminal-syntax-highlighting/demos/demo_js_syntax_v2.sh
```

Test edge cases:
```bash
~/terminal-syntax-highlighting/demos/test_edge_cases.sh
```

## 📝 Edge Cases Handled

1. ✅ **Pattern conflicts**: "error" colored, "terrored" not colored
2. ✅ **Whole word matching**: "ErrorBoundary" colored as complete word
3. ✅ **Multiple errors on one line**: All colored independently
4. ✅ **Paths with special characters**: Correctly underlined
5. ✅ **Different coordinate formats**: TypeScript, ESLint, Jest
6. ✅ **Nested Expected/Received**: Jest comparisons highlighted
7. ✅ **Webpack format**: `ERROR in ./src/...` properly colored
8. ✅ **Numbers with/without context**: Only contextual numbers colored
9. ✅ **Symbols with text**: `✖ 3 errors` fully colored
10. ✅ **Critical dependency**: Yellow warning, not red error

## 🔧 Customization

### Change Colors

Edit `~/terminal-syntax-highlighting/configs/zsh/error_highlighting.zsh`:
```bash
local RED='\033[38;5;203m'    # Change to your preferred ANSI code
local YELLOW='\033[1;33m'
# etc.
```

### Add Custom Patterns

Edit the sed pipeline in any wrapper function:
```bash
npm() {
  command npm "$@" 2>&1 | sed -E \
    -e "s/(your_pattern)/\x1b[38;5;203m\1\x1b[0m/g" \
    # ... existing patterns
}
```

### Disable for Specific Command

Use `command` prefix to bypass wrapper:
```bash
command npm install    # npm without highlighting
```

## 🐛 Troubleshooting

### Colors not displaying
```bash
# Check TERM variable
echo $TERM
# Should be: xterm-256color

# Check 256 color support
tput colors
# Should be: 256
```

### Functions not working
```bash
# Reload configuration
source ~/.zshrc

# Check function exists
type show_error
type git_status_pretty
```

### Git delta not working
```bash
# Check installation
which delta

# Check git config
git config --get core.pager
# Should be: delta
```

## 📚 Dependencies

### Required
- **zsh** - Shell
- **Oh My Zsh** - With `zsh-syntax-highlighting` plugin

### Optional (but recommended)
- **git-delta** - Enhanced git diff visualization
  ```bash
  brew install git-delta
  ```

- **grc** - Generic colouriser for system commands
  ```bash
  brew install grc
  ```

- **Nerd Font** - For symbols in terminal (e.g., MesloLGS NF)
  ```bash
  brew tap homebrew/cask-fonts
  brew install font-meslo-lg-nerd-font
  ```

## 🤝 Contributing

Issues and pull requests are welcome! Please feel free to:
- Report bugs
- Suggest new features
- Submit edge cases
- Improve documentation

## 📄 License

MIT License - feel free to use and modify

## 🙏 Acknowledgments

- Inspired by **GitHub AMOLED** color scheme
- Built for **React/Next.js/TypeScript** developers
- Tested with **Warp**, **iTerm2**, and **VSCode** terminals

---

**Enjoy colorful terminal! 🌈**

Made with ❤️ for developers who debug a lot
