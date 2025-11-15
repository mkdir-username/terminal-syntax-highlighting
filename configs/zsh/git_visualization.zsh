# ═══════════════════════════════════════════════════════════════
# ENHANCED GIT VISUALIZATION
# Улучшенная визуализация git команд с цветными индикаторами
# ═══════════════════════════════════════════════════════════════

# Git статус с визуальными индикаторами
git_status_pretty() {
  local RED='\033[1;31m'
  local YELLOW='\033[1;33m'
  local GREEN='\033[1;32m'
  local CYAN='\033[1;36m'
  local NC='\033[0m'

  echo -e "\n${CYAN}═══════════════════════════════════════${NC}"
  echo -e "${CYAN}        GIT STATUS${NC}"
  echo -e "${CYAN}═══════════════════════════════════════${NC}\n"

  git status --short --branch | while IFS= read -r line; do
    if [[ $line == "##"* ]]; then
      echo -e "${CYAN}$line${NC}"
    elif [[ $line == "??"* ]]; then
      echo -e "${RED}● $line  (untracked)${NC}"
    elif [[ $line == " M"* ]] || [[ $line == "M "* ]] || [[ $line == "MM"* ]]; then
      echo -e "${YELLOW}● $line  (modified)${NC}"
    elif [[ $line == "A "* ]]; then
      echo -e "${GREEN}● $line  (added)${NC}"
    elif [[ $line == "D "* ]]; then
      echo -e "${RED}● $line  (deleted)${NC}"
    elif [[ $line == "R "* ]]; then
      echo -e "${CYAN}● $line  (renamed)${NC}"
    else
      echo -e "  $line"
    fi
  done

  echo -e "\n${CYAN}═══════════════════════════════════════${NC}\n"
}

# Git log с красивым форматированием
git_log_pretty() {
  git log --graph --pretty=format:'%C(red)%h%C(reset) -%C(yellow)%d%C(reset) %s %C(green)(%cr) %C(bold blue)<%an>%C(reset)' --abbrev-commit --date=relative "$@"
}

# Git diff с подсветкой изменений
git_diff_pretty() {
  git diff --color=always --color-moved=zebra "$@"
}

# Показать файлы которые изменены но не добавлены
git_modified() {
  local YELLOW='\033[1;33m'
  local NC='\033[0m'
  echo -e "\n${YELLOW}Измененные файлы (не в stage):${NC}\n"
  git diff --name-only --diff-filter=M
}

# Показать untracked файлы
git_untracked() {
  local RED='\033[1;31m'
  local NC='\033[0m'
  echo -e "\n${RED}Неотслеживаемые файлы:${NC}\n"
  git ls-files --others --exclude-standard
}

# Git алиасы с улучшенной подсветкой
alias gst='git_status_pretty'
alias gsp='git_status_pretty'
alias glog='git_log_pretty'
alias glp='git_log_pretty'
alias gdiff='git_diff_pretty'
alias gdp='git_diff_pretty'
alias gmod='git_modified'
alias guntr='git_untracked'

# Стандартные git алиасы
alias ga='git add'
alias gaa='git add --all'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gpl='git pull --rebase'
alias gps='git push'
alias gpsf='git push --force-with-lease'
alias grb='git rebase'
alias grs='git reset'
alias gsh='git stash'
alias gshp='git stash pop'
