#!/usr/bin/env bash
# УСТАРЕЛО — base64 ломается при вставке с телефона.
# Используйте вместо этого:
#   git clone https://github.com/swtormy/mineshot-docs.git ~/projects/mineshot
# или:
#   curl -fsSL https://raw.githubusercontent.com/swtormy/mineshot-docs/main/docs/hserv-fetch.sh | bash
echo "Этот скрипт устарел (base64 + телефон = битые данные)." >&2
echo "См. docs/prompt-hserv-phone.md" >&2
exit 1
