# ═══════════════════════════════════════════════════════════════
# UNIVERSAL COMMAND WRAPPERS
# Обертки для популярных команд с автоматической подсветкой
# ═══════════════════════════════════════════════════════════════

# NPM wrapper с расширенной подсветкой для React/Next.js/TypeScript
npm() {
  command npm "$@" 2>&1 | sed -E \
    -e "s/(Build failed|build failed)/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/(Critical dependency)/\x1b[1;33m\1\x1b[0m/g" \
    -e "s/(SyntaxError|TypeError|ReferenceError|RangeError|ErrorBoundary)/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/(×|✖) ([0-9]+) (errors?)/\x1b[38;5;203m\1 \2 \3\x1b[0m/g" \
    -e "s/(⚠) ([0-9]+) (warnings?)/\x1b[1;33m\1 \2 \3\x1b[0m/g" \
    -e "s/([0-9]+) (passed)/\x1b[32m\1 \2\x1b[0m/g" \
    -e "s/([0-9]+) (failed)/\x1b[38;5;203m\1 \2\x1b[0m/g" \
    -e "s/([0-9]+) (total)/\x1b[36m\1 \2\x1b[0m/g" \
    -e "s/(in )([A-Z][a-zA-Z0-9]*)/\x1b[36m\1\2\x1b[0m/g" \
    -e "s/(at )(Object\.<anonymous>)/\x1b[90m\1\2\x1b[0m/g" \
    -e "s/([a-zA-Z0-9_/-]+\.[jt]sx?)(\([0-9]+:[0-9]+\))/\x1b[4;36m\1\x1b[0m\x1b[90m\2\x1b[0m/g" \
    -e "s/(error|Error|ERROR)/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/(warn|warning|Warning|WARNING)/\x1b[1;33m\1\x1b[0m/g" \
    -e "s/(success|Success|done|Done)/\x1b[1;32m\1\x1b[0m/g"
  return ${PIPESTATUS[0]}
}

# Yarn wrapper
yarn() {
  command yarn "$@" 2>&1 | sed -E \
    -e "s/(Build failed|build failed)/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/(Critical dependency)/\x1b[1;33m\1\x1b[0m/g" \
    -e "s/(×|✖) ([0-9]+) (errors?)/\x1b[38;5;203m\1 \2 \3\x1b[0m/g" \
    -e "s/(⚠) ([0-9]+) (warnings?)/\x1b[1;33m\1 \2 \3\x1b[0m/g" \
    -e "s/(error|Error|ERROR)/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/(warn|warning|Warning|WARNING)/\x1b[1;33m\1\x1b[0m/g" \
    -e "s/(success|Success|done|Done)/\x1b[1;32m\1\x1b[0m/g"
  return ${PIPESTATUS[0]}
}

# Jest wrapper с детальной подсветкой результатов
jest() {
  command jest "$@" 2>&1 | sed -E \
    -e "s/(PASS)/\x1b[1;32m✓ PASS\x1b[0m/g" \
    -e "s/(FAIL)/\x1b[38;5;203m✗ FAIL\x1b[0m/g" \
    -e "s/(Test Suites: )([0-9]+) (passed)/\1\x1b[1;32m\2 \3\x1b[0m/g" \
    -e "s/(Test Suites: )([0-9]+) (failed)/\1\x1b[38;5;203m\2 \3\x1b[0m/g" \
    -e "s/([0-9]+) (passed)/\x1b[1;32m\1 \2\x1b[0m/g" \
    -e "s/([0-9]+) (failed)/\x1b[38;5;203m\1 \2\x1b[0m/g" \
    -e "s/([0-9]+) (total)/\x1b[36m\1 \2\x1b[0m/g" \
    -e "s/(Expected|Received):/\x1b[1;36m\1:\x1b[0m/g" \
    -e "s/(expect\(received\)\.toBe\(expected\))/\x1b[90m\1\x1b[0m/g" \
    -e "s/(true|false)/\x1b[1;33m\1\x1b[0m/g" \
    -e "s/([a-zA-Z0-9_/-]+\.[jt]sx?):([0-9]+):([0-9]+)/\x1b[4;36m\1\x1b[0m:\x1b[90m\2:\3\x1b[0m/g"
  return ${PIPESTATUS[0]}
}

# TypeScript compiler wrapper
tsc() {
  command tsc "$@" 2>&1 | sed -E \
    -e "s/([a-zA-Z0-9_/-]+\.[jt]sx?)\(([0-9]+),([0-9]+)\)/\x1b[4;36m\1\x1b[0m\x1b[90m(\2,\3)\x1b[0m/g" \
    -e "s/(error TS[0-9]+)/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/(warning TS[0-9]+)/\x1b[1;33m\1\x1b[0m/g"
  return ${PIPESTATUS[0]}
}

# ESLint wrapper
eslint() {
  command eslint "$@" 2>&1 | highlight_eslint
  return ${PIPESTATUS[0]}
}

highlight_eslint() {
  sed -E \
    -e "s/(error)/\x1b[38;5;203m\1\x1b[0m/g" \
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
    -e "s/(Ready|Compiling|Compiled)/\x1b[1;32m\1\x1b[0m/g" \
    -e "s/(Failed to compile)/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/(webpack compiled)/\x1b[1;32m\1\x1b[0m/g" \
    -e "s/([a-zA-Z0-9_/-]+\.[jt]sx?)/\x1b[4;36m\1\x1b[0m/g"
}

# Python3 wrapper
python3() {
  command python3 "$@" 2>&1 | sed -E \
    -e "s/(Error|ERROR|Exception)/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/(Warning|WARNING)/\x1b[1;33m\1\x1b[0m/g" \
    -e "s/(Traceback \(most recent call last\))/\x1b[90m\1\x1b[0m/g" \
    -e "s/(File )\"([^\"]+)\"(, line )([0-9]+)/\1\x1b[4;36m\"\2\"\x1b[0m\3\x1b[90m\4\x1b[0m/g"
  return ${PIPESTATUS[0]}
}

# Docker wrapper
docker() {
  command docker "$@" 2>&1 | sed -E \
    -e "s/(Error|ERROR)/\x1b[38;5;203m\1\x1b[0m/g" \
    -e "s/(Warning|WARNING)/\x1b[1;33m\1\x1b[0m/g" \
    -e "s/(Successfully|Success|done)/\x1b[1;32m\1\x1b[0m/g"
  return ${PIPESTATUS[0]}
}

# Find wrapper с подсветкой путей
find() {
  command find "$@" | sed -E \
    -e "s|([a-zA-Z0-9_/.@-]+)|\x1b[4;36m\1\x1b[0m|g"
}
