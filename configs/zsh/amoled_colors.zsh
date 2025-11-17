# ============================================================================
# AMOLED-OPTIMIZED ZSH SYNTAX HIGHLIGHTING
# Яркие контрастные цвета для чистого черного фона (#000000)
# ============================================================================

# Активируем все highlighters
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# ============================================================================
# ОСНОВНЫЕ ЦВЕТА ДЛЯ ZSH-SYNTAX-HIGHLIGHTING (AMOLED)
# ============================================================================

typeset -A ZSH_HIGHLIGHT_STYLES

# Команды и функции - ЯРКИЙ CYAN/BLUE
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#FF4444,bold'          # Красный
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#FFD700,bold'          # Золотой
ZSH_HIGHLIGHT_STYLES[alias]='fg=#00E5FF,bold'                  # Яркий cyan
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#00E5FF,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#00E5FF,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=#00E5FF,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=#00FF00,bold'                # Яркий зеленый
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#00FF00,bold,underline'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#FFD700'            # Золотой
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#00FF00,bold'

# Пути - ЯРКИЙ БЕЛЫЙ/MAGENTA
ZSH_HIGHLIGHT_STYLES[path]='fg=#FFFFFF,underline'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=#FFFFFF,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#CCCCCC,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=#CCCCCC,underline'

# Специальные символы - ЯРКИЙ MAGENTA
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#FF00FF,bold'               # Яркий magenta
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#1E90FF,bold'      # Додger синий

# Опции и параметры - ЯРКИЙ ЖЕЛТЫЙ
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#FFFF00'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#FFFF00'

# Строки - ЯРКИЙ ЗЕЛЕНЫЙ/ЖЕЛТЫЙ
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#1E90FF'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#ADFF2F'     # Зелено-желтый
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#ADFF2F'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#ADFF2F'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#00E5FF'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#00E5FF'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#00E5FF'

# Присваивания и редиректы - ЯРКИЙ MAGENTA
ZSH_HIGHLIGHT_STYLES[assign]='fg=#FF00FF,bold'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#FF00FF,bold'

# Комментарии - СЕРЫЙ (приглушенный)
ZSH_HIGHLIGHT_STYLES[comment]='fg=#808080,bold'

# Первый аргумент (команда)
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#00FF00,bold'

# ============================================================================
# ПАТТЕРНЫ ДЛЯ ОПАСНЫХ КОМАНД (ЯРКИЙ КРАСНЫЙ ФОН)
# ============================================================================

ZSH_HIGHLIGHT_PATTERNS=(
  'rm -rf *' 'fg=#FFFFFF,bold,bg=#8B0000'
  'sudo rm -rf' 'fg=#FFFFFF,bold,bg=#8B0000'
  'rm -rf /' 'fg=#FFFFFF,bold,bg=#8B0000'
  'mkfs' 'fg=#FFFFFF,bold,bg=#8B0000'
  'dd if=' 'fg=#FFFF00,bold,bg=#8B0000'
)

# ============================================================================
# НАСТРОЙКИ ДЛЯ ZSH-AUTOSUGGESTIONS (AMOLED)
# ============================================================================

# Цвет для автоподсказок - темно-серый (видимый на черном)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#505050'

# Клавиши для принятия подсказок
bindkey '^ ' autosuggest-accept              # Ctrl+Space
bindkey '^[[1;5C' forward-word               # Ctrl+Right
bindkey '^[[1;5D' backward-word              # Ctrl+Left

# ============================================================================
# ЦВЕТА ДЛЯ LS/EZA (AMOLED)
# ============================================================================

# AMOLED-оптимизированные цвета для ls
export LS_COLORS="di=1;96:ln=1;95:so=1;92:pi=1;93:ex=1;91:bd=1;94:cd=1;94:su=0;41:sg=0;46:tw=0;42:ow=0;43:*.tar=1;31:*.zip=1;31:*.gz=1;31"

# Если используется eza
if command -v eza &>/dev/null; then
  export EZA_COLORS="di=1;96:ln=1;95:so=1;92:pi=1;93:ex=1;91:bd=1;94:cd=1;94"
fi

