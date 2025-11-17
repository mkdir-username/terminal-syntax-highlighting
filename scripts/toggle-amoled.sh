#!/usr/bin/env zsh

# ============================================================================
# AMOLED MODE TOGGLE SCRIPT
# Быстрое переключение между обычным и AMOLED режимом
# ============================================================================

ZSHRC="$HOME/.zshrc"
PROFILE="$HOME/.zprofile"

# Цвета для вывода
RED='\033[38;5;203m'
GREEN='\033[38;5;46m'
CYAN='\033[38;5;51m'
YELLOW='\033[38;5;226m'
NC='\033[0m'

# Функция для включения AMOLED режима
enable_amoled() {
  # Добавляем переменную в .zprofile (загружается перед .zshrc)
  if ! grep -q "export ZSH_AMOLED_MODE" "$PROFILE" 2>/dev/null; then
    echo "export ZSH_AMOLED_MODE=1" >> "$PROFILE"
  else
    sed -i '' 's/export ZSH_AMOLED_MODE=0/export ZSH_AMOLED_MODE=1/' "$PROFILE"
  fi

  echo -e "${GREEN}✓ AMOLED режим ВКЛЮЧЕН${NC}"
  echo -e "${CYAN}  Яркие контрастные цвета для черного фона${NC}"
  echo -e "${YELLOW}  Перезапусти терминал или выполни: source ~/.zshrc${NC}"
}

# Функция для отключения AMOLED режима
disable_amoled() {
  if [ -f "$PROFILE" ]; then
    sed -i '' 's/export ZSH_AMOLED_MODE=1/export ZSH_AMOLED_MODE=0/' "$PROFILE"
  fi

  echo -e "${RED}✓ AMOLED режим ОТКЛЮЧЕН${NC}"
  echo -e "${CYAN}  Используются стандартные цвета${NC}"
  echo -e "${YELLOW}  Перезапусти терминал или выполни: source ~/.zshrc${NC}"
}

# Показать текущий статус
show_status() {
  if [ "$ZSH_AMOLED_MODE" = "1" ]; then
    echo -e "${GREEN}● AMOLED режим: ${GREEN}ВКЛЮЧЕН${NC}"
  else
    echo -e "${RED}● AMOLED режим: ${RED}ОТКЛЮЧЕН${NC}"
  fi
}

# Main
case "$1" in
  on|enable|1)
    enable_amoled
    ;;
  off|disable|0)
    disable_amoled
    ;;
  status)
    show_status
    ;;
  *)
    echo -e "${CYAN}═══════════════════════════════════════${NC}"
    echo -e "${CYAN}  AMOLED Mode Toggle${NC}"
    echo -e "${CYAN}═══════════════════════════════════════${NC}"
    echo ""
    show_status
    echo ""
    echo -e "Использование:"
    echo -e "  ${GREEN}$0 on${NC}      - Включить AMOLED режим"
    echo -e "  ${RED}$0 off${NC}     - Отключить AMOLED режим"
    echo -e "  ${CYAN}$0 status${NC}  - Показать статус"
    echo ""
    ;;
esac
