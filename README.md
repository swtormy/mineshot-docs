# MineShot

Уютная пиксельная шахтёрская idle-тапалка. Реализацию делаю я, приёмка — ваша.

Публичное имя: **MineShot**. Бот: в духе `mineshot`. Старое рабочее «Idle Mine» больше не используем в текстах для игрока.

## Этап 1 (сейчас)

Один веб-билд, две оболочки:

1. **PWA** — тестовый HTTPS, без своего домена.
2. **Telegram Mini App** — новый бот, запуск сразу всеми способами: меню, `/play`, прямая ссылка.

Аудитория: узкий круг по ссылке. Магазины — после обкатки.

## Что уже решено

Тап по шахтёру. Несколько руд. Магазин из трёх линий. Завал как проигрыш. Офлайн 8 часов. Без шаринга. Картинки и текстуры генерируете вы через ИИ.

Таблица решений: `docs/03-decisions.md`. План: `docs/04-plan.md`. Роадмеп: `docs/05-roadmap.md`.

## Стек этапа 1

**TypeScript + Phaser 3 + Vite.** PWA + Telegram Mini Apps SDK. Без Capacitor.

## Документы

| Файл | Зачем |
|---|---|
| `docs/00-goal.md` | Цель этапа 1 |
| `docs/01-stack.md` | Стек |
| `docs/03-decisions.md` | Решения |
| `docs/04-plan.md` | План выпуска v1 |
| `docs/05-roadmap.md` | Подробный роадмеп и промпты артов |
| `docs/prompt-hserv-agent.md` | Промпт для агента на hserv |
| `docs/prompt-hserv-phone.md` | **Перенос с телефона (git clone / curl)** |
| `docs/hserv-fetch.sh` | Скачать docs с GitHub без git |
| GitHub | https://github.com/swtormy/mineshot-docs — `git clone` на hserv |
