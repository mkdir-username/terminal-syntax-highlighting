#!/usr/bin/env zsh

# ============================================================================
# JS/TS SYNTAX HIGHLIGHTING DEMO V2
# Улучшенная демонстрация с живыми примерами цветов
# ============================================================================

clear

echo "\n"
echo "═══════════════════════════════════════════════════════════════════════"
echo "  ДЕМОНСТРАЦИЯ ПОДСВЕТКИ ДЛЯ JS/TS РАЗРАБОТКИ V2"
echo "═══════════════════════════════════════════════════════════════════════"
echo "\n"

# Функция для паузы
pause() {
  echo "\n\033[90mНажми Enter для продолжения...\033[0m"
  read
}

# ============================================================================
# 0. ЦВЕТОВАЯ ПАЛИТРА (НОВАЯ СЕКЦИЯ)
# ============================================================================

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "0. ЦВЕТОВАЯ ПАЛИТРА"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "\n"

echo "Все цвета используемые в подсветке синтаксиса:"
echo ""
echo -e "\x1b[38;5;203m████████\x1b[0m  Ярко-красный (#f38ba8 / ANSI 203)"
echo "           Использование: Ошибки, FAIL, ✗, Build failed, SyntaxError, TypeError"
echo ""
echo -e "\x1b[1;33m████████\x1b[0m  Желтый (ANSI 33 bold)"
echo "           Использование: Предупреждения, WARNING, WARN, ⚠"
echo ""
echo -e "\x1b[1;32m████████\x1b[0m  Зеленый (ANSI 32 bold)"
echo "           Использование: Успех, PASS, ✓, SUCCESS, Compiled"
echo ""
echo -e "\x1b[1;36m████████\x1b[0m  Cyan (ANSI 36 bold)"
echo "           Использование: Заголовки, компоненты React, Test Suites:"
echo ""
echo -e "\x1b[4;36m████████\x1b[0m  Cyan подчеркнутый (ANSI 36 underline)"
echo "           Использование: Файлы (.tsx, .ts), пути, URLs (http://...)"
echo ""
echo -e "\x1b[90m████████\x1b[0m  Серый (ANSI 90)"
echo "           Использование: Stack traces, координаты (45:12), время (123ms)"
echo ""

pause

# ============================================================================
# 1. JEST TESTS OUTPUT
# ============================================================================

echo "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "1. JEST ТЕСТЫ"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "\n"

cat << 'EOF' | sed -E \
  -e "s/(PASS)/\x1b[1;32m✓ PASS\x1b[0m/g" \
  -e "s/(FAIL)/\x1b[38;5;203m✗ FAIL\x1b[0m/g" \
  -e "s/(● )(.*)/\x1b[38;5;203m●\x1b[0m \x1b[38;5;203m\2\x1b[0m/g" \
  -e "s/(Test Suites: )([0-9]+) (passed)/\1\x1b[1;32m\2 \3\x1b[0m/g" \
  -e "s/(Test Suites: )([0-9]+) (failed)/\1\x1b[38;5;203m\2 \3\x1b[0m/g" \
  -e "s/(Tests:       )([0-9]+) (passed)/\1\x1b[32m\2 \3\x1b[0m/g" \
  -e "s/(Tests:       )([0-9]+) (failed)/\1\x1b[38;5;203m\2 \3\x1b[0m/g" \
  -e "s/([0-9]+) (total)/\x1b[36m\1 \2\x1b[0m/g" \
  -e "s/(Snapshots:   )([0-9]+)/\1\x1b[36m\2\x1b[0m/g" \
  -e "s/(Time:        )([0-9.]+s)/\1\x1b[90m\2\x1b[0m/g" \
  -e "s/(  at .*)/\x1b[90m\1\x1b[0m/g"
 PASS  src/components/Button.test.tsx
 PASS  src/components/Header.test.tsx
 FAIL  src/utils/validation.test.ts
  ● validation › should validate email

    expect(received).toBe(expected)

    Expected: true
    Received: false

      at Object.<anonymous> (src/utils/validation.test.ts:15:23)
      at processTicksAndRejections (node:internal/process/task_queues:95:5)

Test Suites: 2 passed, 1 failed, 3 total
Tests:       15 passed, 1 failed, 16 total
Snapshots:   5 passed, 5 total
Time:        4.521s
EOF

