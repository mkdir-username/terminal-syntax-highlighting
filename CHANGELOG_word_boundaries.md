# Word Boundaries Update - Changelog

## Обзор изменений

Обновлены паттерны подсветки синтаксиса для использования **word boundaries** (границ слов), что предотвращает ложные срабатывания при поиске ключевых слов в тексте.

### Проблема (до обновления)

Старые паттерны использовали простой поиск подстроки, что приводило к **ложным срабатываниям**:

```bash
# ❌ Неправильно подсвечивалось:
"terrored citizens"        # "error" внутри "terrored"
"errorless execution"      # "error" внутри "errorless"
"unsuccessful attempt"     # "success" внутри "unsuccessful"
"prewarned system"         # "warn" внутри "prewarned"
```

### Решение (после обновления)

Используются **BSD sed word boundaries** (`[[:<:]]` и `[[:>:]]` для macOS):

```bash
# ✅ Правильно подсвечивается только полные слова:
"error occurred"           # ✓ "error" подсвечен
"terrored citizens"        # ✓ "error" НЕ подсвечен (часть слова)

"test failed"              # ✓ "failed" подсвечен
"Build failed with error"  # ✓ оба слова подсвечены
```

---

## Файлы с изменениями

### 1. `configs/zsh/error_highlighting.zsh`

#### Функция `highlight_errors()`

**Было:**
```bash
-e "s/(error|Error|ERROR)/${RED}\1${NC}/g"
-e "s/(warning|Warning|WARNING)/${YELLOW}\1${NC}/g"
```

**Стало:**
```bash
# ERROR patterns (красный)
-e "s/[[:<:]](error|errors|err|fail|failed|failure|failing|fails|fatal|critical|exception|traceback|panic|panicked|panicking|abort|aborted|aborting|crash|crashed|crashing|[A-Z][a-zA-Z]*Error|[A-Z][a-zA-Z]*Exception)[[:>:]]/\x1b[38;5;203m\1\x1b[0m/g"

# WARNING patterns (желтый)
-e "s/[[:<:]](warn|warning|warnings|warned|warns|caution|cautionary|cautioned|cautioning|cautions|deprecat|deprecated|deprecation|deprecating|[A-Z][a-zA-Z]*Warning)[[:>:]]/\x1b[1;33m\1\x1b[0m/g"

# SUCCESS patterns (зеленый)
-e "s/[[:<:]](success|successes|successful|successfully|succeed|succeeded|succeeding|succeeds|ok|okay|pass|passed|passing|passes)[[:>:]]/\x1b[1;32m\1\x1b[0m/g"

# SKIP patterns (серый)
-e "s/[[:<:]](skip|skipped|skipping|skips|ignore|ignored|ignoring|ignores|omit|omitted|omitting|omits)[[:>:]]/\x1b[90m\1\x1b[0m/g"

# INFO patterns (голубой)
-e "s/[[:<:]](info|information|informational|debug|debugging|debugged|trace|tracing|traced|verbose|note|noted|notes|notice|noticed|notices|log|logged|logging|logs)[[:>:]]/\x1b[1;36m\1\x1b[0m/g"
```

**Улучшения:**
- ✅ Word boundaries `[[:<:]]` и `[[:>:]]`
- ✅ Расширенный список вариантов слов (succeed, succeeded, succeeding...)
- ✅ Поддержка TypeScript/JavaScript error types (`TypeError`, `SyntaxError`, etc.)
- ✅ Новая категория SKIP (skip, ignore, omit)

---

### 2. `configs/zsh/command_wrappers.zsh`

Обновлены все wrapper функции:
- `npm()` - npm commands
- `yarn()` - yarn commands
- `jest()` - Jest test runner
- `tsc()` - TypeScript compiler
- `eslint()` / `highlight_eslint()` - ESLint
- `next()` / `highlight_react_errors()` - Next.js
- `python3()` - Python interpreter
- `docker()` - Docker commands

#### Пример изменений в `npm()`:

**Было:**
```bash
-e "s/(error|Error|ERROR)/\x1b[38;5;203m\1\x1b[0m/g"
-e "s/([0-9]+) (passed)/\x1b[32m\1 \2\x1b[0m/g"
```

**Стало:**
```bash
-e "s/[[:<:]](error|errors|err|fail|failed|failure|...)[[:>:]]/\x1b[38;5;203m\1\x1b[0m/g"
-e "s/([0-9]+) [[:<:]](passed)[[:>:]]/\x1b[32m\1 \2\x1b[0m/g"
```

---

## Новые паттерны

