# Phase 1: Visual MVP — Technical Specification

Статус: согласовано к реализации.

Дата: 2026-07-16.

Связанные документы:

- [Product Brief](../01-product-brief.md)
- [Technical Specification](../02-technical-spec.md)
- [Architecture](../03-architecture.md)
- [Design System](../05-design-system.md)
- [Roadmap](../09-roadmap.md)
- [Visual reference](../image/1.jpg)

## 1. Цель фазы

Создать интерактивный визуальный MVP пользовательского приложения `Criminal Brushes` для Web, Android и iOS на локальных моковых данных.

Пользователь должен пройти демонстрационный guest flow:

```text
Главная → Каталог → Карточка товара → Корзина → Checkout → Подтверждение
```

Результат должен:

- демонстрировать бренд, продукт и путь покупки;
- одинаково корректно работать на mobile, tablet и desktop;
- быть пригодным для показа команде и партнерам;
- создавать архитектурную основу для замены моков на Supabase;
- не выполнять реальные сетевые, платежные или заказные операции.

## 2. Принятые решения

- Дизайн ведется code-first без Figma.
- `Docs/image/1.jpg` является визуальным ориентиром, а не готовым экраном или production-ассетом.
- UI реализуется нативными Flutter-компонентами; текст и кнопки не встраиваются в растровые изображения.
- Продуктовые и lifestyle-изображения создаются через ImageGen и сохраняются в проекте.
- Все данные фазы 1 локальные и детерминированные.
- Supabase может быть инициализирован конфигурацией приложения, но экраны фазы 1 не зависят от доступности API.
- Корзина живет в памяти приложения и очищается после перезапуска.
- Checkout имитирует оформление и не создает запись в базе.
- Авторизация, профиль и админка не входят в фазу 1.

## 3. Объем работ

### 3.1 Входит в фазу

- App shell и responsive-навигация.
- Маршруты Home, Catalog, Product, Cart, Checkout, Confirmation и UI Kit.
- Локальная предметная модель каталога, корзины и checkout.
- `MockProductRepository` и `MockDeliveryRepository`.
- Riverpod-состояние выбранных фильтров, корзины и checkout draft.
- Интерактивный выбор варианта товара.
- Добавление, удаление и изменение количества товаров.
- Локальный расчет subtotal, mock-доставки и total.
- Клиентская валидация checkout-формы.
- Responsive UI для трех диапазонов ширины.
- Loading, empty, error, disabled, out-of-stock и success состояния.
- Code-first UI kit на служебном маршруте.
- Локальные изображения и fallback-заглушки.
- Widget и unit tests критического демонстрационного пути.
- Release Web build и проверка Android debug build, если Android SDK доступен.

### 3.2 Не входит в фазу

- Чтение или запись каталога через Supabase.
- Supabase Auth, регистрация, magic link и роли.
- Личный кабинет, адресная книга, история заказов и wishlist.
- Постоянное хранение корзины.
- Настоящие отзывы и рейтинги.
- Backend-проверка промокодов.
- Реальный расчет доставки.
- Создание заказа в Postgres.
- Платежный SDK, Edge Functions и webhooks.
- Email, push, SMS, аналитика и Sentry.
- Административный интерфейс.
- Юридическая публикация маркетинговых заявлений.

## 4. Ключевые ограничения

- Не добавлять секреты и `service_role` key в клиент или Git.
- Не обращаться к Supabase из mock-репозиториев.
- Не помещать бизнес-правила непосредственно в widgets.
- Не копировать весь исходный landing в один растровый фон.
- Не использовать неподтвержденные медицинские и маркетинговые обещания как факты.
- Mock-рейтинг, отзывы, промокоды и остатки должны быть обозначены в коде как тестовые данные.
- Фаза не должна блокироваться отсутствием сети.

## 5. Пользовательский сценарий

### Основной happy path

1. Гость открывает Home.
2. Видит hero-продукт и CTA `Смотреть каталог` или `Выбрать цвет`.
3. Переходит в Catalog.
4. Открывает карточку `Tiny Trouble`.
5. Выбирает цвет.
6. Добавляет товар в Cart.
7. При необходимости меняет количество.
8. Переходит в Checkout.
9. Заполняет контакты и адрес.
10. Выбирает mock-метод доставки и mock-способ оплаты.
11. Подтверждает демонстрационный заказ.
12. Видит Confirmation с локально сгенерированным mock-номером.

### Альтернативные сценарии

