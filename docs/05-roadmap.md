# Роадмеп MineShot v1

Раскрывает план `docs/04-plan.md`. Здесь порядок работ, критерии и **готовые промпты** на каждый объект.

Картинки и текстуры генерируете вы. Код, звук, бот, хостинг — я. Пока файла нет, в игре стоит цветная заглушка с тем же именем.

---

## Сквозные правила

- Портрет, одна сцена, уютный пиксель, тёмная шахта, золото.
- Валюта магазина — **золото**. Уголь, железо, кристалл — дроп и достижения.
- Магазин: кирка, автодобыча, множитель. Каждая линия качается много раз.
- Проигрыш: завал. Сейв не трём.
- Офлайн: `idle_rate × min(секунды, 8 часов)`.
- Имя персонажа в промптах всегда одно и то же (блок «стиль» ниже). Не менять шлем, бороду, шарф между картинками.

Порядок генерации артов: **сначала шахтёр idle** (эталон) → позы шахтёра → руда → тайлы фона → иконки → FX → иконка приложения.

---

## Шаг 0. Правила на бумаге

### Задачи

- Экран: шахтёр в центре, порода за ним, счётчики сверху, магазин снизу, шкала завала.
- Четыре ресурса: уголь, железо, золото, кристалл.
- Формулы магазина (черновик, потом подкрутим на обкатке):
  - доход за тап = `(1 + кирка) × множитель`
  - idle в секунду = `авто × множитель`
  - цена уровня `n` = `base × 1.15^n` (кирка base 10, авто 25, множитель 100 золота)
- Завал: шкала 0–100, +за быстрые тапы, −медленно сама; при 100 — нокаут 3–5 с, сброс комбо, потеря руды «в воздухе».
- 8–12 достижений вида «добудь N», «купи кирку 5», «переживи 3 завала».
- Строки RU/EN в одном файле.

### Артефакт

`docs/06-tz.md` (следующий документ, не этот роадмеп).

### Готово

Можно собирать сцену, не угадывая правила.

---

## Шаг 1. Каркас

### Задачи

- Репозиторий: Vite, TypeScript, Phaser 3, портрет 390×844 логических px, scale to fit.
- Сцены: `Boot` (загрузка), `Mine` (игра), заглушка `Settings`.
- Папки: `src/game`, `src/ui`, `src/save`, `src/i18n`, `public/assets`.
- Заглушки PNG тех же имён, что в таблице артов.
- Dev-сервер, проверка с телефона в локальной сети.

### Готово

Чёрный экран шахты открывается на телефоне, консоль без ошибок.

---

## Шаг 2. Арт и звук

Вы генерируете **PNG**. Лучше квадрат, степень двойки, **прозрачный фон** у спрайтов. Без текста на картинке. Если модель пишет буквы — перегенерировать.

Звук ищу я (удар, UI, завал, короткий loop). Музыку не генерируем картинками.

Как пользоваться промптами:

1. Скопировать **общий префикс** + промпт объекта.
2. Сначала сделать `miner_idle.png` и больше не менять описание персонажа.
3. Для поз шахтёра в начало добавлять: `same character as reference, identical helmet scarf beard overalls`.
4. Если есть референс — прикрепить idle к остальным позам.

### Общий префикс (вставлять в каждый промпт)

```
Cozy pixel art, chunky 32x32 / 64x64 game sprite style, limited warm palette, dark underground mine, charcoal walls, gold ore accents, warm lantern orange light, crisp pixels, no anti-aliasing, no blur, no photorealism, no text, no watermark, no UI, centered
```

Негатив (если модель умеет):

```
blur, noise, 3D render, realistic photo, anime, extra limbs, readable letters, watermark, busy background, white studio backdrop
```

### Эталон персонажа (не менять)

Короткий уютный дварф-шахтёр: круглый нос, рыже-коричневая борода, жёлтый каска-шлем с крошечным фонариком, оранжевый вязаный шарф, синие комбинезоны, коричневые ботинки, толстая кирка с золотым наконечником.

---

### 2.1 Шахтёр

