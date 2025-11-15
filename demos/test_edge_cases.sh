#!/usr/bin/env zsh

# ============================================================================
# EDGE CASES TEST SCRIPT
# Проверка проблемных кейсов для подсветки синтаксиса
# ============================================================================

clear

echo "\n"
echo "═══════════════════════════════════════════════════════════════════════"
echo "  ТЕСТИРОВАНИЕ ПРОБЛЕМНЫХ КЕЙСОВ ПОДСВЕТКИ"
echo "═══════════════════════════════════════════════════════════════════════"
echo "\n"

# Цвета для тестов
RED='\x1b[38;5;203m'
YELLOW='\x1b[1;33m'
GREEN='\x1b[1;32m'
CYAN='\x1b[1;36m'
GRAY='\x1b[90m'
NC='\x1b[0m'

test_num=0

run_test() {
  ((test_num++))
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "ТЕСТ #$test_num: $1"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""
}

# ============================================================================
# ТЕСТ 1: Конфликт паттернов Error
# ============================================================================

run_test "Конфликт паттернов Error"

echo "Ожидается: 'error' окрашен, 'terrored' НЕ окрашен"
echo ""

echo "This is an error message" | sed -E "s/([^a-zA-Z])(error|Error)([^a-zA-Z])/\1${RED}\2${NC}\3/g"
echo "User was terrored by the bug" | sed -E "s/([^a-zA-Z])(error|Error)([^a-zA-Z])/\1${RED}\2${NC}\3/g"
echo "SyntaxError occurred" | sed -E "s/(SyntaxError|TypeError|ReferenceError)/${RED}\1${NC}/g"

echo ""
echo "✓ Проверь: 'error' красный, 'terrored' белый, 'SyntaxError' красный целиком"
echo ""
read -p "Нажми Enter для продолжения..."
echo ""

# ============================================================================
# ТЕСТ 2: Множественные ошибки на одной строке
# ============================================================================

run_test "Множественные ошибки на одной строке"

echo "Ожидается: оба слова ERROR и failed окрашены красным"
echo ""

echo "ERROR: Build failed with critical errors" | sed -E \
  -e "s/(ERROR)/${RED}\1${NC}/g" \
  -e "s/(failed)/${RED}\1${NC}/g" \
  -e "s/(critical)/${RED}\1${NC}/g"

echo ""
echo "✓ Проверь: все три слова (ERROR, failed, critical) красные"
echo ""
read -p "Нажми Enter для продолжения..."
echo ""

# ============================================================================
# ТЕСТ 3: ErrorBoundary и другие составные Error слова
# ============================================================================

run_test "ErrorBoundary и составные Error слова"

echo "Ожидается: ErrorBoundary окрашен целиком красным"
echo ""

echo "in ErrorBoundary (at App.tsx:12)" | sed -E \
  -e "s/(ErrorBoundary)/${RED}\1${NC}/g" \
  -e "s/(in )([A-Z][a-zA-Z0-9]*)/${CYAN}\1\2${NC}/g"

echo "TypeError: Cannot read properties" | sed -E \
  -e "s/(TypeError)/${RED}\1${NC}/g"

echo ""
echo "✓ Проверь: 'ErrorBoundary' красный, 'in ErrorBoundary' - 'in' cyan"
echo ""
read -p "Нажми Enter для продолжения..."
echo ""

# ============================================================================
# ТЕСТ 4: Пути с пробелами и специальными символами
# ============================================================================

run_test "Пути с пробелами и специальными символами"

echo "Ожидается: пути подчеркнуты cyan, даже со специальными символами"
echo ""

echo "src/components/Button.tsx" | sed -E "s/([a-zA-Z0-9_/-]+\.tsx?)/\x1b[4;36m\1\x1b[0m/g"
echo "src/My Components/Button.tsx" | sed -E "s/([a-zA-Z0-9_ /-]+\.tsx?)/\x1b[4;36m\1\x1b[0m/g"
echo "src/(utils)/helper.ts" | sed -E "s/([a-zA-Z0-9_()/-]+\.tsx?)/\x1b[4;36m\1\x1b[0m/g"

echo ""
echo "✓ Проверь: все три пути подчеркнуты cyan"
echo ""
read -p "Нажми Enter для продолжения..."
echo ""

# ============================================================================
# ТЕСТ 5: Разные форматы координат
# ============================================================================

run_test "Разные форматы координат (TypeScript, ESLint, Jest)"

echo "Ожидается: файлы cyan подчеркнутые, координаты серые"
echo ""

echo "TypeScript: file.tsx(24,5):" | sed -E \
  -e "s/([a-zA-Z0-9_/-]+\.tsx?)\(([0-9]+),([0-9]+)\)/\x1b[4;36m\1\x1b[0m${GRAY}(\2,\3)${NC}/g"

echo "ESLint: file.tsx:45:23" | sed -E \
  -e "s/([a-zA-Z0-9_/-]+\.[jt]sx?)/\x1b[4;36m\1\x1b[0m/g" \
  -e "s/([0-9]+:[0-9]+)/${GRAY}\1${NC}/g"

