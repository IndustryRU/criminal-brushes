# Cloud Supabase Workflow

Памятка по текущему backend-процессу проекта `Criminal Brushes`.

## 1. Текущее решение

Мы работаем без локального Docker/Supabase stack и подключаем Flutter-приложение напрямую к облачному Supabase-проекту:

```text
Flutter app -> Supabase API -> cloud Supabase database
```

Это нормальный рабочий режим для учебного проекта и раннего MVP.

## 2. Что Docker дает, но сейчас не обязателен

Docker нужен для:

- `supabase start`;
- локальной копии Supabase;
- локального `supabase db reset`;
- локального тестирования Edge Functions;
- локальной проверки миграций до cloud.

Без Docker мы не используем local Supabase. Вместо этого работаем с `criminal-brushes-dev` в облаке.

## 3. Как Flutter подключается к базе

Flutter не подключается напрямую к Postgres. Он работает через Supabase API:

```text
SUPABASE_URL
SUPABASE_ANON_KEY
```

Эти значения берутся в Supabase Dashboard:

```text
Project Settings -> API
```

`anon key` можно использовать в клиентском приложении. Безопасность данных обеспечивают RLS-политики.

## 4. Что нельзя использовать в Flutter

Никогда не добавлять в Flutter app:

```text
SUPABASE_SERVICE_ROLE_KEY
DATABASE_URL
database password
JWT secret
payment secret keys
webhook secrets
```

Service role key обходит RLS и подходит только для server-side задач.

## 5. Локальные env-файлы

В Git лежит только пример:

```text
.env.example
```

Каждый разработчик локально создает:

```text
.env.dev
```

Пример:

```text
APP_ENV=dev
SUPABASE_URL=https://xxxxx.supabase.co
SUPABASE_ANON_KEY=xxxxx
SENTRY_DSN=
ANALYTICS_ENABLED=false
PAYMENT_PUBLIC_KEY=
```

`.env.dev` не коммитим.

## 6. Доступ студента к Supabase

Для полноценной совместной работы студент подключается как участник Supabase-команды:

```text
Supabase Dashboard -> Organization Settings -> Team/Members -> Invite member
```

Рекомендация:

- дать доступ только к проекту `criminal-brushes-dev`;
- не давать `Owner`, если это не требуется;
- не пересылать service role key или database password в чат.

Даже если студент видит Dashboard, изменения схемы делаем через миграции в Git, чтобы база и репозиторий не разъехались.

## 7. Как меняем схему БД

Правильный путь:

1. Создать новую SQL-миграцию в `supabase/migrations`.
2. Закоммитить миграцию.
3. Применить ее в cloud Supabase.
4. Запушить ветку.
5. Открыть Pull Request.

Команды:

```powershell
supabase login
supabase link --project-ref <project-ref>
supabase db push
```

Если CLI недоступен или упирается в окружение, временно можно применить SQL через:

```text
Supabase Dashboard -> SQL Editor
```

Но после этого SQL все равно должен быть сохранен в миграции в Git.

## 8. Как проверяем подключение

После создания Flutter app первый технический тест:

1. Инициализировать `supabase_flutter`.
2. Прочитать `collections`.
3. Прочитать `products`.
4. Прочитать `product_variants`.
5. Показать данные на тестовом экране.

Если публичные товары не читаются, первым делом проверяем RLS policies.

## 9. Риски cloud-first подхода

- Разработчики работают с одной dev-базой и могут мешать друг другу тестовыми данными.
- Ошибка миграции сразу влияет на общий dev-проект.
- Без Docker сложнее локально прогонять destructive reset.

Как снижаем риск:

- используем только `criminal-brushes-dev`, не production;
- не меняем таблицы вручную без миграции;
- перед изменением схемы делаем Pull Request;
- seed/test данные помечаем явно;
- production создаем позже отдельным Supabase-проектом.

## 10. Когда вернемся к Docker

Docker можно добавить позже, когда понадобится:

- локальная разработка Edge Functions;
- стабильные миграционные тесты;
- безопасный `db reset`;
- работа без зависимости от общей dev-базы.

Сейчас отсутствие Docker не блокирует Flutter + Supabase разработку.