| Файл | Размер | Зачем |
|---|---|---|
| `miner_idle.png` | 64×64 | Стоит, готов к тапу. Эталон |
| `miner_hit.png` | 64×64 | Замах / удар киркой |
| `miner_ko.png` | 64×64 | Нокаут после завала |
| `miner_blink.png` | 64×64 | Необязательно: простой кадр «моргнул» для idle-анимации |

**`miner_idle.png`**

```
Cozy pixel art, chunky pixels, 64x64 game sprite, transparent background, full body, side-front view.
Short cozy dwarf miner, round nose, bushy auburn beard, yellow miner helmet with a tiny lantern, orange knitted scarf, navy blue overalls, brown boots, holding a chunky pickaxe with a gold-tipped head, resting on his shoulder.
Dark mine lighting, warm gold rim light. Idle pose, feet planted, cute not scary. No text.
```

**`miner_hit.png`**

```
Same character as the idle dwarf miner: yellow helmet with lantern, auburn beard, orange scarf, navy overalls, brown boots, gold-tipped pickaxe.
Cozy pixel art, 64x64 sprite, transparent background, chunky pixels.
Action pose: mid-swing, pickaxe striking forward, body leaning into the hit, small motion lines ok. Warm lantern light. No text.
```

**`miner_ko.png`**

```
Same character as the idle dwarf miner: yellow helmet with lantern, auburn beard, orange scarf, navy overalls, brown boots.
Cozy pixel art, 64x64 sprite, transparent background, chunky pixels.
Knocked out on the ground after a cave-in, sitting dazed, swirl stars above helmet, pickaxe dropped beside him, dusty but cute, not bloody. Warm dim light. No text.
```

**`miner_blink.png`** (если делаете)

```
Same character as idle dwarf miner, identical pose and clothes, cozy pixel art 64x64 transparent background, eyes closed for one frame, chunky pixels, no text.
```

---

### 2.2 Порода и удар

| Файл | Размер | Зачем |
|---|---|---|
| `rock_idle.png` | 96×96 | Жила/камень за шахтёром |
| `rock_cracked.png` | 96×96 | После серии ударов |
| `rock_chunk.png` | 32×32 | Осколок для частиц |

**`rock_idle.png`**

```
Cozy pixel art, 96x96 game sprite, transparent background, chunky pixels.
A big mine rock face / ore vein, dark charcoal stone with warm gold flecks in cracks, small lantern highlight, cute not realistic, centered boulder you can hit. No character, no text.
```

**`rock_cracked.png`**

```
Same gold-flecked charcoal mine rock as a game sprite, cozy pixel art, 96x96, transparent background.
Visible cracks glowing faintly gold, chips missing, about to crumble but still one piece. No text.
```

**`rock_chunk.png`**

```
Tiny pixel art debris pebble, 32x32, transparent background, dark stone with a speck of gold, chunky pixels, single chunk for particles, no text.
```

---

### 2.3 Руда (иконки счётчика + то, что вылетает из удара)

Один файл на тип: квадрат, камень читается силуэтом.

| Файл | Ресурс |
|---|---|
| `ore_coal.png` | Уголь |
| `ore_iron.png` | Железо |
| `ore_gold.png` | Золото (валюта магазина) |
| `ore_crystal.png` | Кристалл |

**`ore_coal.png`**

```
Cozy pixel art item icon, 32x32, transparent background, chunky pixels.
A lump of coal, matte black with tiny warm highlight, cute game pickup, high contrast silhouette. No text.
```

**`ore_iron.png`**

```
Cozy pixel art item icon, 32x32, transparent background, chunky pixels.
A raw iron ore chunk, cool grey-blue metal with dull shine, cute game pickup. No text.
```

**`ore_gold.png`**

```
Cozy pixel art item icon, 32x32, transparent background, chunky pixels.
A bright gold ore nugget, warm yellow-gold, lantern sparkle, cute game pickup, readable at small size. No text.
```

**`ore_crystal.png`**

```
Cozy pixel art item icon, 32x32, transparent background, chunky pixels.
A small hexagonal crystal, deep gold-amber (not blue), faceted, glowing faintly, cute rare pickup. No text.
```

---

### 2.4 Текстуры и слои фона

Тайлы должны стыковаться (repeatable), если модель умеет seamless. Если шов виден — всё равно берём, обрежем.

