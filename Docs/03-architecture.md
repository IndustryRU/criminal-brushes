# Architecture

## Архитектурный подход

Проект строится как Flutter-приложение с Supabase backend. Бизнес-логика разделяется по слоям, чтобы команда могла работать параллельно и не превращать UI в место хранения правил.

Рекомендуемый state management: `Riverpod`.

Рекомендуемая навигация: `go_router`.

Рекомендуемые модели: `freezed` + `json_serializable`.

## Структура репозитория

На старте:

```text
criminal-brushes/
  apps/
    customer_app/
  packages/
    design_system/
    domain/
    data/
  supabase/
    migrations/
    functions/
    seed.sql
  Docs/
  .github/
    workflows/
```

Если команда хочет двигаться быстрее, можно временно начать с одного Flutter-приложения:

```text
lib/
  app/
  core/
  features/
  shared/
```

Но даже в этом случае архитектурные границы нужно сохранить.

## Flutter слои

```text
presentation
application
domain
data
infrastructure
```

### presentation

- Screens.
- Widgets.
- UI state.
- Form state.
- Responsive layout.

### application

- Use cases.
- Controllers/providers.
- Coordination between repositories.

### domain

- Entities.
- Value objects.
- Business rules.
- Repository interfaces.

### data

- DTO.
- Supabase queries.
- Repository implementations.

### infrastructure

- Supabase client setup.
- Analytics.
- Crash reporting.
- Push notifications.
- Payments SDK adapters.

## Feature modules

```text
features/
  auth/
  home/
  catalog/
  product/
  cart/
  checkout/
  orders/
  profile/
  admin/
  notifications/
```

Каждый feature содержит:

```text
feature_name/
  presentation/
  application/
  domain/
  data/
```

## Supabase

Используем:

- Postgres.
- Auth.
- Storage.
- Edge Functions.
- Realtime точечно.
- Row Level Security.

Не используем Supabase как "просто публичную базу". Все чувствительные операции закрываются RLS и Edge Functions.

## Edge Functions

Минимальные функции:

- `create-payment`
- `payment-webhook`
- `calculate-delivery`
- `admin-update-order-status`
- `send-order-notification`
- `sync-inventory`

## Storage

Buckets:

- `product-images`
- `content-images`
- `review-images` опционально

Правила:

- Public read для опубликованных product/content images.
- Upload только admin/manager.
- Имена файлов не должны содержать персональные данные.

## Environments

```text
development
staging
production
```

Для каждого окружения:

- Отдельный Supabase project или минимум отдельная схема/набор переменных.
- Отдельные ключи платежей.
- Отдельные analytics projects.
- Отдельные bundle/package IDs.

## Package IDs

Пример:

```text
ru.criminalbrushes.app.dev
ru.criminalbrushes.app.staging
ru.criminalbrushes.app
```

Финальный package ID утвердить до публикации, потому что его сложно менять после релиза.

## Конфигурация приложения

Использовать flavor-based конфигурацию:

- `dev`
- `staging`
- `prod`

Минимальные переменные:

```text
SUPABASE_URL
SUPABASE_ANON_KEY
APP_ENV
SENTRY_DSN
ANALYTICS_ENABLED
PAYMENT_PUBLIC_KEY
```

Service role key хранится только в Supabase/CI secrets и не попадает в Flutter app.

## Архитектура Phase 1

В фазе 1 используется code-first Visual MVP внутри `apps/customer_app`:

- UI получает данные через repository interfaces.
- `MockProductRepository` и `MockDeliveryRepository` работают без сети.
- Riverpod хранит состояние фильтров, выбранного варианта, корзины и checkout draft.
- Supabase-реализации репозиториев подключаются в следующих фазах без изменения presentation API.
- Корзина и mock-заказ живут только в памяти приложения.
- Отдельные workspace packages пока не создаются; границы соблюдаются внутри `lib/features`.

Подробная структура, модели и providers определены в [Phase 1 specification](phases/01-visual-mvp-spec.md).