pause

# ============================================================================
# 2. TYPESCRIPT ERRORS
# ============================================================================

echo "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "2. TYPESCRIPT КОМПИЛЯЦИЯ"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "\n"

cat << 'EOF' | sed -E \
  -e "s/(error TS[0-9]+:)/\x1b[38;5;203m\1\x1b[0m/g" \
  -e "s/(TS[0-9]+:)/\x1b[38;5;203m\1\x1b[0m/g" \
  -e "s/(Type '[^']+' is not assignable to type '[^']+')/\x1b[38;5;203m\1\x1b[0m/g" \
  -e "s/(Cannot find name '[^']+')/\x1b[38;5;203m\1\x1b[0m/g" \
  -e "s/(Property '[^']+' does not exist)/\x1b[38;5;203m\1\x1b[0m/g" \
  -e "s/([a-zA-Z0-9_/-]+\.tsx?)\(([0-9]+),([0-9]+)\)/\x1b[4;36m\1\x1b[0m\x1b[90m(\2,\3)\x1b[0m/g"
src/components/UserCard.tsx(24,5): error TS2322: Type 'string' is not assignable to type 'number'.
src/utils/api.ts(45,12): error TS2304: Cannot find name 'ProcessEnv'.
src/hooks/useAuth.tsx(67,23): error TS2339: Property 'userData' does not exist on type 'AuthState'.
EOF

pause

# ============================================================================
# 3. ESLINT OUTPUT
# ============================================================================

echo "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "3. ESLINT ПРОВЕРКА"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "\n"

cat << 'EOF' | sed -E \
  -e "s/(error)/\x1b[38;5;203m\1\x1b[0m/g" \
  -e "s/(warning)/\x1b[1;33m\1\x1b[0m/g" \
  -e "s/([a-zA-Z0-9_/-]+\.[jt]sx?)/\x1b[4;36m\1\x1b[0m/g" \
  -e "s/([0-9]+:[0-9]+)/\x1b[90m\1\x1b[0m/g" \
  -e "s/(✖) ([0-9]+) (errors?)/\x1b[38;5;203m\1 \2 \3\x1b[0m/g" \
  -e "s/(⚠) ([0-9]+) (warnings?)/\x1b[1;33m\1 \2 \3\x1b[0m/g"
src/components/Button.tsx
  12:8   error    'React' must be in scope when using JSX        react/react-in-jsx-scope
  24:15  warning  Unexpected console statement                   no-console
  45:23  error    'onClick' is missing in props validation       react/prop-types

src/utils/helpers.ts
  8:12   warning  Prefer using ?? over ||                        @typescript-eslint/prefer-nullish-coalescing
  67:5   error    Prefer using template literals over string concatenation

✖ 3 errors
⚠ 2 warnings
EOF

pause

# ============================================================================
# 4. NEXT.JS DEV SERVER
# ============================================================================

echo "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "4. NEXT.JS DEV SERVER"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "\n"

cat << 'EOF' | sed -E \
  -e "s/(Ready in [0-9.]+s)/\x1b[1;32m\1\x1b[0m/g" \
  -e "s/(Compiled)/\x1b[1;32m\1\x1b[0m/g" \
  -e "s/(http:\/\/[^ ]+)/\x1b[4;36m\1\x1b[0m/g" \
  -e "s/(○)/\x1b[36m\1\x1b[0m/g"
  ▲ Next.js 14.0.3
  - Local:        http://localhost:3000
  - Network:      http://192.168.1.100:3000

 ✓ Ready in 2.3s
 ○ Compiling / ...
 ✓ Compiled / in 456ms (238 modules)
 ○ Compiling /api/users ...
 ✓ Compiled /api/users in 123ms
EOF

pause

# ============================================================================
# 5. REACT HYDRATION ERRORS
# ============================================================================

echo "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "5. REACT ОШИБКИ (HYDRATION)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "\n"

cat << 'EOF' | sed -E \
  -e "s/(Error: Hydration failed)/\x1b[38;5;203m\1\x1b[0m/g" \
  -e "s/(Warning: Text content did not match)/\x1b[1;33m\1\x1b[0m/g" \
  -e "s/(Warning: Each child in a list should have)/\x1b[1;33m\1\x1b[0m/g" \
  -e "s/(in )([A-Z][a-zA-Z0-9]*)/\x1b[36m\1\2\x1b[0m/g" \
  -e "s/(at )([^ ]+)/\x1b[90m\1\2\x1b[0m/g"
