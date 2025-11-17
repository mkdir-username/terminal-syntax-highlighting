# ═══════════════════════════════════════════════════════════════
# UNIVERSAL COMMAND WRAPPERS
# Обертки для популярных команд с автоматической подсветкой
# Использует word boundaries [[:<:]] [[:>:]] для предотвращения ложных срабатываний
# ═══════════════════════════════════════════════════════════════

# Удаляем существующие aliases/functions перед определением
unalias npm 2>/dev/null || true
unfunction npm 2>/dev/null || true
unalias yarn 2>/dev/null || true
unfunction yarn 2>/dev/null || true
unalias jest 2>/dev/null || true
unfunction jest 2>/dev/null || true
unalias tsc 2>/dev/null || true
unfunction tsc 2>/dev/null || true
unalias eslint 2>/dev/null || true
unfunction eslint 2>/dev/null || true
unalias next 2>/dev/null || true
unfunction next 2>/dev/null || true
unalias python3 2>/dev/null || true
unfunction python3 2>/dev/null || true
unalias docker 2>/dev/null || true
unfunction docker 2>/dev/null || true
unalias find 2>/dev/null || true
unfunction find 2>/dev/null || true

# NPM wrapper с расширенной подсветкой для React/Next.js/TypeScript
npm() {
  command npm "$@" 2>&1 | sed -E \
    -e "s/(Build failed|build failed)/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/(Critical dependency)/\x1b[1;33m\1\x1b[0m/g" \
    -e "s/(SyntaxError|TypeError|ReferenceError|RangeError|ErrorBoundary)/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/(×|✖) ([0-9]+) (errors?)/\x1b[38;5;203m\1 \2 \3\x1b[0m/g" \
    -e "s/(⚠) ([0-9]+) (warnings?)/\x1b[1;33m\1 \2 \3\x1b[0m/g" \
    -e "s/([0-9]+) [[:<:]](passed)[[:>:]]/\x1b[32m\1 \2\x1b[0m/g" \
    -e "s/([0-9]+) [[:<:]](failed)[[:>:]]/\x1b[38;5;203m\1 \2\x1b[0m/g" \
    -e "s/([0-9]+) (total)/\x1b[36m\1 \2\x1b[0m/g" \
    -e "s/(in )([A-Z][a-zA-Z0-9]*)/\x1b[36m\1\2\x1b[0m/g" \
    -e "s/(at )(Object\.<anonymous>)/\x1b[90m\1\2\x1b[0m/g" \
    -e "s/([a-zA-Z0-9_/-]+\.[jt]sx?)(\([0-9]+:[0-9]+\))/\x1b[4;36m\1\x1b[0m\x1b[90m\2\x1b[0m/g" \
    -e "s/[[:<:]](error|errors|err|fail|failed|failure|failing|fails|fatal|critical|exception|[A-Z][a-zA-Z]*Error|[A-Z][a-zA-Z]*Exception)[[:>:]]/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/[[:<:]](warn|warning|warnings|warned|warns|caution|deprecat|deprecated|deprecation|[A-Z][a-zA-Z]*Warning)[[:>:]]/\x1b[1;33m\1\x1b[0m/g" \
    -e "s/[[:<:]](success|successes|successful|successfully|succeed|succeeded|succeeding|succeeds|done)[[:>:]]/\x1b[1;32m\1\x1b[0m/g"
  return ${PIPESTATUS[0]}
}

# Yarn wrapper
yarn() {
  command yarn "$@" 2>&1 | sed -E \
    -e "s/(Build failed|build failed)/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/(Critical dependency)/\x1b[1;33m\1\x1b[0m/g" \
    -e "s/(×|✖) ([0-9]+) (errors?)/\x1b[38;5;203m\1 \2 \3\x1b[0m/g" \
    -e "s/(⚠) ([0-9]+) (warnings?)/\x1b[1;33m\1 \2 \3\x1b[0m/g" \
    -e "s/[[:<:]](error|errors|err|fail|failed|failure|failing|fails|fatal|critical|exception|[A-Z][a-zA-Z]*Error)[[:>:]]/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/[[:<:]](warn|warning|warnings|warned|warns|caution|deprecat|deprecated|deprecation|[A-Z][a-zA-Z]*Warning)[[:>:]]/\x1b[1;33m\1\x1b[0m/g" \
    -e "s/[[:<:]](success|successes|successful|successfully|succeed|succeeded|done)[[:>:]]/\x1b[1;32m\1\x1b[0m/g"
  return ${PIPESTATUS[0]}
}

