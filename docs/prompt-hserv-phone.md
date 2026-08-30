# Перенос на hserv с телефона

**Не используйте base64-скрипт** (`hserv-bootstrap.sh`) — при вставке с телефона он ломается.

---

## Способ 1 — одна команда (лучший)

Скопируйте **одну строку** и отправьте агенту на hserv (или выполните в SSH):

```bash
git clone https://github.com/swtormy/mineshot-docs.git ~/projects/mineshot
```

Проверка:

```bash
cd ~/projects/mineshot && find . -name '*.md' | sort
```

Git на hserv:

```bash
cd ~/projects/mineshot
git init  # уже есть .git от clone — пропустить
# после clone git init не нужен
```

После clone репозиторий уже под git. Дополнительный `git init` не нужен.

---

## Способ 2 — curl без git

Если на hserv нет git:

```bash
curl -fsSL https://raw.githubusercontent.com/swtormy/mineshot-docs/main/docs/hserv-fetch.sh | bash
```

Скрипт скачает все `.md` в `~/projects/mineshot`.

---

## Сообщение агенту на hserv (скопировать целиком)

```
Разверни документацию MineShot в ~/projects/mineshot.

Вариант A (предпочтительно):
git clone https://github.com/swtormy/mineshot-docs.git ~/projects/mineshot

Вариант B (без git):
curl -fsSL https://raw.githubusercontent.com/swtormy/mineshot-docs/main/docs/hserv-fetch.sh | bash

Проверь: README.md и docs/05-roadmap.md на месте.
Покажи find . -name '*.md' | sort
Push не делай.
```

---

## Способ 3 — файлы по одному (запасной)

Если нет интернета на hserv или GitHub недоступен — пересылайте агенту содержимое каждого `.md` отдельным сообщением. Список файлов:

- `README.md`
- `docs/00-goal.md` … `docs/05-roadmap.md`
- `docs/prompt-hserv-agent.md`, `docs/prompt-hserv-phone.md`

---

## После успеха

Откройте в Cursor на hserv папку `~/projects/mineshot` и продолжайте разработку.