Error: Hydration failed because the initial UI does not match what was rendered on the server.

Warning: Text content did not match. Server: "2024-01-15" Client: "2024-01-16"
  at span
  in ServerTime (at Dashboard.tsx:45)
  in Dashboard (at page.tsx:12)

Warning: Each child in a list should have a unique "key" prop.
  in UserList (at Users.tsx:23)
  in Users

The above error occurred in the <Dashboard> component
EOF

pause

# ============================================================================
# 6. NPM BUILD WITH ERRORS
# ============================================================================

echo "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "6. NPM BUILD С ОШИБКАМИ"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "\n"

cat << 'EOF' | sed -E \
  -e "s/(Build failed)/\x1b[38;5;203m\1\x1b[0m/g" \
  -e "s/(Critical dependency)/\x1b[1;33m\1\x1b[0m/g" \
  -e "s/(ERROR|ERR!)/\x1b[38;5;203m\1\x1b[0m/g" \
  -e "s/(SyntaxError|TypeError)/\x1b[38;5;203m\1\x1b[0m/g" \
  -e "s/(Module not found)/\x1b[38;5;203m\1\x1b[0m/g" \
  -e "s/([^a-zA-Z])(Error)([^a-zA-Z])/\1\x1b[38;5;203m\2\x1b[0m\3/g" \
  -e "s/(WARN)/\x1b[1;33m\1\x1b[0m/g" \
  -e "s/(  at .*)/\x1b[90m\1\x1b[0m/g" \
  -e "s/(\([0-9]+ms\))/\x1b[90m\1\x1b[0m/g"
> npm run build

Building application...

ERROR in ./src/components/UserCard.tsx
Module not found: Error: Can't resolve '@/utils/formatDate'
  at resolve (node_modules/webpack/lib/Compilation.js:2021:12)
  at getResolve (node_modules/webpack/lib/Compilation.js:1945:15)

ERROR in ./src/pages/dashboard.tsx
SyntaxError: Unexpected token (45:12)
  at parseComponent (node_modules/@babel/parser/lib/index.js:234:19)
  at transform (node_modules/babel-loader/lib/index.js:89:23)

WARN ./src/hooks/useData.ts
  Critical dependency: require function is used in a way in which dependencies cannot be statically extracted

Build failed (4523ms)
EOF

pause

# ============================================================================
# 7. YARN TEST (MIXED RESULTS)
# ============================================================================

echo "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "7. YARN TEST (СМЕШАННЫЕ РЕЗУЛЬТАТЫ)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "\n"

cat << 'EOF' | sed -E \
  -e "s/(PASS)/\x1b[1;32m\1\x1b[0m/g" \
  -e "s/(FAIL)/\x1b[38;5;203m\1\x1b[0m/g" \
  -e "s/(✓)/\x1b[1;32m\1\x1b[0m/g" \
  -e "s/(✗)/\x1b[38;5;203m\1\x1b[0m/g" \
  -e "s/(Test Suites:)/\x1b[1;36m\1\x1b[0m/g" \
  -e "s/(Tests:)/\x1b[1;36m\1\x1b[0m/g" \
  -e "s/([0-9]+) (passed)/\x1b[32m\1 \2\x1b[0m/g" \
  -e "s/([0-9]+) (failed)/\x1b[38;5;203m\1 \2\x1b[0m/g" \
  -e "s/([0-9]+) (skipped)/\x1b[90m\1 \2\x1b[0m/g" \
  -e "s/([0-9]+) (total)/\x1b[36m\1 \2\x1b[0m/g" \
  -e "s/(  at .*)/\x1b[90m\1\x1b[0m/g"
yarn test v1.22.19

 PASS  src/components/__tests__/Button.test.tsx (234ms)
   ✓ renders correctly (45ms)
   ✓ handles click events (23ms)
   ✓ applies custom className (12ms)

 PASS  src/utils/__tests__/helpers.test.ts (156ms)
   ✓ formatDate formats date correctly (8ms)
   ✓ parseJSON handles invalid JSON (15ms)

 FAIL  src/hooks/__tests__/useAuth.test.tsx (892ms)
   ✗ should login user (234ms)

     Expected mock function to have been called with:
       [{"username": "test", "password": "test123"}]
     But it was called with:
       [{"username": "test"}]

     at Object.<anonymous> (src/hooks/__tests__/useAuth.test.tsx:67:24)
     at processTicksAndRejections (node:internal/process/task_queues:95:5)