# ============================================================================
# ЦВЕТОВЫЕ КОДЫ ДЛЯ ИСПОЛЬЗОВАНИЯ В ФУНКЦИЯХ
# ============================================================================

# Яркие AMOLED цвета для вывода
export AMOLED_RED='\033[38;5;203m'          # Яркий красный #FF5555
export AMOLED_GREEN='\033[38;5;46m'         # Яркий зеленый #00FF00
export AMOLED_YELLOW='\033[38;5;226m'       # Яркий желтый #FFFF00
export AMOLED_BLUE='\033[38;5;39m'          # Яркий синий #00AFFF
export AMOLED_MAGENTA='\033[38;5;201m'      # Яркий magenta #FF00FF
export AMOLED_CYAN='\033[38;5;51m'          # Яркий cyan #00FFFF
export AMOLED_WHITE='\033[38;5;231m'        # Чистый белый #FFFFFF
export AMOLED_GRAY='\033[38;5;244m'         # Серый #808080
export AMOLED_NC='\033[0m'                  # Сброс цвета

# ============================================================================
# ОБНОВЛЕННЫЕ ФУНКЦИИ С AMOLED ЦВЕТАМИ
# ============================================================================

# Замена highlight_errors на AMOLED версию
highlight_errors_amoled() {
  "$@" 2>&1 | sed -E \
    -e "s/(Build failed|build failed)/${AMOLED_RED}\1${AMOLED_NC}/g" \
    -e "s/(Critical dependency)/${AMOLED_YELLOW}\1${AMOLED_NC}/g" \
    -e "s/(SyntaxError|TypeError|ReferenceError|RangeError|ErrorBoundary)/${AMOLED_RED}\1${AMOLED_NC}/g" \
    -e "s/(error|Error|ERROR|failed|Failed|FAILED|fatal|Fatal|FATAL)/${AMOLED_RED}\1${AMOLED_NC}/g" \
    -e "s/(warning|Warning|WARNING|warn|Warn|WARN)/${AMOLED_YELLOW}\1${AMOLED_NC}/g" \
    -e "s/(success|Success|SUCCESS|successful|Successful|done|Done|DONE)/${AMOLED_GREEN}\1${AMOLED_NC}/g" \
    -e "s/(No such file or directory|cannot find|not found|doesn't exist|does not exist)/${AMOLED_RED}\1${AMOLED_NC}/g" \
    -e "s/(permission denied|Permission denied|PERMISSION DENIED|access denied)/${AMOLED_RED}\1${AMOLED_NC}/g" \
    -e "s/(deprecated|Deprecated|DEPRECATED)/${AMOLED_YELLOW}\1${AMOLED_NC}/g" \
    -e "s/(info|Info|INFO|note|Note|NOTE)/${AMOLED_CYAN}\1${AMOLED_NC}/g" \
    -e "s/(\[FAIL\]|\[ERROR\]|\[FATAL\])/${AMOLED_RED}\1${AMOLED_NC}/g" \
    -e "s/(\[WARN\]|\[WARNING\])/${AMOLED_YELLOW}\1${AMOLED_NC}/g" \
    -e "s/(\[OK\]|\[PASS\]|\[SUCCESS\])/${AMOLED_GREEN}\1${AMOLED_NC}/g" \
    -e "s/(\[INFO\]|\[NOTE\])/${AMOLED_CYAN}\1${AMOLED_NC}/g"

  return ${PIPESTATUS[0]}
}

# ============================================================================
# NPM/YARN ОБЕРТКИ С AMOLED ПОДСВЕТКОЙ
# ============================================================================