- Открыть Product по прямому URL.
- Добавить товар в корзину из Catalog.
- Переключить вариант уже добавленного товара через Product.
- Открыть пустую Cart.
- Вернуться из Checkout в Cart без потери данных текущей сессии.
- Получить inline validation errors на незаполненной форме.
- Открыть неизвестный URL и увидеть branded not-found state.

## 6. Маршруты

Использовать `go_router`.

| Маршрут | Экран | Назначение |
|---|---|---|
| `/` | Home | Главная и hero drop |
| `/catalog` | Catalog | Каталог и фильтры |
| `/product/:slug` | Product details | Карточка товара |
| `/cart` | Cart | Локальная корзина |
| `/checkout` | Checkout | Mock-оформление |
| `/order/confirmation` | Confirmation | Успешный mock-заказ |
| `/ui-kit` | UI Kit | Компоненты и состояния |

Требования к маршрутизации:

- URL должен изменяться на Web.
- Back должен работать предсказуемо.
- Checkout без товаров перенаправляет в Cart с пустым состоянием.
- Confirmation без созданного в текущей сессии mock-заказа перенаправляет на Home.
- Неизвестный slug показывает product not-found, а не аварийное завершение.

## 7. Архитектура Flutter

Фаза 1 остается внутри `apps/customer_app`, но соблюдает feature-границы.

```text
lib/
  app/
    app.dart
    router.dart
    app_shell.dart
  core/
    config/
    extensions/
    theme/
    utils/
  shared/
    widgets/
    models/
  features/
    home/
      presentation/
    catalog/
      domain/
      data/
      application/
      presentation/
    product/
      presentation/
    cart/
      domain/
      application/
      presentation/
    checkout/
      domain/
      data/
      application/
      presentation/
    ui_kit/
      presentation/
```

Не создавать отдельные workspace packages в фазе 1. Выделение `design_system`, `domain` и `data` в packages допускается после стабилизации API компонентов.

## 8. Предметные модели

Модели должны быть immutable. Для текущего объема допустимы обычные Dart-классы с `const` constructors, equality и `copyWith`. `freezed` подключать только если ручной код начинает заметно дублироваться.

### Product

```text
id
slug
name
subtitle
description
collectionName
basePriceMinor
currency
variants
images
features
safetyNotes
isFeatured
mockRating
mockReviewCount
```

### ProductVariant

```text
id
sku
colorName
colorHex
priceMinor
stockQuantity
imageAsset
isActive
```

### ProductImage

```text
assetPath
altText
variantId optional
sortOrder
```

### ProductFeature

```text
icon
title
description
```

### CartItem

```text
product
variant
quantity
unitPriceMinor
lineTotalMinor derived
```

Уникальность позиции корзины определяется парой `product.id + variant.id`.

### DeliveryMethod

```text
id
name
description
priceMinor
estimatedDeliveryText
isActive
```

### CheckoutDraft

```text
customerName
email
phone
city
postalCode
addressLine1
addressLine2
deliveryMethodId
paymentMethod
comment
consentAccepted
```

### MockOrderConfirmation

```text
orderNumber
createdAt
items
totalMinor
deliverySummary
contactSummary
```

## 9. Репозитории и данные

### ProductRepository

```text
Future<List<Product>> getProducts()
Future<Product?> getBySlug(String slug)
Future<List<Product>> getFeaturedProducts()
```

### DeliveryRepository

```text
Future<List<DeliveryMethod>> getActiveMethods(int subtotalMinor)
```

### Mock-реализации

- Возвращают локальные константы.
- Допускают короткую искусственную задержку только для демонстрации loading state.
- Не используют Supabase client.
- Предоставляются через Riverpod providers.
- В тестах могут заменяться fake-реализациями.

Минимальный mock-каталог:

- один продукт `Tiny Trouble`;
- четыре варианта: Bubblegum Pink, Acid Lime, Stealth Black, Cool Blue;
- цена `599000` minor units;
- одна активная коллекция `Tiny Trouble Drop`;
- один вариант может использоваться в тестах как out of stock;
- рейтинги и отзывы маркируются в данных префиксом/comment как mock.

## 10. Управление состоянием

Использовать Riverpod.

### Обязательные providers/controllers

- `productRepositoryProvider`.
- `deliveryRepositoryProvider`.
- `productListProvider`.
- `productBySlugProvider`.
- `catalogFilterProvider`.
- `selectedVariantProvider` или локальный controller Product feature.
- `cartControllerProvider`.
- `cartTotalsProvider`.
- `checkoutControllerProvider`.
- `mockOrderConfirmationProvider`.