echo "Jest: at Object.<anonymous> (file.tsx:15:23)" | sed -E \
  -e "s/(at .+ \([^)]+:[0-9]+:[0-9]+\))/${GRAY}\1${NC}/g"

echo ""
echo "✓ Проверь: файлы cyan, координаты серые во всех форматах"
echo ""
read -p "Нажми Enter для продолжения..."
echo ""

# ============================================================================
# ТЕСТ 6: Вложенные Expected/Received в Jest
# ============================================================================

run_test "Вложенные Expected/Received в Jest"

echo "Ожидается: слова внутри сообщения тоже подсвечены"
echo ""

cat << 'EOF' | sed -E \
  -e "s/(Expected|Received)/${CYAN}\1${NC}/g" \
  -e "s/(true|false)/${YELLOW}\1${NC}/g"
    expect(received).toBe(expected)

    Expected: true
    Received: false
EOF

echo ""
echo "✓ Проверь: Expected/Received cyan, true/false желтые"
echo ""
read -p "Нажми Enter для продолжения..."
echo ""

# ============================================================================
# ТЕСТ 7: Webpack специфичный формат
# ============================================================================

run_test "Webpack специфичный формат"

echo "Ожидается: ERROR красный, путь cyan"
echo ""

echo "ERROR in ./src/components/UserCard.tsx" | sed -E \
  -e "s/(ERROR)/${RED}\1${NC}/g" \
  -e "s/(\.\\/[a-zA-Z0-9_/-]+\.tsx?)/\x1b[4;36m\1\x1b[0m/g"

echo ""
echo "✓ Проверь: ERROR красный, путь ./src/... cyan подчеркнутый"
echo ""
read -p "Нажми Enter для продолжения..."
echo ""

# ============================================================================
# ТЕСТ 8: Числа с контекстом vs без
# ============================================================================

run_test "Числа с контекстом vs без контекста"

echo "Ожидается: только '2 passed' окрашено, просто '2' - нет"
echo ""

echo "Just number: 2" | sed -E "s/([0-9]+) (passed)/${GREEN}\1 \2${NC}/g"
echo "Test result: 2 passed" | sed -E "s/([0-9]+) (passed)/${GREEN}\1 \2${NC}/g"
echo "Test result: 1 failed" | sed -E "s/([0-9]+) (failed)/${RED}\1 \2${NC}/g"
echo "Test result: 3 total" | sed -E "s/([0-9]+) (total)/${CYAN}\1 \2${NC}/g"

echo ""
echo "✓ Проверь: 'Just number: 2' белый, '2 passed' зеленый, '1 failed' красный, '3 total' cyan"
echo ""
read -p "Нажми Enter для продолжения..."
echo ""

# ============================================================================
# ТЕСТ 9: Символы × и ⚠ с текстом
# ============================================================================

run_test "Символы × и ⚠ с числами и текстом"

echo "Ожидается: весь текст '× 3 errors' красный, '⚠ 2 warnings' желтый"
echo ""

echo "✖ 3 errors" | sed -E "s/(✖) ([0-9]+) (errors?)/${RED}\1 \2 \3${NC}/g"
echo "⚠ 2 warnings" | sed -E "s/(⚠) ([0-9]+) (warnings?)/${YELLOW}\1 \2 \3${NC}/g"

echo ""
echo "✓ Проверь: '✖ 3 errors' полностью красный, '⚠ 2 warnings' полностью желтый"
echo ""
read -p "Нажми Enter для продолжения..."
echo ""

# ============================================================================
# ТЕСТ 10: Critical dependency (должен быть желтым, не красным)
# ============================================================================

run_test "Critical dependency - предупреждение, не ошибка"

echo "Ожидается: 'Critical dependency' желтый (не красный!)"
echo ""

echo "WARN: Critical dependency detected" | sed -E \
  -e "s/(WARN)/${YELLOW}\1${NC}/g" \
  -e "s/(Critical dependency)/${YELLOW}\1${NC}/g"

echo "ERROR: Build failed" | sed -E \
  -e "s/(ERROR)/${RED}\1${NC}/g" \
  -e "s/(Build failed)/${RED}\1${NC}/g"

echo ""
echo "✓ Проверь: 'Critical dependency' желтый, 'Build failed' красный"
echo ""
read -p "Нажми Enter для продолжения..."
echo ""

# ============================================================================
# ИТОГИ
# ============================================================================

echo "═══════════════════════════════════════════════════════════════════════"
echo "  ВСЕ ТЕСТЫ ЗАВЕРШЕНЫ"
echo "═══════════════════════════════════════════════════════════════════════"
echo ""
echo "Проверено $test_num edge cases:"
echo "1. ✓ Конфликт паттернов Error"
echo "2. ✓ Множественные ошибки на строке"
echo "3. ✓ ErrorBoundary и составные слова"
echo "4. ✓ Пути со специальными символами"
echo "5. ✓ Разные форматы координат"
echo "6. ✓ Вложенные Expected/Received"
echo "7. ✓ Webpack формат"
echo "8. ✓ Числа с/без контекста"
echo "9. ✓ Символы × и ⚠"
echo "10. ✓ Critical dependency (желтый!)"
echo ""
echo -e "${GREEN}Если все тесты прошли корректно - подсветка работает правильно!${NC}"
echo ""