Test Suites: 2 passed, 1 failed, 3 total
Tests:       5 passed, 1 failed, 2 skipped, 8 total
EOF

pause

# ============================================================================
# 8. REACT STACK TRACE WITH ERROR BOUNDARY
# ============================================================================

echo "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "8. REACT STACK TRACE (С ERRORBOUNDARY)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "\n"

cat << 'EOF' | sed -E \
  -e "s/(TypeError|ErrorBoundary)/\x1b[38;5;203m\1\x1b[0m/g" \
  -e "s/(in )([A-Z][a-zA-Z0-9]*)/\x1b[36m\1\2\x1b[0m/g" \
  -e "s/(at )([^ ]+)/\x1b[90m\1\2\x1b[0m/g" \
  -e "s/(The above error occurred)/\x1b[38;5;203m\1\x1b[0m/g"
TypeError: Cannot read properties of undefined (reading 'map')
  at UserList (src/components/UserList.tsx:23:15)
  at renderWithHooks (node_modules/react-dom/cjs/react-dom.development.js:16305:18)
  at mountIndeterminateComponent (node_modules/react-dom/cjs/react-dom.development.js:20074:13)

The above error occurred in UserList component:
  in UserList (at Dashboard.tsx:45)
  in Dashboard (at App.tsx:23)
  in ErrorBoundary (at App.tsx:12)
  in App
EOF

pause

# ============================================================================
# 9. ЖИВЫЕ ПРИМЕРЫ ЦВЕТОВ (УЛУЧШЕННАЯ СЕКЦИЯ)
# ============================================================================

echo "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "9. ЖИВЫЕ ПРИМЕРЫ ЦВЕТОВОЙ СХЕМЫ"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "\n"

echo "ЯРКИЕ АКЦЕНТЫ (критические элементы):"
echo ""
echo -e "  \x1b[38;5;203m██\x1b[0m  \x1b[38;5;203mERROR\x1b[0m / \x1b[38;5;203mFAIL\x1b[0m / \x1b[38;5;203m✗\x1b[0m                    (ярко-красный #f38ba8)"
echo -e "  \x1b[38;5;203m██\x1b[0m  \x1b[38;5;203mSyntaxError\x1b[0m / \x1b[38;5;203mTypeError\x1b[0m         (ярко-красный #f38ba8)"
echo -e "  \x1b[38;5;203m██\x1b[0m  \x1b[38;5;203mBuild failed\x1b[0m                         (ярко-красный #f38ba8)"
echo -e "  \x1b[38;5;203m██\x1b[0m  \x1b[38;5;203mErrorBoundary\x1b[0m                        (ярко-красный #f38ba8)"
echo -e "  \x1b[38;5;203m██\x1b[0m  \x1b[38;5;203m✖ 3 errors\x1b[0m                           (ярко-красный #f38ba8)"
echo ""
echo -e "  \x1b[1;33m██\x1b[0m  \x1b[1;33mWARNING\x1b[0m / \x1b[1;33mwarn\x1b[0m / \x1b[1;33m⚠\x1b[0m                  (желтый)"
echo -e "  \x1b[1;33m██\x1b[0m  \x1b[1;33mCritical dependency\x1b[0m                 (желтый)"
echo -e "  \x1b[1;33m██\x1b[0m  \x1b[1;33m⚠ 2 warnings\x1b[0m                        (желтый)"
echo ""
echo -e "  \x1b[1;32m██\x1b[0m  \x1b[1;32mPASS\x1b[0m / \x1b[1;32mSUCCESS\x1b[0m / \x1b[1;32m✓\x1b[0m                 (зеленый)"
echo -e "  \x1b[1;32m██\x1b[0m  \x1b[1;32mCompiled\x1b[0m / \x1b[1;32mReady\x1b[0m                    (зеленый)"
echo ""
echo -e "  \x1b[4;36m██\x1b[0m  \x1b[4;36msrc/components/Button.tsx\x1b[0m            (cyan подчеркнутый)"
echo -e "  \x1b[4;36m██\x1b[0m  \x1b[4;36mhttp://localhost:3000\x1b[0m                (cyan подчеркнутый)"
echo ""
echo "ПРИГЛУШЕННЫЕ ЭЛЕМЕНТЫ (второстепенная информация):"
echo ""
echo -e "  \x1b[90m██\x1b[0m  \x1b[90mat Component (file.tsx:45:12)\x1b[0m        (серый #90)"
echo -e "  \x1b[90m██\x1b[0m  \x1b[90m(123ms)\x1b[0m / \x1b[90m(4.521s)\x1b[0m                   (серый #90)"
echo -e "  \x1b[90m██\x1b[0m  \x1b[90m(45,12)\x1b[0m / \x1b[90m67:23\x1b[0m                      (серый #90)"
echo ""
echo "REACT КОМПОНЕНТЫ И ЗАГОЛОВКИ:"
echo ""
echo -e "  \x1b[36m██\x1b[0m  \x1b[36min UserList\x1b[0m / \x1b[36min Dashboard\x1b[0m          (cyan)"
echo -e "  \x1b[36m██\x1b[0m  \x1b[36min ErrorBoundary\x1b[0m / \x1b[36min App\x1b[0m            (cyan)"
echo -e "  \x1b[1;36m██\x1b[0m  \x1b[1;36mTest Suites:\x1b[0m / \x1b[1;36mTests:\x1b[0m              (cyan bold)"
echo ""
echo "ОКРАСКА СЛОВ passed/failed/total:"
echo ""
echo -e "  Test Suites: \x1b[1;32m2 passed\x1b[0m, \x1b[38;5;203m1 failed\x1b[0m, \x1b[36m3 total\x1b[0m"
echo -e "  Tests:       \x1b[32m15 passed\x1b[0m, \x1b[38;5;203m1 failed\x1b[0m, \x1b[36m16 total\x1b[0m"
echo ""