### CartController

Должен поддерживать:

- `add(product, variant, quantity)`;
- `remove(productId, variantId)`;
- `setQuantity(productId, variantId, quantity)`;
- `clear()`;
- объединение одинаковых product/variant;
- запрет количества меньше 1 и больше доступного mock-остатка;
- derived count для badge;
- derived subtotal без хранения дублируемого значения.

### CheckoutController

Должен поддерживать:

- обновление полей draft;
- выбор доставки и оплаты;
- validation;
- состояние `idle/submitting/success/failure`;
- создание локального mock confirmation;
- очистку корзины только после успешного mock submit.

## 11. Design system в коде

Источником истины являются `Docs/05-design-system.md` и `lib/core/theme`.

### Токены

- Цвета из утвержденной палитры.
- Spacing: `4, 8, 16, 24, 32, 48, 64`.
- Breakpoints: mobile `<600`, tablet `600–1023`, desktop `>=1024`.
- Минимальный tap target: `44x44`, предпочтительно `48x48`.
- Максимальная ширина основного desktop-контейнера: `1280`.
- Ширина читаемого текстового блока: не более `680`.

### Типографика

- Выбрать бесплатные шрифты с лицензией OFL или аналогичной коммерческой лицензией.
- Display: сжатый жирный шрифт для hero и секционных заголовков.
- UI/body: нейтральный sans-serif с кириллицей.
- До утверждения внешних font assets использовать системный fallback без блокировки разработки.
- Brush-lettering использовать как изображение только в декоративных коротких акцентах.
- Формы, цены, доставка, безопасность и юридический текст используют UI/body font.

### UI Kit route

Маршрут `/ui-kit` должен показывать:

- palette и typography;
- spacing samples;
- primary/secondary/text/icon buttons;
- badges;
- product card;
- price block;
- rating;
- color swatches;
- quantity stepper;
- cart row;
- text fields и selectors;
- checkout stepper;
- loading/empty/error/success;
- snackbar и modal trigger;
- enabled, pressed, focused, disabled и error состояния, где применимо.

## 12. Общие компоненты

### AppHeader

- Desktop: logo, Catalog, About placeholder anchor, Delivery placeholder anchor, FAQ placeholder anchor, Cart.
- Mobile: logo, cart icon, menu button; пункты раскрываются в drawer или sheet.
- Cart badge показывает суммарное количество единиц.
- Header имеет достаточный контраст и видимый keyboard focus.

### AppFooter

- Брендовый блок.
- Навигационные placeholder-ссылки.
- Контактные и юридические placeholder-ссылки с пометкой, что страницы будут добавлены позднее.
- На mobile колонки переходят в вертикальный layout.

### ProductCard

- Изображение, badge, название, цвет, цена и CTA.
- Вся карточка открывает Product; CTA выполняет quick add только при однозначном variant.
- Для нескольких вариантов CTA ведет к выбору товара или использует явно выбранный цвет.
- Out-of-stock состояние запрещает добавление.

### ColorSwatchSelector

- Не полагается только на цвет: отображает доступное имя/semantics.
- Selected state видим контуром и иконкой.
- Disabled/out-of-stock state различим.
- Управляется с клавиатуры на Web.

### PriceBlock

- Форматирует minor units через `intl`.
- Валюта для моков — RUB.
- Не хранит строку цены внутри модели.

### QuantityStepper

- Кнопки `−` и `+`, числовое значение, semantics labels.
- Минимум 1, максимум mock stock.
- Disabled state на границах.

### AsyncStateView

- Унифицированно отображает loading, data, empty и error.
- Error содержит понятный текст и кнопку повтора.

## 13. Спецификация экранов

### 13.1 Home

Секции сверху вниз:

1. Header.
2. Hero `Tiny Trouble Drop`.
3. Блок преимуществ.
4. Коллекция/featured products.
5. Доверительный блок для родителей.
6. Lifestyle/promo banner.
7. FAQ.
8. Footer.

Hero содержит:

- drop badge;
- `Brush like a rebel`;
- спокойное пояснение продукта;
- hero product image;
- цену;
- selector цвета или CTA к Product;
- основной CTA;
- сведения о доставке/гарантии без неподтвержденных обещаний.

Drop timer не включать по умолчанию. Он допускается только как явно обозначенная демонстрационная механика после утверждения даты и поведения при истечении.

