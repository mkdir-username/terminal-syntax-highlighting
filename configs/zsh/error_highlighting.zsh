# ═══════════════════════════════════════════════════════════════
# ENHANCED ERROR HIGHLIGHTING AND VISUALIZATION
# Подсветка ошибок, предупреждений и успешных сообщений в выводе команд
# ═══════════════════════════════════════════════════════════════

# ZSH Syntax Highlighting Styles
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=green,underline'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=green'
ZSH_HIGHLIGHT_STYLES[path]='fg=white,underline'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=white,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=white,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=white,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=blue'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[assign]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[comment]='fg=black,bold'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=green,bold'

# Паттерны для подсветки специфичных ошибок
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('sudo rm -rf' 'fg=white,bold,bg=red')

# Функция для подсветки ошибок в выводе команд
highlight_errors() {
  local RED='\033[38;5;203m'
  local YELLOW='\033[1;33m'
  local GREEN='\033[1;32m'
  local BLUE='\033[1;34m'
  local MAGENTA='\033[1;35m'
  local CYAN='\033[1;36m'
  local NC='\033[0m'

  "$@" 2>&1 | sed -E \
    -e "s/(Build failed|build failed)/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/(Critical dependency)/\x1b[1;33m\1\x1b[0m/g" \
    -e "s/(SyntaxError|TypeError|ReferenceError|RangeError|ErrorBoundary)/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/(error|Error|ERROR|failed|Failed|FAILED|fatal|Fatal|FATAL)/${RED}\1${NC}/g" \
    -e "s/(warning|Warning|WARNING|warn|Warn|WARN)/${YELLOW}\1${NC}/g" \
    -e "s/(success|Success|SUCCESS|successful|Successful|done|Done|DONE)/${GREEN}\1${NC}/g" \
    -e "s/(No such file or directory|cannot find|not found|doesn't exist|does not exist)/${RED}\1${NC}/g" \
    -e "s/(permission denied|Permission denied|PERMISSION DENIED|access denied)/${RED}\1${NC}/g" \
    -e "s/(deprecated|Deprecated|DEPRECATED)/${YELLOW}\1${NC}/g" \
    -e "s/(info|Info|INFO|note|Note|NOTE)/${CYAN}\1${NC}/g" \
    -e "s/(\[FAIL\]|\[ERROR\]|\[FATAL\])/${RED}\1${NC}/g" \
    -e "s/(\[WARN\]|\[WARNING\])/${YELLOW}\1${NC}/g" \
    -e "s/(\[OK\]|\[PASS\]|\[SUCCESS\])/${GREEN}\1${NC}/g" \
    -e "s/(\[INFO\]|\[NOTE\])/${CYAN}\1${NC}/g"

  return ${PIPESTATUS[0]}
}

# Функция для красивого вывода ошибок с контекстом
show_error() {
  local RED='\033[38;5;203m'
  local NC='\033[0m'
  echo -e "\n${RED}❌ ОШИБКА:${NC} $1\n"
}

show_warning() {
  local YELLOW='\033[1;33m'
  local NC='\033[0m'
  echo -e "\n${YELLOW}⚠️  ПРЕДУПРЕЖДЕНИЕ:${NC} $1\n"
}

show_success() {
  local GREEN='\033[1;32m'
  local NC='\033[0m'
  echo -e "\n${GREEN}✅ УСПЕХ:${NC} $1\n"
}

show_info() {
  local CYAN='\033[1;36m'
  local NC='\033[0m'
  echo -e "\n${CYAN}ℹ️  ИНФОРМАЦИЯ:${NC} $1\n"
}

# Wrapper для безопасного выполнения команд
run_with_highlight() {
  highlight_errors "$@"
  local exit_code=$?
  if [ $exit_code -ne 0 ]; then
    show_error "Команда завершилась с кодом: $exit_code"
  fi
  return $exit_code
}

# Автоматическое отображение exit кода при ошибках
precmd() {
  local EXIT_CODE=$?
  if [ $EXIT_CODE -ne 0 ]; then
    local RED='\033[38;5;203m'
    local NC='\033[0m'
    echo -e "${RED}✗ Exit code: $EXIT_CODE${NC}"
  fi
}
