# Стек (этап 1)

## Решение

| Слой | Технология |
|---|---|
| Язык | TypeScript |
| Игра | Phaser 3 (2D, canvas / WebGL) |
| Сборка | Vite |
| PWA | `vite-plugin-pwa` |
| Telegram | Mini Apps SDK (`telegram-web-app.js` / `@telegram-apps/sdk`) + бот, который открывает URL |
| Хостинг | HTTPS-статика (Vercel / Cloudflare Pages / аналог) |
| Сохранение | Telegram CloudStorage (привязка к аккаунту) + `localStorage` запас / PWA |
| Эффекты | Phaser particles, tweens, camera shake, всплывающий текст |
| Тактильный отклик в Telegram | `HapticFeedback` |
| Картинки | ИИ, генерируете вы; в коде сначала заглушки |
| Звук | открытые библиотеки |

Один `dist`. PWA открывает его в браузере. Telegram WebView открывает тот же URL.

```
TypeScript + Phaser
        ↓
     Vite build → dist
        ↓
   HTTPS-хостинг
        ↓
   ┌────┴────┐
  PWA    Telegram Mini App
```

Android / iOS через Capacitor — после этапа 1, тот же веб-билд.

## Почему этот стек

- Mini App — это веб. Нативный движок (Unity) здесь лишний и плохо грузится в WebView.
- React Native Mini App не даёт: Telegram всё равно показывает HTML. Лишний слой.
- Phaser закрывает сцену, тап, частицы и твины. Idle-кликер — как раз этот набор.
- PWA и Telegram расходятся только в оболочке (манифест / SDK), не в игровой логике.

## Ограничения Telegram, которые закладываем сразу

- Нужен HTTPS и бот (команда / кнопка Menu → URL игры).
- Высота экрана — viewport Telegram, не весь телефон; учитываем шапку и safe area.
- Service worker PWA внутри Telegram ненадёжен; офлайн-установка — только для браузерного PWA.
- Автовоспроизведение звука в WebView часто блокируется, пока не было первого тапа.
- Сейв этапа 1: Telegram `CloudStorage` по аккаунту. `localStorage` — запас и режим PWA без Telegram.

## Ассеты

Картинки и текстуры — ИИ по промптам из `docs/05-roadmap.md`. Звук и короткий loop — открытые библиотеки. Источники звука фиксируем в репозитории.

## Откладываем

- Capacitor, магазины, нативные SDK
- Игровой сервер, аккаунты
- Реклама, Stars / платежи (можно заложить позже)
- Redux, ECS, 3D