# NPM wrapper с AMOLED цветами
npm_amoled() {
  command npm "$@" 2>&1 | sed -E \
    -e "s/(Build failed|build failed)/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/(SyntaxError|TypeError|ReferenceError|RangeError|ErrorBoundary)/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/(ERR!|ERROR)/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/([^a-zA-Z])(error|Error)([^a-zA-Z])/\1\x1b[38;5;203m\2\x1b[0m\3/g" \
    -e "s/(Critical dependency)/\x1b[38;5;226m\1\x1b[0m/g" \
    -e "s/(WARN|warn|Warning|WARNING)/\x1b[38;5;226m\1\x1b[0m/g" \
    -e "s/(success|Success|SUCCESS)/\x1b[38;5;46m\1\x1b[0m/g" \
    -e "s/(PASS|✓|✔)/\x1b[38;5;46m\1\x1b[0m/g" \
    -e "s/(FAIL|✗|✖)/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/(×) ([0-9]+) (errors?)/\x1b[38;5;203m\1 \2 \3\x1b[0m/g" \
    -e "s/(⚠) ([0-9]+) (warnings?)/\x1b[38;5;226m\1 \2 \3\x1b[0m/g" \
    -e "s/(Test Suites:|Tests:)/\x1b[38;5;51m\1\x1b[0m/g" \
    -e "s/([0-9]+) (passed)/\x1b[38;5;46m\1 \2\x1b[0m/g" \
    -e "s/([0-9]+) (failed)/\x1b[38;5;203m\1 \2\x1b[0m/g" \
    -e "s/([0-9]+) (skipped)/\x1b[38;5;244m\1 \2\x1b[0m/g" \
    -e "s/([0-9]+) (total)/\x1b[38;5;51m\1 \2\x1b[0m/g" \
    -e "s/(at .+ \([^)]+:[0-9]+:[0-9]+\))/\x1b[38;5;244m\1\x1b[0m/g" \
    -e "s/(TS[0-9]+:)/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/(Module not found|Cannot find module)/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/(Hydration failed|Hydration mismatch)/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/(Warning: |React Warning:)/\x1b[38;5;226m\1\x1b[0m/g" \
    -e "s/(\([0-9]+ms\))/\x1b[38;5;244m\1\x1b[0m/g" \
    -e "s/(in )([A-Z][a-zA-Z0-9]*)/\x1b[38;5;51m\1\2\x1b[0m/g"
  return ${PIPESTATUS[0]}
}

# JEST wrapper с AMOLED цветами
jest_amoled() {
  command jest "$@" 2>&1 | sed -E \
    -e "s/(PASS)/\x1b[38;5;46m✓ PASS\x1b[0m/g" \
    -e "s/(FAIL)/\x1b[38;5;203m✗ FAIL\x1b[0m/g" \
    -e "s/(● )(.*)/\x1b[38;5;203m●\x1b[0m \x1b[38;5;203m\2\x1b[0m/g" \
    -e "s/(Test Suites: )([0-9]+) (passed)/\1\x1b[38;5;46m\2 \3\x1b[0m/g" \
    -e "s/(Test Suites: )([0-9]+) (failed)/\1\x1b[38;5;203m\2 \3\x1b[0m/g" \
    -e "s/(Tests:       )([0-9]+) (passed)/\1\x1b[38;5;46m\2 \3\x1b[0m/g" \
    -e "s/(Tests:       )([0-9]+) (failed)/\1\x1b[38;5;203m\2 \3\x1b[0m/g" \
    -e "s/([0-9]+) (total)/\x1b[38;5;51m\1 \2\x1b[0m/g" \
    -e "s/(Snapshots:   )([0-9]+)/\1\x1b[38;5;51m\2\x1b[0m/g" \
    -e "s/(Time:        )([0-9.]+s)/\1\x1b[38;5;244m\2\x1b[0m/g" \
    -e "s/(Ran all test suites)/\x1b[38;5;46m\1\x1b[0m/g" \
    -e "s/(  at .*)/\x1b[38;5;244m\1\x1b[0m/g"
  return ${PIPESTATUS[0]}
}

# ============================================================================
# АЛИАСЫ ДЛЯ АКТИВАЦИИ AMOLED ОБЁРТОК
# ============================================================================

alias npm='npm_amoled'
alias yarn='npm_amoled'  # yarn тоже через npm обертку
alias jest='jest_amoled'

# ============================================================================
# ИНФОРМАЦИЯ
# ============================================================================

echo -e "${AMOLED_CYAN}✓ AMOLED цвета загружены${AMOLED_NC}"
echo -e "${AMOLED_GRAY}  Яркие контрастные цвета для черного фона${AMOLED_NC}"
