# Промпт для агента на hserv (ПК / архив)

Если есть ПК и можно скачать архив — прикрепите `mineshot-docs-snapshot.tar.gz`.

**С телефона без скачивания** → используйте `docs/prompt-hserv-phone.md`.

---

---START---

## Задача

Разверни на hserv проект **MineShot** (пока только markdown-документация).

Целевая папка: **`~/projects/mineshot`**

## Получить файлы

### A — архив во вложении

```bash
mkdir -p ~/projects/mineshot && cd ~/projects/mineshot
tar -xzf /path/to/mineshot-docs-snapshot.tar.gz --strip-components=1
```

### B — архив на hserv

```bash
mkdir -p ~/projects/mineshot && cd ~/projects/mineshot
tar -xzf ~/mineshot-docs-snapshot.tar.gz --strip-components=1
```

### C — git (предпочтительно)

```bash
git clone https://github.com/swtormy/mineshot-docs.git ~/projects/mineshot
```

### D — curl без git

```bash
curl -fsSL https://raw.githubusercontent.com/swtormy/mineshot-docs/main/docs/hserv-fetch.sh | bash
```

### E — устаревший bootstrap

`hserv-bootstrap.sh` (base64) **не использовать** — ломается при вставке с телефона.

## Проверка

```bash
cd ~/projects/mineshot
find . -name '*.md' | sort
test -f README.md && test -f docs/05-roadmap.md && echo OK
```

## Git

```bash
git init && git add README.md docs/ && git commit -m "chore: import MineShot docs"
```

Push только если пользователь дал remote.

## Отчёт

Путь, список файлов, первые строки README, какой вариант (A/B/C/D).

---END---