| Файл | Размер | Зачем |
|---|---|---|
| `tex_cave_wall.png` | 128×128 | Стена шахты, repeat |
| `tex_floor.png` | 128×128 | Пол |
| `tex_timber.png` | 64×128 | Деревянная крепь |
| `tex_gold_vein.png` | 128×64 | Золотая жила на стене (множитель) |
| `tex_rails.png` | 128×32 | Рельсы внизу кадра |
| `prop_lantern.png` | 32×48 | Лампа на крепи |
| `prop_cart.png` | 64×48 | Вагонетка (автодобыча) |
| `prop_crate.png` | 48×48 | Ящик у магазина |

**`tex_cave_wall.png`**

```
Seamless pixel art tile, 128x128, cozy underground cave wall texture, dark charcoal and brown rock, sparse gold specks in cracks, warm lantern lighting from above, chunky pixels, tileable, no character, no text, no UI.
```

**`tex_floor.png`**

```
Seamless pixel art tile, 128x128, mine floor, packed dirt and small pebbles, dark warm brown, faint gold dust, chunky pixels, tileable, no text.
```

**`tex_timber.png`**

```
Vertical pixel art wooden mine support beam, 64x128, transparent background around the beam, cozy chunky pixels, warm brown timber with nails, lantern light, no text.
```

**`tex_gold_vein.png`**

```
Pixel art overlay, 128x64, transparent background, a horizontal gold ore vein streak in dark rock, glowing softly, cozy chunky pixels, for a mine wall, no text.
```

**`tex_rails.png`**

```
Pixel art mine rail strip, 128x32, two iron rails on sleepers, dark metal, cozy chunky pixels, can repeat horizontally, transparent above rails, no text.
```

**`prop_lantern.png`**

```
Cozy pixel art prop, 32x48, transparent background, hanging miner lantern, warm orange glow, metal frame, chunky pixels, no text.
```

**`prop_cart.png`**

```
Cozy pixel art minecart, 64x48, transparent background, small wooden cart on wheels, a little gold ore inside, cute, chunky pixels, side view, no text.
```

**`prop_crate.png`**

```
Cozy pixel art wooden crate, 48x48, transparent background, closed box, warm wood, metal corners, chunky pixels, no text.
```

---

### 2.5 Магазин и UI

| Файл | Зачем |
|---|---|
| `ui_panel.png` | Фон нижней панели магазина |
| `icon_upgrade_pickaxe.png` | Линия «кирка» |
| `icon_upgrade_auto.png` | Линия «автодобыча» |
| `icon_upgrade_mult.png` | Линия «множитель» |
| `icon_settings.png` | Шестерёнка |
| `icon_sound_on.png` / `icon_sound_off.png` | Звук |
| `icon_lang.png` | Язык |
| `ui_button.png` | Кнопка «купить» (без текста, текст наложу кодом) |

**`ui_panel.png`**

```
Pixel art UI panel texture, 256x96, dark wood and iron frame, cozy mine shop bar, gold rivets, warm lantern edge light, chunky pixels, empty center, no letters, no numbers.
```

**`icon_upgrade_pickaxe.png`**

```
Cozy pixel art icon 32x32 transparent background, a sturdy pickaxe with gold tip, readable silhouette, mine shop upgrade icon, chunky pixels, no text.
```

**`icon_upgrade_auto.png`**

```
Cozy pixel art icon 32x32 transparent background, tiny minecart with a lantern, meaning idle auto-mining, chunky pixels, no text.
```

**`icon_upgrade_mult.png`**

```
Cozy pixel art icon 32x32 transparent background, glowing gold ore vein / sparkling multiplier gem, warm gold, chunky pixels, no text.
```

**`icon_settings.png`**

```
Cozy pixel art gear icon 32x32 transparent background, brass/gold cog, chunky pixels, no text.
```

**`icon_sound_on.png`**

```
Cozy pixel art speaker icon 32x32 transparent background, gold-brass, sound on, chunky pixels, no text.
```

**`icon_sound_off.png`**

```
Cozy pixel art muted speaker icon 32x32 transparent background, gold-brass with a small X, chunky pixels, no text.
```

**`icon_lang.png`**

```
Cozy pixel art icon 32x32 transparent background, small globe or two letter-tiles but NO readable latin/cyrillic words, gold and navy, chunky pixels.
```