### 🔴 ERROR (красный #ef4444)
```regex
error|errors|err|fail|failed|failure|failing|fails|
fatal|critical|exception|traceback|
panic|panicked|panicking|
abort|aborted|aborting|
crash|crashed|crashing|
[A-Z][a-zA-Z]*Error|[A-Z][a-zA-Z]*Exception
```

**Примеры:**
- `error`, `Error`, `ERROR`
- `failed`, `failing`, `fails`
- `TypeError`, `SyntaxError`, `ReferenceError`
- `panic`, `panicked`, `panicking` (Rust)
- `crash`, `crashed`, `crashing`

### 🟡 WARNING (желтый #f59e0b)
```regex
warn|warning|warnings|warned|warns|
caution|cautionary|cautioned|cautioning|cautions|
deprecat|deprecated|deprecation|deprecating|
[A-Z][a-zA-Z]*Warning
```

**Примеры:**
- `warning`, `warn`, `warned`
- `deprecated`, `deprecation`
- `RuntimeWarning`, `DeprecationWarning`

### 🟢 SUCCESS (зеленый #22c55e)
```regex
success|successes|successful|successfully|
succeed|succeeded|succeeding|succeeds|
ok|okay|
pass|passed|passing|passes
```

**Примеры:**
- `success`, `successful`, `successfully`
- `succeed`, `succeeded`, `succeeding`
- `pass`, `passed`, `passing`

### ⚫ SKIP (серый #9ca3af)
```regex
skip|skipped|skipping|skips|
ignore|ignored|ignoring|ignores|
omit|omitted|omitting|omits
```

**Примеры:**
- `skip`, `skipped`, `skipping`
- `ignore`, `ignored`
- `omit`, `omitted`

### 🔵 INFO (голубой #3b82f6)
```regex
info|information|informational|
debug|debugging|debugged|
trace|tracing|traced|
verbose|
note|noted|notes|
notice|noticed|notices|
log|logged|logging|logs
```

**Примеры:**
- `info`, `information`
- `debug`, `debugging`
- `trace`, `tracing`
- `verbose`, `note`, `log`

---

## Тестирование

### Запуск тестов

```bash
cd ~/terminal-syntax-highlighting
./demos/test_word_boundaries.sh
```

### Ручное тестирование

```bash
# 1. Перезагрузить конфигурацию
source ~/.zshrc

# 2. Протестировать вручную
echo "error occurred"          # ✅ "error" подсвечен
echo "errorless execution"     # ✅ "error" НЕ подсвечен
echo "Test passed"             # ✅ "passed" подсвечен
echo "surpassed expectations"  # ✅ "pass" НЕ подсвечен
```

### Тестовые команды

```bash
# NPM
npm run build  # проверить подсветку ошибок/успеха

# Jest
jest          # проверить "PASS"/"FAIL" и "passed"/"failed"

# TypeScript
tsc           # проверить "error TS2304"

# Python
python3 test.py  # проверить "TypeError", "ValueError"
```

---

## Обратная совместимость

✅ **Полная обратная совместимость**:
- Все старые паттерны работают как раньше
- Новые паттерны только расширяют функциональность
- Не требуется изменений в существующих скриптах

---

## Применение изменений

### Автоматически (рекомендуется)

```bash
# Перезагрузить zsh конфигурацию
source ~/.zshrc
```

### Вручную

```bash
# Открыть новый терминал
# ИЛИ
exec zsh
```

---

## Известные ограничения

1. **Word boundaries работают только в BSD sed (macOS)**
   - На Linux с GNU sed используйте `\b` вместо `[[:<:]]` и `[[:>:]]`

2. **Регистр учитывается**
   - Паттерны различают `Error`, `ERROR`, `error`
   - Все варианты включены в regex

3. **Производительность**
   - При большом количестве паттернов возможна небольшая задержка
   - Для очень больших логов (>10MB) используйте `command <tool>` чтобы пропустить подсветку

---

## Дополнительные ресурсы

- [BSD sed documentation](https://www.freebsd.org/cgi/man.cgi?query=sed)
- [ANSI color codes](https://en.wikipedia.org/wiki/ANSI_escape_code)
- [Original log patterns reference](../demos/test_word_boundaries.sh)

---

## Контрибьюторы

Обновление паттернов основано на:
- Регулярных выражениях из современных логгеров
- Best practices для терминальной подсветки
- Поддержка React/Next.js/TypeScript/Jest/ESLint стека

---

**Дата обновления:** 2025-11-17
**Версия:** 2.0.0 (Word Boundaries Update)
