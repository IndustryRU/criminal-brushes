# Team Workflow

## Команда

Рекомендуемое распределение для 3 человек:

### Frontend Lead

- Flutter UI.
- Навигация.
- Design system.
- Интеграция экранов.
- Адаптивность web/mobile.

### Backend/Infra Lead

- Supabase schema.
- RLS.
- Edge Functions.
- Payments.
- CI/CD.
- Monitoring.

### Product/QA/Fullstack

- ТЗ и backlog.
- Тест-кейсы.
- Админка.
- Контент.
- Store assets.
- Release coordination.

Роли могут пересекаться, но зона ответственности должна быть явной.

## Инструменты

- GitHub или GitLab для кода.
- GitHub Projects, Linear или YouTrack для задач.
- Figma для дизайна.
- Supabase Dashboard + Supabase CLI.
- Telegram/Slack для коммуникации.
- Notion можно использовать для бизнеса, но техническая документация остается в `Docs`.

## Branching

Ветки:

```text
main
develop
feature/*
bugfix/*
release/*
hotfix/*
```

Правила:

- `main` содержит только production-ready код.
- `develop` содержит интеграционную версию.
- Новая задача делается в отдельной ветке.
- Все изменения проходят Pull Request.
- Минимум 1 review перед merge.
- В `main` напрямую не пушим.

## Naming

Примеры:

```text
feature/catalog-screen
feature/supabase-auth
feature/cart-checkout
bugfix/payment-webhook-status
hotfix/app-crash-on-start
```

## Commits

Использовать Conventional Commits:

```text
feat: add product gallery
fix: handle empty cart state
docs: add release checklist
chore: configure flutter analyze
test: add cart repository tests
```

## Pull Request checklist

Перед review автор проверяет:

- Задача описана.
- Есть скриншоты для UI-изменений.
- `flutter analyze` проходит.
- Тесты проходят.
- Нет секретов в diff.
- Обновлена документация, если изменилось поведение.
- Проверены loading/error/empty states.

## Code Review

Reviewer смотрит:

- Соответствие задаче.
- Читаемость.
- Разделение слоев.
- Ошибки состояния.
- Безопасность RLS/API.
- Влияние на релиз.
- Нужны ли тесты.

## Definition of Done

Фича готова, когда:

- Реализована основная логика.
- Есть обработка ошибок.
- Есть адаптация под целевые экраны.
- Есть минимальные тесты или осознанное решение их не добавлять.
- Пройдены CI checks.
- PR принят.
- Задача переведена в Done.

## Ритм работы

Рекомендуемый недельный цикл:

- Понедельник: planning на 30-45 минут.
- Каждый день: короткий async status.
- Среда/четверг: integration check.
- Пятница: demo/review и план следующего спринта.

Для команды из 3 человек лучше избегать тяжелых церемоний, но держать дисциплину по PR и документации.
