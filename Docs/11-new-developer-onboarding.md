# New Developer Onboarding

Документ для нового участника команды, у которого на машине еще ничего не установлено.

Цель: поднять окружение для разработки `Criminal Brushes` на Flutter + Supabase и запустить проект локально.

## 1. Что нужно установить

Минимальный набор:

- Git.
- VS Code или Cursor.
- Flutter SDK.
- Android Studio.
- Chrome или Microsoft Edge.
- FVM.
- Node.js LTS.
- Supabase CLI.
- Docker Desktop.

Для iOS-разработки дополнительно:

- macOS.
- Xcode.
- CocoaPods.
- Apple Developer доступ.

На Windows собрать iOS-приложение нельзя, но можно разрабатывать Flutter UI, web и Android.

## 2. Git

Установить Git:

https://git-scm.com/downloads

Проверить:

```bash
git --version
```

Рекомендуемая первичная настройка:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global init.defaultBranch main
```

## 3. Редактор

Установить один из вариантов:

- VS Code: https://code.visualstudio.com/
- Cursor: https://cursor.com/

Рекомендуемые расширения:

- Dart.
- Flutter.
- GitLens.
- Error Lens.
- Markdown All in One.

## 4. Flutter SDK

Официальная инструкция:

https://docs.flutter.dev/get-started/install

После установки проверить:

```bash
flutter --version
flutter doctor -v
```

`flutter doctor` покажет, чего еще не хватает.

## 5. Android Studio

Установить Android Studio:

https://developer.android.com/studio

При установке выбрать:

- Android SDK.
- Android SDK Platform.
- Android SDK Command-line Tools.
- Android Emulator.

После установки выполнить:

```bash
flutter doctor -v
```

Принять Android licenses:

```bash
flutter doctor --android-licenses
```

Во время выполнения отвечать `y`, если разработчик согласен с лицензиями.

## 6. Chrome или Edge для Flutter Web

Flutter Web требует Chromium-based браузер.

Вариант 1: установить Chrome:

https://www.google.com/chrome/

Вариант 2: использовать Microsoft Edge.

Если Flutter не видит браузер, задать переменную `CHROME_EXECUTABLE`.

PowerShell для текущей сессии:

```powershell
$env:CHROME_EXECUTABLE="C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
```

Постоянно для пользователя Windows:

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

## 7. FVM

FVM фиксирует версию Flutter для проекта, чтобы у всех разработчиков была одинаковая среда.

Установка:

```bash
dart pub global activate fvm
```

Проверить:

```bash
fvm --version
```

Если команда `fvm` не найдена, добавить Dart pub cache bin в `PATH`.

Windows path:

```text
%LOCALAPPDATA%\Pub\Cache\bin
```

После клонирования проекта:

```bash
fvm install
fvm flutter doctor
```

Если в проекте еще не зафиксирована версия Flutter:

```bash
fvm install 3.35.6
fvm use 3.35.6
```

## 8. Node.js LTS

Установить Node.js LTS:

https://nodejs.org/

Проверить:

```bash
node --version
npm --version
```

Node.js нужен для части tooling, скриптов и возможных frontend/devops задач.

## 9. Supabase CLI

Официальная инструкция:

https://supabase.com/docs/guides/cli

Проверить:

```bash
supabase --version
```

После получения доступа к проекту:

```bash
supabase login
```

В корне репозитория:

```bash
supabase link --project-ref <project-ref>
```

`project-ref` выдает ответственный за Supabase/infra.

## 10. Docker Desktop

Установить Docker Desktop:

https://www.docker.com/products/docker-desktop/

Проверить:

```bash
docker --version
docker compose version
```

Docker нужен для локального Supabase:

```bash
supabase start
```

Если Docker не установлен, разработчик может работать с cloud Supabase, но локальная backend-разработка будет ограничена.

## 11. Доступы

Новый участник должен получить:

- GitHub/GitLab repository access.
- Supabase project access.
- Figma access.
- Task tracker access.
- Team chat access.
- Доступ к staging secrets через безопасный канал.

Нельзя передавать секреты через публичные чаты, коммиты или скриншоты.

## 12. Клонирование проекта

После получения доступа:

```bash
git clone <repository-url>
cd <project-folder>
```

Проверить документацию:

```bash
ls Docs
```

На Windows PowerShell:

```powershell
Get-ChildItem Docs
```

## 13. Переменные окружения

Скопировать пример:

```bash
cp .env.example .env.dev
```

На Windows PowerShell:

```powershell
Copy-Item .env.example .env.dev
```

Заполнить значения, которые выдает ответственный за backend/infra:

```text
APP_ENV=dev
SUPABASE_URL=
SUPABASE_ANON_KEY=
SENTRY_DSN=
ANALYTICS_ENABLED=false
PAYMENT_PUBLIC_KEY=
```

Никогда не добавлять в `.env.dev` service role key, payment secret key или webhook secret для клиентского приложения.

## 14. Запуск Flutter app

Перейти в приложение:

```bash
cd apps/customer_app
```

Получить зависимости:

```bash
fvm flutter pub get
```

Если FVM еще не подключен:

```bash
flutter pub get
```

Запуск web:

```bash
fvm flutter run -d chrome
```

или без FVM:

```bash
flutter run -d chrome
```

Запуск Android:

```bash
fvm flutter run -d <device-id>
```

Список устройств:

```bash
fvm flutter devices
```

## 15. Локальный Supabase

В корне репозитория:

```bash
supabase start
```

Применить миграции:

```bash
supabase db reset
```

Если проект использует cloud Supabase для dev, этот шаг может быть необязательным. Решение фиксируется в `Docs/07-environment-setup.md`.

## 16. Проверка готовности

Окружение готово, если проходят команды:

```bash
git --version
flutter doctor -v
fvm --version
node --version
npm --version
supabase --version
docker --version
```

В папке Flutter app:

```bash
fvm flutter pub get
fvm flutter analyze
fvm flutter test
fvm flutter build web
```

Если FVM не используется:

```bash
flutter pub get
flutter analyze
flutter test
flutter build web
```

## 17. Типовые проблемы

### `fvm` не найден

Добавить Dart pub cache bin в `PATH`:

```text
%LOCALAPPDATA%\Pub\Cache\bin
```

Открыть новый терминал и проверить:

```bash
fvm --version
```

### Android licenses не приняты

Выполнить:

```bash
flutter doctor --android-licenses
```

### Flutter не видит Chrome

Установить Chrome или задать `CHROME_EXECUTABLE` на Edge.

### `supabase start` не работает

Проверить:

```bash
docker --version
docker compose version
```

Запустить Docker Desktop и повторить:

```bash
supabase start
```

### Android device не виден

Проверить:

- Включен USB debugging.
- Установлены драйверы устройства.
- Эмулятор запущен.
- Android SDK установлен.

Команда:

```bash
flutter devices
```

## 18. Первый рабочий день

Новый участник должен:

1. Установить весь базовый набор.
2. Получить доступы.
3. Клонировать проект.
4. Заполнить `.env.dev`.
5. Запустить Flutter app.
6. Прогнать analyze/test.
7. Создать тестовую feature branch.
8. Сделать небольшой PR, например обновление документации или исправление мелкого UI.

После первого PR разработчик считается подключенным к процессу.
