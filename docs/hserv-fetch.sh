#!/usr/bin/env bash
# MineShot — скачать документацию с GitHub (без base64, без архива)
set -euo pipefail

REPO="swtormy/mineshot-docs"
BRANCH="main"
BASE="https://raw.githubusercontent.com/${REPO}/${BRANCH}"
TARGET="${HOME}/projects/mineshot"

mkdir -p "${TARGET}/docs"
cd "${TARGET}"

fetch() {
  local path="$1"
  local dir
  dir="$(dirname "$path")"
  [[ "$dir" != "." ]] && mkdir -p "$dir"
  echo "→ ${path}"
  curl -fsSL "${BASE}/${path}" -o "${path}"
}

fetch README.md
for f in \
  docs/00-goal.md \
  docs/01-stack.md \
  docs/02-questions.md \
  docs/03-decisions.md \
  docs/04-plan.md \
  docs/05-roadmap.md \
  docs/prompt-hserv-agent.md \
  docs/prompt-hserv-phone.md \
  docs/hserv-fetch.sh
do
  fetch "$f"
done

echo ""
echo "OK: ${TARGET}"
find . -name '*.md' | sort
test -f README.md && test -f docs/05-roadmap.md && echo "Проверка: OK"
