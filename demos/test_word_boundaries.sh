#!/bin/bash

# ═══════════════════════════════════════════════════════════════
# WORD BOUNDARIES TEST
# Проверка улучшенных паттернов с word boundaries
# ═══════════════════════════════════════════════════════════════

echo "═══════════════════════════════════════════════════════════════"
echo "Testing Word Boundaries in Syntax Highlighting"
echo "═══════════════════════════════════════════════════════════════"
echo ""

echo "✅ SHOULD BE HIGHLIGHTED (complete words):"
echo "-----------------------------------------------------------"
echo "Test passed successfully"                    # passed, successfully
echo "Operation successful"                         # successful
echo "Build succeeded"                              # succeeded
echo "Warning: deprecated API"                      # Warning, deprecated
echo "Error: connection failed"                     # Error, failed
echo "Fatal error occurred"                         # Fatal, error
echo "BoundaryError: index out of range"            # BoundaryError
echo "RuntimeWarning: overflow detected"            # RuntimeWarning
echo "Info: processing started"                     # Info
echo "Debug mode enabled"                           # Debug
echo "Test skipped due to condition"                # skipped
echo "Build failing repeatedly"                     # failing
echo "Tests are passing"                            # passing
echo "Task succeeded without issues"                # succeeded
echo ""

echo "❌ SHOULD NOT BE HIGHLIGHTED (parts of words):"
echo "-----------------------------------------------------------"
echo "--trace-warnings enabled"                     # "warnings" OK, but "warn" in "trace" NO
echo "successfully-built package"                   # "successfully" as whole word OK
echo "errorless execution"                          # "error" NOT highlighted (part of errorless)
echo "unsuccessful attempt"                         # "success" NOT highlighted (part of unsuccessful)
echo "prewarned system"                             # "warn" NOT highlighted (part of prewarned)
echo "nonfatal issue"                               # "fatal" NOT highlighted (part of nonfatal)
echo "terrored citizens"                            # "error" NOT highlighted (part of terrored)
echo "deserrored implementation"                    # "error" NOT highlighted (part of deserrored)
echo ""

echo "🔀 MIXED CASES (complex examples):"
echo "-----------------------------------------------------------"
echo "[ERROR] Failed to connect"                    # ERROR, Failed highlighted
echo "2024-01-01 12:00:00 [WARN] deprecated feature used"  # WARN, deprecated highlighted
echo "✓ Tests passed (3/3)"                         # passed highlighted
echo "npm ERR! code ENOENT"                         # ERR highlighted
echo "SUCCESS: Build completed in 5s"               # SUCCESS highlighted
echo "error: File not found, errorless mode disabled"  # Only first "error" highlighted
echo ""

echo "🎯 LOG LEVEL PATTERNS:"
echo "-----------------------------------------------------------"
echo "[INFO] System initialized"                    # INFO highlighted (cyan)
echo "[WARN] Memory usage high"                     # WARN highlighted (yellow)
echo "[ERROR] Database connection lost"             # ERROR highlighted (red)
echo "[SUCCESS] Deployment complete"                # SUCCESS highlighted (green)
echo "[SKIP] Test skipped by user"                  # SKIP highlighted (gray)
echo ""

echo "📊 NUMBER CONTEXT PATTERNS:"
echo "-----------------------------------------------------------"
echo "2 passed, 1 failed"                           # "passed" green, "failed" red
echo "Build failed with 3 errors"                   # "failed" red, "errors" red
echo "Successfully compiled 15 files"               # "Successfully" green
echo "5 warnings detected"                          # "warnings" yellow
echo "All tests passed"                             # "passed" green
echo ""

echo "🔧 EXCEPTION PATTERNS (TypeScript/JavaScript):"
echo "-----------------------------------------------------------"
echo "TypeError: Cannot read property 'x' of undefined"  # TypeError highlighted
echo "ReferenceError: variable is not defined"      # ReferenceError highlighted
echo "SyntaxError at line 42"                       # SyntaxError highlighted
echo "UnhandledPromiseRejectionWarning: Unhandled promise rejection"  # Warning highlighted
echo "CustomError: Something went wrong"            # CustomError highlighted
echo ""

echo "🐍 PYTHON PATTERNS:"
echo "-----------------------------------------------------------"
echo "IndexError: list index out of range"          # IndexError highlighted
echo "ValueError: invalid literal for int()"        # ValueError highlighted
echo "ImportWarning: can't resolve package"         # ImportWarning highlighted
echo "DeprecationWarning: Function is deprecated"   # DeprecationWarning highlighted
echo ""

echo "═══════════════════════════════════════════════════════════════"
echo "Test Complete! Check colors above."
echo "- GREEN = success/pass patterns"
echo "- RED = error/fail patterns"
echo "- YELLOW = warning/deprecated patterns"
echo "- CYAN = info/debug patterns"
echo "- GRAY = skip/ignore patterns"
echo "═══════════════════════════════════════════════════════════════"