### 13.2 Catalog

Содержит:

- заголовок и описание коллекции;
- число результатов;
- фильтры collection/color/in stock;
- сортировку popularity/newest/price;
- responsive product grid;
- reset filters;
- empty state.

Для одного mock-продукта фильтры остаются демонстрационными, но должны реально менять локальную выдачу.

Responsive grid:

- mobile: 1–2 колонки в зависимости от фактической читаемости;
- tablet: 2–3;
- desktop: 4.

### 13.3 Product details

Содержит:

- breadcrumbs на desktop;
- галерею;
- collection badge;
- название и subtitle выбранного variant;
- mock-rating с пометкой в данных;
- цену;
- ColorSwatchSelector;
- stock status;
- CTA add to cart;
- характеристики;
- безопасность и возрастные рекомендации;
- доставка и гарантия;
- mock reviews preview только если это не выглядит как реальные опубликованные отзывы.

При смене variant обновляются изображение, subtitle, SKU, цена и stock status.

### 13.4 Cart

Содержит:

- список CartItemRow;
- QuantityStepper;
- remove action;
- promo input с демонстрационным ответом;
- subtotal;
- mock delivery estimate;
- total;
- CTA Checkout;
- continue shopping.

Пустое состояние содержит CTA в Catalog.

Промокод не должен имитировать реальную серверную проверку. Допустим один тестовый код `REBEL10`, явно находящийся в mock data.

### 13.5 Checkout

Секции:

1. Контакты.
2. Адрес.
3. Доставка.
4. Оплата.
5. Summary и согласие.

Поля:

- имя;
- email;
- телефон;
- город;
- индекс optional;
- адрес;
- квартира/комментарий optional;
- метод доставки;
- mock payment method;
- checkbox согласия.

В фазе 1 не собирать и не отображать поля банковской карты.

Mobile может использовать последовательные визуальные секции на одной странице или stepper без потери введенных значений. Desktop использует форму слева и sticky summary справа.

Validation:

- ошибки появляются после blur или submit;
- фокус переводится к первой ошибке после submit;
- email и телефон проверяются только на разумный клиентский формат;
- CTA disabled во время mock submit;
- mock submit занимает короткое предсказуемое время и завершается success.

### 13.6 Confirmation

Содержит:

- success state;
- mock order number с префиксом `DEMO-`;
- summary товаров и суммы;
- контакт/доставка без излишнего повторения персональных данных;
- явную подпись `Демонстрационный заказ — данные не отправлены`;
- CTA на Home и Catalog.

### 13.7 Not found

- Branded empty/error visual.
- Понятный текст без технических деталей.
- CTA на Home и Catalog.

## 14. Responsive-поведение

| Область | Mobile `<600` | Tablet `600–1023` | Desktop `>=1024` |
|---|---|---|---|
| Header | compact + menu | compact/partial nav | full nav |
| Hero | одна колонка | одна или две по ширине | две колонки |
| Catalog | 1–2 колонки | 2–3 колонки | 4 колонки |
| Product | gallery над info | адаптивные блоки | gallery + sticky info |
| Cart | items и summary подряд | широкая колонка | items + sticky summary |
| Checkout | последовательные секции | широкая форма | form + sticky summary |
| Footer | вертикально | 2 колонки | 4 колонки |

Обязательные контрольные ширины: `360`, `390`, `600`, `768`, `1024`, `1280`, `1440`.

Не допускать horizontal overflow, обрезания CTA и текста меньше читаемого размера.

## 15. ImageGen и ассеты

### 15.1 Роль исходного изображения

`Docs/image/1.jpg` используется как reference для:

- контрастной композиции;
- цветового ритма;
- fashion/drop настроения;
- баланса продуктовой фотографии и brush-графики.

Не использовать его как фон страницы, source of truth для текста или точную спецификацию геометрии продукта.

### 15.2 Минимальный asset set

```text
assets/images/products/tiny-trouble-pink.webp
assets/images/products/tiny-trouble-lime.webp
assets/images/products/tiny-trouble-black.webp
assets/images/products/tiny-trouble-blue.webp
assets/images/hero/hero-product-pink.webp
assets/images/lifestyle/lifestyle-rebel.webp
assets/images/textures/promo-brush-texture.webp
assets/images/social/og-home.webp
```

### 15.3 Правила генерации

