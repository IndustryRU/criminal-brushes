# Design System

## Визуальная база

Источник направления: текущий landing-концепт `Criminal Brushes`.

Ключевые свойства:

- Черно-белая контрастная основа.
- Acid lime и bubblegum pink как ударные акценты.
- Brush-текстуры, грубые мазки, стикеры, drop-эстетика.
- Крупная сжатая типографика.
- Fashion/streetwear подача.
- Чистые продуктовые фото на контрасте с дерзкой графикой.

## Баланс бренда

Так как продукт детский, визуальную дерзость нужно балансировать:

- Блоками безопасности.
- Мягкими microcopy для родителей.
- Понятными характеристиками.
- Гарантией.
- Информацией о материалах.
- Возрастными рекомендациями.

## Цвета

Рабочие токены:

```text
black: #050505
white: #F8F8F4
pink: #FF5AAE
acid_lime: #D7FF22
electric_blue: #BFE9FF
ink_gray: #202020
muted_gray: #7A7A7A
danger: #FF3B30
success: #31C754
```

Не превращать интерфейс в однотонную кислотную плашку. Акценты должны работать как энергия бренда, а не мешать покупке.

## Типографика

Нужно подобрать web/mobile-safe шрифты с лицензией:

- Display font для hero и заголовков.
- Readable sans для интерфейса.
- Handwritten/brush font только для декоративных акцентов.

Правила:

- Hero может быть громким.
- Product details, checkout и личный кабинет должны быть читаемыми.
- Не использовать декоративный шрифт в цене, форме, юридических текстах и checkout.

## Компоненты

MVP UI kit:

- Button primary.
- Button secondary.
- Icon button.
- Product card.
- Product gallery.
- Color swatch selector.
- Rating.
- Price block.
- Badge.
- Cart item row.
- Quantity stepper.
- Checkout stepper.
- Text field.
- Select/dropdown.
- Promo code input.
- Empty state.
- Error state.
- Loading skeleton.
- Toast/snackbar.
- Modal/bottom sheet.
- Admin table.

## Responsive

Breakpoints:

```text
mobile: 0-599
tablet: 600-1023
desktop: 1024+
```

Правила:

- Первый экран должен показывать продукт, оффер и путь к покупке.
- На mobile CTA должен быть доступен без поиска.
- Checkout на mobile должен быть пошаговым.
- На desktop можно использовать двухколоночный product detail и checkout summary.

## Контентный тон

Бренд может говорить дерзко:

- "Brush like a rebel"
- "Чистить зубы не скучно"
- "Tiny Trouble Drop"

Но в checkout, доставке и юридических местах тон должен быть спокойным и точным.

## Ассеты

Нужны:

- Логотип в светлой и темной версии.
- App icon.
- Splash screen.
- Product images для каждого цвета.
- Lifestyle images.
- Store screenshots.
- Open Graph image для web.

Для маркетплейсов заранее подготовить отдельные скриншоты без спорных формулировок и с понятной демонстрацией функций.
