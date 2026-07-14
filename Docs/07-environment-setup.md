# Environment Setup

## Локальная разработка

Каждому участнику установить:

- Git.
- Flutter stable.
- FVM.
- Android Studio.
- Android SDK.
- Java JDK 17+.
- VS Code или Cursor.
- Supabase CLI.
- Node.js LTS.
- Docker Desktop опционально, только для локального Supabase stack.
- Xcode для iOS-разработки на macOS.

## Проверка Flutter

```bash
flutter doctor
flutter --version
```

Версия Flutter закреплена через FVM в `.fvmrc`. После клонирования проекта:

```bash
fvm install
fvm flutter --version
fvm flutter doctor
```

Обычные Flutter-команды в проекте лучше запускать через `fvm flutter`.

## Supabase CLI

Проверка:

```bash
supabase --version
```

Текущий процесс проекта: cloud-first без Docker. Supabase CLI используем для привязки к облачному проекту и применения миграций:

```bash
supabase login
supabase link --project-ref <project-ref>
supabase db push
```

`supabase start` не обязателен, потому что требует Docker и запускает локальный Supabase stack.

## Переменные окружения

В репозитории хранить:

```text
.env.example
```

Локально создавать:

```text
.env.dev
.env.staging
.env.prod
```

Минимальный `.env.example`:

```text
APP_ENV=dev
SUPABASE_URL=
SUPABASE_ANON_KEY=
SENTRY_DSN=
ANALYTICS_ENABLED=false
PAYMENT_PUBLIC_KEY=
```

Нельзя хранить в Flutter app:

```text
SUPABASE_SERVICE_ROLE_KEY
PAYMENT_SECRET_KEY
WEBHOOK_SECRET
```

## IDE

Рекомендуемые расширения VS Code:

- Dart.
- Flutter.
- GitLens.
- Error Lens.
- Markdown All in One.

## GitHub setup

Создать:

- Repository.
- Branch protection для `main`.
- Required PR review.
- Required status checks.
- Secrets для CI.

Минимальные GitHub Secrets:

```text
SUPABASE_ACCESS_TOKEN
SUPABASE_PROJECT_REF_STAGING
SUPABASE_PROJECT_REF_PROD
SENTRY_AUTH_TOKEN
ANDROID_KEYSTORE_BASE64
ANDROID_KEYSTORE_PASSWORD
ANDROID_KEY_ALIAS
ANDROID_KEY_PASSWORD
```

Для iOS signing лучше использовать Codemagic или Fastlane Match после решения по Apple Developer account.

## CI минимум

На Pull Request:

```bash
flutter pub get
dart format --set-exit-if-changed .
flutter analyze
flutter test
flutter build web
```

На release:

```bash
flutter build web --release
flutter build appbundle --release
flutter build apk --release
flutter build ipa --release
```

Команды iOS требуют macOS и настроенной подписи.

## Доступы

Создать таблицу доступов вне репозитория:

- GitHub/GitLab.
- Supabase.
- Payment provider.
- Domain/DNS.
- Analytics.
- Store consoles.
- Sentry.

В репозитории хранить только инструкцию, но не сами секреты.

## Первые шаги после создания репозитория

1. Инициализировать Git.
2. Создать Flutter app.
3. Подключить FVM.
4. Добавить `.gitignore`.
5. Добавить базовый CI.
6. Создать Supabase project `dev`.
7. Добавить первую миграцию.
8. Подключить Supabase client в Flutter через `SUPABASE_URL` и `SUPABASE_ANON_KEY`.
9. Сделать первый экран home с моковыми данными.
10. Настроить PR flow.
