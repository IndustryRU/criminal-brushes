# Supabase Setup

Памятка для создания Supabase-проекта `Criminal Brushes` и применения начальной схемы базы данных.

## 1. Что выбрать на экране создания проекта

На текущем экране Supabase нужно заполнить:

```text
Organization: WinePool Org или нужная рабочая организация
Project name: criminal-brushes-dev
Database password: сгенерировать сильный пароль и сохранить в password manager
Region: Europe
```

Важно: не использовать в названии проекта имена переменных или секретов вроде:

```text
YANDEX_GEOCODER_API_KEY
```

Название проекта видно в интерфейсе и команде. Оно должно быть обычным названием окружения.

## 2. Рекомендуемые галочки Security

На экране создания проекта:

```text
Enable Data API: включить
Automatically expose new tables: выключить, если Supabase позволяет
Enable automatic RLS: включить
```

Пояснение:

- `Enable Data API` нужен Flutter-клиенту и Supabase SDK.
- `Automatically expose new tables` лучше выключить, чтобы новые таблицы не открывались случайно.
- `Enable automatic RLS` лучше включить, потому что e-commerce хранит профили, адреса, заказы и платежные статусы.

Если UI не дает выключить auto expose на free-плане или в текущем режиме, это не катастрофа: наша миграция явно включает RLS на всех таблицах.

## 3. Окружения

Минимально создать:

```text
criminal-brushes-dev
```

Позже добавить:

```text
criminal-brushes-staging
criminal-brushes-prod
```

Не смешивать тестовые и реальные заказы в одном production-проекте.

## 4. После создания проекта

В Supabase Dashboard открыть:

```text
Project Settings -> API
```

Сохранить для Flutter:

```text
Project URL
anon public key
```

Не вставлять в клиент:

```text
service_role key
database password
JWT secret
webhook secrets
payment secret keys
```

## 5. Локальная привязка Supabase CLI

В корне репозитория:

```powershell
supabase login
supabase link --project-ref <project-ref>
```

`project-ref` можно взять из URL проекта Supabase или в настройках проекта.

Проверить:

```powershell
supabase status
```

Если локальный Supabase еще не используется, `supabase status` может требовать Docker. Для cloud migrations достаточно `supabase link` и `supabase db push`.

## 6. Применить начальную схему

Начальная миграция лежит здесь:

```text
supabase/migrations/20260707090000_initial_schema.sql
```

После `supabase link` выполнить:

```powershell
supabase db push
```

CLI покажет список миграций и попросит подтверждение.

## 7. Что создаст миграция

Таблицы:

- `profiles`
- `collections`
- `products`
- `product_images`
- `product_variants`
- `shipping_addresses`
- `delivery_methods`
- `promo_codes`
- `orders`
- `order_items`
- `payments`
- `reviews`
- `wishlist_items`
- `content_blocks`
- `inventory_movements`
- `admin_audit_logs`

Также создаются:

- индексы;
- `updated_at` triggers;
- profile trigger для новых пользователей;
- RLS на всех таблицах;
- базовые RLS policies;
- seed-данные для первого товара `Tiny Trouble`.

## 8. Проверка в Supabase Dashboard

После миграции открыть:

```text
Table Editor
```

Проверить, что есть таблицы:

```text
products
product_variants
collections
delivery_methods
content_blocks
```

Проверить, что в `products` есть товар:

```text
Tiny Trouble
```

Проверить RLS:

```text
Authentication -> Policies
```

На всех пользовательских таблицах RLS должен быть включен.

## 9. Что делать с паролем базы

Сохранить database password в password manager команды.

Не хранить пароль:

- в Git;
- в `.env`;
- в Telegram;
- в скриншотах;
- в документации.

## 10. Что дать студенту

Студенту для разработки обычно нужны:

- доступ к GitHub repository;
- Supabase project access с ролью developer;
- `SUPABASE_URL`;
- `SUPABASE_ANON_KEY`;
- инструкции из `Docs/11-new-developer-onboarding.md`.

Студенту не нужен:

- service role key;
- database password;
- payment secret key.

## 11. Когда понадобится service role key

Только для server-side задач:

- Edge Functions;
- payment webhooks;
- admin backend jobs;
- CI/CD migrations при аккуратной настройке.

Service role key никогда не попадает во Flutter-приложение.

## 12. Следующий шаг после БД

После создания Supabase project и применения миграции:

1. Создать `.env.example`.
2. Позже создать Flutter skeleton.
3. Подключить `supabase_flutter`.
4. Считать `collections/products/product_variants`.
5. Сделать первый экран каталога на реальных данных.