**`ui_button.png`**

```
Pixel art nine-slice friendly button, 96x32, dark iron with gold edge, cozy mine UI, empty, no text, chunky pixels.
```

---

### 2.6 Завал, комбо, достижения

| Файл | Зачем |
|---|---|
| `fx_dust.png` | Пыль |
| `fx_spark.png` | Искры удара |
| `fx_crack.png` | Трещина на экране/стене |
| `ui_danger_bar.png` | Подложка шкалы неустойчивости |
| `fx_falling_rock.png` | Камень падает при завале |
| `icon_ach_generic.png` | Рамка значка достижения |
| `icon_ach_fill.png` | Заполненный значок (золотой) |

**`fx_dust.png`**

```
Pixel art dust puff, 32x32, transparent background, warm grey-brown cloud, soft chunky pixels, for a mining hit, no text.
```

**`fx_spark.png`**

```
Pixel art spark star, 16x16, transparent background, bright gold-orange spark, chunky pixels, no text.
```

**`fx_crack.png`**

```
Pixel art jagged crack overlay, 64x64, transparent background, dark split with tiny gold glint, cave wall crack, chunky pixels, no text.
```

**`ui_danger_bar.png`**

```
Pixel art empty meter bar, 128x16, dark iron frame, cozy UI, hollow inside for a fill color, gold corners, no text.
```

**`fx_falling_rock.png`**

```
Pixel art falling boulder, 48x48, transparent background, dark rock with gold flecks, cozy not scary, chunky pixels, no text.
```

**`icon_ach_generic.png`**

```
Cozy pixel art achievement badge empty, 32x32, transparent background, iron medal frame, dark inside, chunky pixels, no text.
```

**`icon_ach_fill.png`**

```
Cozy pixel art achievement badge earned, 32x32, transparent background, gold medal with tiny pickaxe silhouette, chunky pixels, no letters.
```

---

### 2.7 Иконки приложения и бота

| Файл | Размер | Куда |
|---|---|---|
| `app_icon_512.png` | 512×512 | PWA, Telegram-бот |
| `app_icon_192.png` | 192×192 | PWA |

Фон непрозрачный (иконка магазина/бота).

**`app_icon_512.png`**

```
App icon, 512x512, no transparency, cozy pixel art.
The same dwarf miner head-and-shoulders: yellow helmet with lantern, auburn beard, orange scarf, smiling, on a dark charcoal mine background with a gold ore spark.
Simple, readable at small size, no text, no watermark.
```

**`app_icon_192.png`**

Тот же промпт, в конце: `192x192`. Можно уменьшить 512 вручную — лучше, чем разный персонаж.

---

### 2.8 Порядок сдачи артов

1. `miner_idle` + `app_icon_512` (стиль замокнут).
2. `miner_hit`, `miner_ko`, порода, четыре руды.
3. Текстуры стены/пола, лампа, вагонетка.
4. Иконки магазина и UI.
5. FX завала и достижения.

Кладёте файлы с **точными именами** из таблиц. Если размер не совпал — ок, подгоню при вставке.

### Готово (шаг 2)

Эталон шахтёра есть. Остальное может догонять шаги 3–5 по мере генерации.

---

## Шаг 3. Игровой удар

### Задачи

- Тап по спрайту шахтёра (большая hit-area).
- Анимация hit → idle.
- Спавн 1–2 кусков руды (пока можно только золото).
- Всплывающие цифры, искры, осколки, вспышка, лёгкая тряска камеры.
- Комбо-счётчик при быстрых тапах (ещё без завала).
- Звук удара после первого жеста (политика автозвука).

### Готово

Минуту тапать приятно на телефоне в браузере.

---

## Шаг 4. Магазин и несколько руд

### Задачи

- Четыре счётчика сверху с иконками.
- Дроп: уголь часто, железо реже, золото средне, кристалл редко; комбо чуть поднимает шанс золота/кристалла.
- Три кнопки магазина: уровень, цена, эффект. Покупка за золото.
- Автодобыча: тик раз в секунду, вагонетка слегка дёргается.
- Множитель: жила на стене ярче с уровнем.
- Кирка: сильнее цифры и чуть крупнее искры.
- Формат чисел 1.2K / 3.4M.

