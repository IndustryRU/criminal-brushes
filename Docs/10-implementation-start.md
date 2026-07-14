# Implementation Start

Дата проверки: 2026-06-30.

## Что уже установлено на текущей машине

Проверено в `R:\Brush vibe`:

```text
Git: 2.51.0.windows.2
Flutter: 3.44.4 stable через FVM
Dart: 3.9.2
Node.js: v22.20.0
Supabase CLI: 2.67.1
Android Studio: 2025.1.4
Android SDK: 36.1.0
Visual Studio Build Tools: 2019
VS Code: установлен
```

## Что нужно исправить первым

### 1. Принять Android SDK licenses

`flutter doctor` показывает:

```text
Android license status unknown.
Run `flutter doctor --android-licenses`
```

Команда:

```bash
flutter doctor --android-licenses
```

Это юридическое подтверждение лицензий SDK, поэтому каждый разработчик принимает их сам на своей машине.

### 2. Настроить браузер для Flutter Web

`flutter doctor` не нашел Chrome:

```text
Cannot find Chrome executable
```

На текущей машине есть Microsoft Edge:

```text
C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe
```

Варианты:

- Установить Google Chrome.
- Или задать `CHROME_EXECUTABLE` на Edge.

Для PowerShell текущей сессии:

```powershell
$env:CHROME_EXECUTABLE="C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
```

Для постоянной переменной пользователя:

```powershell
[Environment]::SetEnvironmentVariable(
  "CHROME_EXECUTABLE",
  "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe",
  "User"
)
```

После этого открыть новый терминал и проверить:

```bash
flutter doctor -v
```

### 3. Установить FVM

Сейчас `fvm` не найден. Для командной разработки его лучше поставить, чтобы закрепить одну версию Flutter для всех.

Установка через Dart:

```bash
dart pub global activate fvm
```

После установки проверить:

```bash
fvm --version
```

Если команда `fvm` не находится, добавить Dart pub cache bin в `PATH`.

Обычно на Windows:

```text
%LOCALAPPDATA%\Pub\Cache\bin
```

После клонирования проекта:

```bash
fvm install
fvm flutter --version
fvm flutter doctor
```

### 4. Обновить Supabase CLI

Установлена версия:

```text
2.67.1
```

CLI сообщает, что доступна более новая версия:

```text
2.108.0
```

Перед активной разработкой лучше обновить Supabase CLI на всех машинах команды одним способом установки. Конкретная команда зависит от того, как CLI был установлен: Scoop, npm, winget, Homebrew или binary.

Проверка после обновления:

```bash
supabase --version
```

## Что настроить в проекте первым

### Шаг 1. Инициализировать Git

В папке проекта Git пока не инициализирован.

```bash
git init
git branch -M main
```

Создать `.gitignore` под Flutter/Supabase.

### Шаг 2. Создать Flutter app

Рекомендуемая структура:

```text
apps/
  customer_app/
packages/
  design_system/
  domain/
  data/
supabase/
Docs/
```

Первое приложение:

```bash
mkdir apps
cd apps
flutter create customer_app
```

После появления FVM лучше запускать через:

```bash
fvm flutter create customer_app
```

### Шаг 3. Добавить базовые зависимости Flutter

Минимум:

```bash
flutter pub add supabase_flutter
flutter pub add flutter_riverpod
flutter pub add go_router
flutter pub add freezed_annotation
flutter pub add json_annotation
flutter pub add intl
flutter pub add collection
flutter pub add cached_network_image
flutter pub add flutter_svg
flutter pub add sentry_flutter
flutter pub add url_launcher
```

Dev dependencies:

```bash
flutter pub add --dev build_runner
flutter pub add --dev freezed
flutter pub add --dev json_serializable
flutter pub add --dev flutter_lints
```

### Шаг 4. Подключить Supabase cloud project

В корне проекта:

```bash
supabase login
supabase link --project-ref <project-ref>
```

Для применения миграций в облачную dev-базу:

```bash
supabase db push
```

Docker не обязателен: `supabase start` нужен только для локального Supabase stack.

### Шаг 5. Добавить `.env.example`

Минимум:

```text
APP_ENV=dev
SUPABASE_URL=
SUPABASE_ANON_KEY=
SENTRY_DSN=
ANALYTICS_ENABLED=false
PAYMENT_PUBLIC_KEY=
```

### Шаг 6. Настроить CI

Первый GitHub Actions workflow должен проверять:

```bash
flutter pub get
dart format --set-exit-if-changed .
flutter analyze
flutter test
flutter build web
```

## Рекомендуемый порядок на сегодня

1. Принять Android licenses.
2. Настроить `CHROME_EXECUTABLE` или установить Chrome.
3. Установить FVM.
4. Обновить Supabase CLI.
5. Инициализировать Git.
6. Создать структуру `apps/customer_app`.
7. Подключить Flutter зависимости.
8. Подключить Supabase cloud project.
9. Создать первый CI workflow.
10. Сделать первый коммит.

## Контрольная проверка

После setup должно проходить:

```bash
git status
flutter doctor -v
fvm --version
supabase --version
node --version
```

Внутри Flutter app:

```bash
flutter pub get
flutter analyze
flutter test
flutter build web
```
