# Roadmap

## Phase 0: Project Setup

Оценка: 3-5 дней.

Статус на 2026-07-14: техническая часть завершена, внешний Figma/UI kit ожидает ссылку и подтверждение команды.

Цель: подготовить основу для командной разработки.

Задачи:

- [x] Создать Git repository.
- [x] Настроить `Docs`.
- [x] Создать Flutter app.
- [x] Подключить FVM.
- [x] Настроить базовый lint/analyze.
- [x] Создать Supabase dev project.
- [x] Настроить Supabase CLI.
- [x] Создать `.env.example`.
- [x] Добавить CI.
- [x] Зафиксировать Git flow.
- [ ] Подготовить Figma/UI kit draft и добавить ссылку в `05-design-system.md`.

Результат:

- Команда может работать через PR.
- Приложение запускается локально.
- Есть базовая документация.

Технический gate фазы 0:

```bash
cd apps/customer_app
fvm flutter pub get
dart format --output=none --set-exit-if-changed .
fvm flutter analyze
fvm flutter test
fvm flutter build web --release
```

## Phase 1: Visual MVP

Оценка: 1-2 недели.

Цель: собрать первую версию пользовательского web/mobile интерфейса на моковых данных.

Задачи:

- Home screen.
- Catalog screen.
- Product details.
- Cart UI.
- Checkout UI.
- Responsive layout.
- Design tokens.
- Базовые компоненты.

Результат:

- Продукт можно показать команде/партнерам.
- Видно, как бренд работает в приложении.

## Phase 2: Supabase Core

Оценка: 1-2 недели.

Цель: заменить моки реальными данными.

Задачи:

- Миграции Supabase.
- Таблицы каталога.
- Таблицы заказов.
- Auth.
- Profiles.
- RLS policies.
- Storage buckets.
- Seed data.
- Product repository.

Результат:

- Каталог загружается из Supabase.
- Пользователь может авторизоваться.

## Phase 3: Cart And Checkout

Оценка: 1-2 недели.

Цель: довести путь покупки до создания заказа.

Задачи:

- Cart state.
- Cart persistence.
- Checkout forms.
- Address management.
- Delivery methods.
- Order creation.
- Order confirmation.
- Email notification draft.

Результат:

- Пользователь может создать заказ без реальной оплаты или с тестовой оплатой.

## Phase 4: Payments

Оценка: 1-2 недели.

Цель: подключить платежный провайдер.

Задачи:

- Выбрать провайдера.
- Создать Edge Function `create-payment`.
- Создать webhook обработчик.
- Обновлять payment/order statuses.
- Обработать success/failure screens.
- Добавить тесты webhook.

Результат:

- Тестовый платеж проходит полный цикл.

## Phase 5: Admin

Оценка: 1-2 недели.

Цель: дать команде управление контентом и заказами.

Задачи:

- Admin auth guard.
- Products CRUD.
- Variants CRUD.
- Image upload.
- Orders list.
- Order detail.
- Status update.
- Promo codes.
- Content blocks.
- Audit log.

Результат:

- Каталог и заказы управляются без прямого доступа к базе.

## Phase 6: QA And Stabilization

Оценка: 1-2 недели.

Цель: подготовить MVP к публичному запуску.

Задачи:

- Smoke tests.
- Widget tests для критичных компонентов.
- Repository tests.
- Payment webhook tests.
- Sentry.
- Analytics.
- Performance pass.
- Accessibility pass.
- Legal pages.
- Store assets.

Результат:

- MVP готов к soft launch.

## Phase 7: Release

Оценка: 1 неделя.

Цель: опубликовать web и подготовить store submissions.

Задачи:

- Production Supabase.
- Production domain.
- Web deploy.
- Android release build.
- RuStore submission.
- Google Play internal testing.
- iOS TestFlight.
- Store review fixes.

Результат:

- Web доступен пользователям.
- Mobile builds проходят проверку магазинов.

## Post-MVP Backlog

- Subscription for replacement brush heads.
- Loyalty program.
- Referral program.
- Advanced promo campaigns.
- Product bundles.
- Reviews with photos.
- Delivery provider integrations.
- CRM integration.
- Customer support chat.
- Push marketing segmentation.
- A/B testing.
- Kids habit tracker.