### Готово

За первую минуту покупается кирка 1, удар заметно сильнее.

---

## Шаг 5. Завал

### Задачи

- Шкала неустойчивости, цвет от золота к красному.
- Рост от комбо, спад в покое.
- При 100: камни сверху, пыль, сильная тряска, хаптик (когда будет Telegram), шахтёр `ko`, ввод тапа глушится 3–5 с.
- Руда в полёте пропадает (штраф), карман не трогаем.
- Короткий текст RU/EN «Завал!» / «Cave-in!».
- После вставания шкала с нуля.

### Готово

Завал понятен с первого раза, охота бить дальше, сейв не обнуляется.

---

## Шаг 6. Возвращение

### Задачи

- Сейв: уровни магазина, четыре ресурса, достижения, язык, звук, timestamp выхода.
- Старт: `localStorage`. Слой Telegram CloudStorage — на шаге 7.
- Офлайн-окно: «Пока вас не было: +золото» (и доля других руд от idle), потолок 8 ч.
- Настройки: звук, язык, сброс сейва с подтверждением.
- Достижения: список, тост при открытии.
- Все строки в `ru.json` / `en.json`.

### Готово

Перезагрузка страницы ничего не ест. Офлайн после паузы понятен.

---

## Шаг 7. Сок, ваши арты, звук

### Задачи

- Подмена заглушек на сданные PNG.
- Живой фон: пыль, мигание ламп, качание крепи, параллакс 2–3 слоя.
- Блики на золотой жиле и кристалле.
- Пульс кнопок, когда хватает золота.
- Музыка loop + слайдер/тоггл уже из настроек.
- Экран «Авторы», если у звука CC-BY.

### Готово

Сцена выглядит как одна игра, не набор заглушек.

---

## Шаг 8. Оболочка: PWA + Telegram

### Задачи

- Сборка на тестовый HTTPS (Vercel / Cloudflare Pages).
- `vite-plugin-pwa`: манифест MineShot, иконки 192/512.
- Бот `@mineshot…`: Menu Button, `/play`, Mini App URL = тот же хостинг.
- SDK: viewport expand, safe area, `HapticFeedback` на удар и завал.
- Сейв: чтение/запись CloudStorage, fallback localStorage.
- Звук по первому тапу в WebView.
- Проверка: Android Telegram, iOS Telegram, мобильный Chrome (PWA).

### Готово

Узкий круг открывает игру в Telegram без компьютера разработчика.

---

## Шаг 9. Обкатка = v1

### Задачи

- Ссылка кругу (5–15 человек).
- Смотреть: понятен ли тап, не злит ли завал, не слетает ли сейв, FPS на слабом телефоне, читаются ли цифры.
- Подкрутить `1.15` и порог завала, починить критичные баги.
- Зафиксировать: «это v1». Список багов не блокаторов — на потом.

### Готово

Несколько людей провели вечер, прогресс на месте, можно остановиться и не трогать магазины приложений.

---

## После v1 (не делать сейчас)

Android/iOS, свой домен, шаринг, Stars, реклама, вторая шахта, prestige, отдельный бэкенд.

---

## Зависимости (что от чего)

```
0 ТЗ
 └─ 1 каркас
     ├─ 2 арты (можно параллельно с 3, эталон шахтёра желательно рано)
     └─ 3 удар
         └─ 4 магазин + руды
             └─ 5 завал
                 └─ 6 сейв / офлайн / языки
                     └─ 7 полировка артом и звуком
                         └─ 8 PWA + Telegram
                             └─ 9 обкатка v1
```

Шаги 2 и 3 параллельны: удар на заглушках, арты подставляем как приходят.

---

## Кто что сдаёт

| Шаг | Вы | Я |
|---|---|---|
| 0 | Ок / правки ТЗ | Пишу ТЗ |
| 1 | Открыть на телефоне | Каркас |
| 2 | PNG по промптам | Звук, вставка, заглушки |
| 3–6 | Поиграть, сказать «мало сока / слишком злой завал» | Код и баланс |
| 7 | Досдать недостающие PNG | Собрать сцену |
| 8–9 | Дать ссылку кругу, свой Telegram | Бот, хостинг, фиксы |