pause

# ============================================================================
# 10. ИТОГОВОЕ РЕЗЮМЕ
# ============================================================================

echo "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "10. ИТОГОВОЕ РЕЗЮМЕ"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "\n"

echo "ФИЛОСОФИЯ ЦВЕТОВОЙ СХЕМЫ (GitHub AMOLED):"
echo ""
echo "✓ ЯРКИЕ АКЦЕНТЫ для критического:"
echo "  • Ошибки хорошо видны на темном фоне"
echo "  • Немедленно привлекают внимание"
echo "  • Используется ярко-красный (#f38ba8) вместо темно-красного"
echo ""
echo "✓ ПРИГЛУШЕННЫЕ цвета для второстепенного:"
echo "  • Stack traces не отвлекают"
echo "  • Координаты и время в сером (#90)"
echo "  • Фокус на важной информации"
echo ""
echo "✓ КОМПОНЕНТЫ выделены cyan:"
echo "  • React компоненты легко различимы"
echo "  • Файлы подчеркнуты для мгновенного распознавания"
echo "  • URLs явно выделены"
echo ""

echo "═══════════════════════════════════════════════════════════════════════"
echo "  ДЕМОНСТРАЦИЯ ЗАВЕРШЕНА"
echo "═══════════════════════════════════════════════════════════════════════"
echo "\n"

echo -e "\x1b[1;32m✅ Теперь все эти элементы подсвечиваются автоматически!\x1b[0m"
echo ""
echo "Попробуй реальные команды:"
echo -e "  \x1b[1;36m# Запуск тестов\x1b[0m"
echo "  npm test"
echo "  yarn test"
echo "  jest"
echo ""
echo -e "  \x1b[1;36m# TypeScript компиляция\x1b[0m"
echo "  tsc --noEmit"
echo ""
echo -e "  \x1b[1;36m# ESLint проверка\x1b[0m"
echo "  eslint src/"
echo "  npm run lint"
echo ""
echo -e "  \x1b[1;36m# Next.js разработка\x1b[0m"
echo "  npm run dev"
echo "  next dev"
echo ""
echo -e "  \x1b[1;36m# Build проекта\x1b[0m"
echo "  npm run build"
echo "  yarn build"
echo ""
echo -e "\x1b[90mПодсветка работает во всех терминалах: Warp, iTerm2, VSCode\x1b[0m"
echo "\n"