# Jest wrapper с детальной подсветкой результатов
jest() {
  command jest "$@" 2>&1 | sed -E \
    -e "s/[[:<:]](PASS)[[:>:]]/\x1b[1;32m✓ PASS\x1b[0m/g" \
    -e "s/[[:<:]](FAIL)[[:>:]]/\x1b[38;5;203m✗ FAIL\x1b[0m/g" \
    -e "s/(Test Suites: )([0-9]+) [[:<:]](passed)[[:>:]]/\1\x1b[1;32m\2 \3\x1b[0m/g" \
    -e "s/(Test Suites: )([0-9]+) [[:<:]](failed)[[:>:]]/\1\x1b[38;5;203m\2 \3\x1b[0m/g" \
    -e "s/([0-9]+) [[:<:]](passed)[[:>:]]/\x1b[1;32m\1 \2\x1b[0m/g" \
    -e "s/([0-9]+) [[:<:]](failed)[[:>:]]/\x1b[38;5;203m\1 \2\x1b[0m/g" \
    -e "s/([0-9]+) (total)/\x1b[36m\1 \2\x1b[0m/g" \
    -e "s/(Expected|Received):/\x1b[1;36m\1:\x1b[0m/g" \
    -e "s/(expect\(received\)\.toBe\(expected\))/\x1b[90m\1\x1b[0m/g" \
    -e "s/[[:<:]](true|false)[[:>:]]/\x1b[1;33m\1\x1b[0m/g" \
    -e "s/([a-zA-Z0-9_/-]+\.[jt]sx?):([0-9]+):([0-9]+)/\x1b[4;36m\1\x1b[0m:\x1b[90m\2:\3\x1b[0m/g"
  return ${PIPESTATUS[0]}
}

# TypeScript compiler wrapper
tsc() {
  command tsc "$@" 2>&1 | sed -E \
    -e "s/([a-zA-Z0-9_/-]+\.[jt]sx?)\(([0-9]+),([0-9]+)\)/\x1b[4;36m\1\x1b[0m\x1b[90m(\2,\3)\x1b[0m/g" \
    -e "s/[[:<:]](error TS[0-9]+)[[:>:]]/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/[[:<:]](warning TS[0-9]+)[[:>:]]/\x1b[1;33m\1\x1b[0m/g"
  return ${PIPESTATUS[0]}
}

# ESLint wrapper
eslint() {
  command eslint "$@" 2>&1 | highlight_eslint
  return ${PIPESTATUS[0]}
}

highlight_eslint() {
  sed -E \
    -e "s/[[:<:]](error)[[:>:]]/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/[[:<:]](warning)[[:>:]]/\x1b[1;33m\1\x1b[0m/g" \
    -e "s/(✖) ([0-9]+) (errors?)/\x1b[38;5;203m\1 \2 \3\x1b[0m/g" \
    -e "s/(⚠) ([0-9]+) (warnings?)/\x1b[1;33m\1 \2 \3\x1b[0m/g" \
    -e "s/([0-9]+:[0-9]+)/\x1b[90m\1\x1b[0m/g" \
    -e "s/([a-zA-Z0-9_/-]+\.[jt]sx?)/\x1b[4;36m\1\x1b[0m/g"
}

# Next.js dev server wrapper
next() {
  command next "$@" 2>&1 | highlight_react_errors
  return ${PIPESTATUS[0]}
}

highlight_react_errors() {
  sed -E \
    -e "s/(SyntaxError|TypeError|ReferenceError|ErrorBoundary)/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/(in )([A-Z][a-zA-Z0-9]*)/\x1b[36m\1\2\x1b[0m/g" \
    -e "s/(at )(Object\.<anonymous>|Function\.)/\x1b[90m\1\2\x1b[0m/g" \
    -e "s/[[:<:]](Ready|Compiling|Compiled)[[:>:]]/\x1b[1;32m\1\x1b[0m/g" \
    -e "s/(Failed to compile)/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/(webpack compiled)/\x1b[1;32m\1\x1b[0m/g" \
    -e "s/([a-zA-Z0-9_/-]+\.[jt]sx?)/\x1b[4;36m\1\x1b[0m/g"
}

# Python3 wrapper
python3() {
  command python3 "$@" 2>&1 | sed -E \
    -e "s/[[:<:]]([A-Z][a-zA-Z]*Error|[A-Z][a-zA-Z]*Exception)[[:>:]]/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/[[:<:]]([A-Z][a-zA-Z]*Warning)[[:>:]]/\x1b[1;33m\1\x1b[0m/g" \
    -e "s/(Traceback \(most recent call last\))/\x1b[90m\1\x1b[0m/g" \
    -e "s/(File )\"([^\"]+)\"(, line )([0-9]+)/\1\x1b[4;36m\"\2\"\x1b[0m\3\x1b[90m\4\x1b[0m/g"
  return ${PIPESTATUS[0]}
}

# Docker wrapper
docker() {
  command docker "$@" 2>&1 | sed -E \
    -e "s/[[:<:]](error|Error|ERROR|fail|failed|failure)[[:>:]]/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/[[:<:]](warn|warning|Warning|WARNING)[[:>:]]/\x1b[1;33m\1\x1b[0m/g" \
    -e "s/[[:<:]](successfully|Successfully|success|Success|done)[[:>:]]/\x1b[1;32m\1\x1b[0m/g"
  return ${PIPESTATUS[0]}
}

# Find wrapper с подсветкой путей
find() {
  command find "$@" | sed -E \
    -e "s|([a-zA-Z0-9_/.@-]+)|\x1b[4;36m\1\x1b[0m|g"
}