- Сначала создать 3 hero-концепции и выбрать одну до массовой генерации.
- Зафиксировать выбранную геометрию товара как reference для всех цветов.
- Сохранять форму корпуса, кнопку, насадку, пропорции и положение логотипа.
- Генерировать без цен, рейтинга, CTA и длинного текста внутри изображения.
- Не добавлять watermark и сторонние бренды.
- Для lifestyle не создавать впечатление медицинской сертификации или endorsement специалистом.
- Для изображений детей избегать опасных сцен и взрослых fashion-кодов.
- Каждый asset имеет понятное имя, alt/semantics и документированный prompt.
- Выбранные файлы копируются в workspace; временные варианты не подключаются к приложению.
- Перед подключением изображения оптимизируются; ориентир для большинства UI assets — WebP и разумный размер файла.

### 15.4 Логотип и иконки

- Не считать ImageGen окончательным источником логотипа.
- До появления утвержденного vector logo использовать существующий текстовый wordmark или аккуратный placeholder.
- UI-иконки брать из единого Flutter icon set или SVG-системы, не генерировать растрами.

## 16. Контент

Контент разделить на:

- брендовый;
- продуктовый;
- доверительный;
- транзакционный.

Правила:

- Брендовый текст может быть дерзким и коротким.
- Checkout, доставка, безопасность и ошибки используют спокойный тон.
- Не писать о сертификации, гарантии, сроке батареи, водозащите или медицинской пользе как о подтвержденных фактах без владельца контента.
- Неподтвержденные значения хранить в mock data с TODO-owner.
- Использовать `ё` последовательно в пользовательских текстах после выбора редакционного правила.
- Не хардкодить один и тот же пользовательский текст в нескольких widgets.

## 17. Доступность

- Контраст текста и интерактивных элементов должен соответствовать минимум WCAG AA, где применимо.
- Цвет не является единственным способом передачи состояния.
- Все изображения имеют semantic label или исключаются из semantics как декоративные.
- Интерактивные элементы имеют tooltip/label.
- Keyboard focus видим на Web.
- Tab order соответствует визуальному порядку.
- Формы связывают ошибки с полями.
- Touch targets не меньше `44x44`.
- Text scaling проверяется минимум до `1.3` без критического overflow.
- Анимации не являются обязательными для понимания состояния.

## 18. Производительность

- Не загружать полноразмерные изображения там, где достаточно thumbnail.
- Использовать `const` widgets где разумно.
- Не выполнять тяжелую обработку изображений в UI isolate.
- Не добавлять autoplay video в фазе 1.
- Не блокировать первый экран ожиданием mock delay.
- Web release build должен собираться без ошибок.
- Цель Lighthouse 80+ остается целевой для MVP, но формальный performance pass выполняется в фазе 6.

## 19. Тестирование

### Unit tests

- форматирование цены из minor units;
- добавление одинакового variant объединяет позиции;
- разные variants создают разные позиции;
- quantity соблюдает границы;
- subtotal и total рассчитываются корректно;
- mock promo применяется предсказуемо;
- checkout validation определяет обязательные поля.

### Widget tests

- Home отображает hero и CTA;
- Catalog показывает mock products;
- выбор swatch меняет выбранный variant;
- add to cart обновляет badge;
- Cart изменяет quantity и total;
- empty Cart показывает CTA;
- Checkout показывает validation errors;
- успешный mock submit открывает Confirmation;
- mobile width не вызывает overflow на ключевых экранах.

### Router tests

- известные маршруты открываются;
- неизвестный slug показывает not-found;
- Checkout с пустой Cart защищен;
- Confirmation без mock order защищен.

### Ручная проверка

- Edge/Chrome Web.
- Android emulator или устройство, если доступно.
- Контрольные ширины responsive.
- Mouse, keyboard и touch interactions.
- Hot restart и прямое открытие product URL.

### Обязательные команды

```bash
cd apps/customer_app
dart format --output=none --set-exit-if-changed .
fvm flutter analyze
fvm flutter test
fvm flutter build web --release
```

## 20. Порядок реализации

### Milestone 1 — Foundation

- Утвердить контентные placeholders и mock claims.
- Создать модели и mock repositories.
- Расширить tokens и theme.
- Создать AppShell и маршруты.
- Создать `/ui-kit`.

Gate: UI kit доступен на mobile/desktop, модели покрыты базовыми tests.

Implementation note 2026-07-22:

- Foundation gate implemented in `feature/phase1-foundation-student`.
- `/ui-kit` covers palette, typography, spacing, buttons, badges, product card, price block, rating, color swatches, quantity stepper, cart row, selectors, checkout stepper, loading/empty/error/success, snackbar and modal trigger.
- Router guards are covered for unknown product slug, empty checkout and missing mock confirmation.
- Verification commands used for this gate:

```powershell
cd apps/customer_app
fvm flutter analyze --no-pub
fvm flutter test --no-pub --reporter expanded
```

`--no-pub` is intentional after dependencies are already resolved: the local network can be unstable when Flutter tries to refresh package metadata from `pub.dev`.

### Milestone 2 — Browse

- Home.
- Catalog.
- Product details.
- Первые утвержденные product assets.

Gate: пользователь проходит Home → Catalog → Product и выбирает variant.

### Milestone 3 — Cart

- CartController.
- Cart badge.
- Add/remove/quantity.
- Totals и mock promo.

Gate: корзина корректно работает для нескольких variants.

### Milestone 4 — Checkout

- CheckoutDraft и controller.
- Form validation.
- Delivery/payment mocks.
- Confirmation.

Gate: полный happy path проходит без API.

### Milestone 5 — Polish and QA

- Все состояния.
- Responsive pass.
- Accessibility pass.
- Widget/router tests.
- Web release build.
- Скриншоты для согласования.

Gate: выполнены критерии приемки и CI зеленый.

## 21. Рекомендуемое разделение работы

Работа выполняется через отдельные короткие feature-ветки и PR.

Возможное распределение:

- Ведущий: архитектура, router, models, Riverpod controllers, review и integration.
- Студент: UI kit components, отдельные секции Home/Catalog, widget tests и responsive fixes.
- Совместно: Product/Cart/Checkout integration, визуальное согласование и QA.

Не назначать двум разработчикам одновременное редактирование одних и тех же крупных файлов. Общие tokens и component APIs согласовывать до параллельной сборки экранов.

Рекомендуемые ветки:

```text
feature/phase1-foundation
feature/phase1-ui-kit
feature/phase1-home-catalog
feature/phase1-product
feature/phase1-cart
feature/phase1-checkout
feature/phase1-visual-qa
```

## 22. Критерии приемки

Фаза 1 принимается, когда одновременно выполнены условия:

- Все семь маршрутов доступны и не завершаются ошибкой.
- Guest flow Home → Confirmation проходится без Supabase и сети.
- В Catalog/Product доступны четыре цветовых варианта.
- Выбранный variant корректно попадает в Cart.
- Cart поддерживает add, remove и quantity.
- Итоги рассчитываются из minor units без `double`.
- Checkout валидирует обязательные поля.
- Confirmation явно сообщает, что заказ демонстрационный.
- UI корректен на контрольных ширинах.
- Нет известных RenderFlex overflow на ключевых экранах.
- Компоненты имеют loading/empty/error/disabled состояния, где это применимо.
- Основные элементы доступны с клавиатуры и имеют semantics.
- Production-подобные изображения находятся в workspace, оптимизированы и имеют alt descriptions.
- В интерфейсе нет реальных секретов и неподтвержденных обещаний, представленных как факты.
- `dart format`, `flutter analyze`, `flutter test` и `flutter build web --release` проходят.
- CI на PR зеленый.
- Документация отражает реализованные отклонения от данного ТЗ.

## 23. Definition of Done для отдельной задачи

Задача считается завершенной, если:

- реализация соответствует спецификации;
- mobile и desktop состояния проверены;
- отсутствуют новые analyzer warnings;
- добавлены или обновлены релевантные tests;
- строки и значения не дублируются без необходимости;
- состояния ошибок не раскрывают технические детали пользователю;
- PR имеет описание, screenshots для UI-изменений и шаги проверки;
- изменения не содержат секретов, build artifacts и случайных generated files;
- reviewer подтвердил визуальное и функциональное поведение.

## 24. Открытые контентные решения

Эти вопросы не блокируют foundation, но должны быть закрыты до финального polish:

- Утвержденная геометрия и внешний вид реального продукта.
- Финальный логотип и права на его использование.
- Бесплатные display/body fonts с поддержкой кириллицы.
- Подтвержденные характеристики продукта.
- Возрастная рекомендация.
- Условия гарантии и доставки.
- Можно ли публично показывать цену `5 990 ₽`.
- Допустимы ли mock rating/reviews в демонстрации.
- Нужен ли drop timer и каково его реальное правило.
- Юридические названия ссылок и контактные данные.

Временные решения должны иметь явный `TODO(content)` и не восприниматься как утвержденные production-данные.
