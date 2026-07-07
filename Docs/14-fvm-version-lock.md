# FVM Version Lock

Памятка по фиксации Flutter-версии через FVM для команды `Criminal Brushes`.

## 1. Зачем нужен FVM

FVM фиксирует Flutter SDK на уровне проекта. Это защищает команду от ситуации:

```text
у одного разработчика Flutter 3.35.x
у второго Flutter 3.44.x
CI использует третью версию
```

Итогом без FVM могут быть разные ошибки сборки, разные lint-правила, разные версии Gradle-интеграции и разное поведение web/mobile build.

## 2. Зафиксированная версия проекта

В корне репозитория добавлен файл:

```text
.fvmrc
```

Текущая командная версия:

```text
Flutter 3.44.4
```

Файл `.fvmrc` коммитим в Git. Папку `.fvm/` не коммитим.

## 3. Установка FVM

Если FVM еще не установлен:

```powershell
dart pub global activate fvm
```

Если после установки команда `fvm` не находится, добавить в `PATH`:

```text
%LOCALAPPDATA%\Pub\Cache\bin
```

Для текущего окна PowerShell:

```powershell
$env:Path += ";$env:LOCALAPPDATA\Pub\Cache\bin"
fvm --version
```

Постоянно для пользователя Windows:

```powershell
[Environment]::SetEnvironmentVariable(
  "Path",
  [Environment]::GetEnvironmentVariable("Path", "User") + ";$env:LOCALAPPDATA\Pub\Cache\bin",
  "User"
)
```

После этого закрыть PowerShell, открыть заново и проверить:

```powershell
fvm --version
```

## 4. Установка Flutter-версии проекта

В корне репозитория:

```powershell
fvm install
```

FVM прочитает `.fvmrc` и установит нужную версию Flutter.

Проверка:

```powershell
fvm flutter --version
fvm flutter doctor -v
```

## 5. Как запускать команды Flutter

Вместо:

```powershell
flutter doctor
flutter pub get
flutter run -d chrome
flutter analyze
flutter test
```

используем:

```powershell
fvm flutter doctor
fvm flutter pub get
fvm flutter run -d chrome
fvm flutter analyze
fvm flutter test
```

Так команда гарантированно использует версию из `.fvmrc`.

## 6. Когда создадим Flutter app

Плановая структура:

```text
apps/
  customer_app/
```

После создания приложения:

```powershell
cd apps/customer_app
fvm flutter pub get
fvm flutter doctor
```

Если FVM в подпапке приложения не увидит корневой `.fvmrc`, есть два безопасных варианта:

1. Запускать команды из корня репозитория с указанием пути к проекту.
2. Добавить такой же `.fvmrc` в `apps/customer_app`.

Решение примем после создания Flutter skeleton.

## 7. Проверка студента

Студент после `git pull` должен выполнить:

```powershell
fvm install
fvm flutter --version
fvm flutter doctor -v
```

Ожидаем:

```text
Flutter 3.44.4
```

## 8. Обновление Flutter-версии в будущем

Обновлять версию Flutter нужно отдельной задачей:

```powershell
git checkout -b chore/update-flutter-version
fvm install <new-version>
fvm use <new-version>
fvm flutter doctor -v
fvm flutter analyze
fvm flutter test
```

После проверки:

```powershell
git add .fvmrc
git commit -m "chore: update flutter version"
git push -u origin chore/update-flutter-version
```

Не обновляем Flutter-версию случайно внутри продуктовой задачи.

## 9. Источники

- FVM configuration: https://fvm.app/documentation/getting-started/configuration
- FVM quick reference: https://fvm.app/documentation/guides/quick-reference
