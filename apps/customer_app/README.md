# Criminal Brushes Customer App

Flutter Web/Android/iOS приложение пользовательской витрины Criminal Brushes.

## Запуск без backend

```bash
fvm flutter pub get
fvm flutter run -d chrome
```

Если Supabase-параметры не переданы, приложение запускается на моковом UI без инициализации клиента.

## Запуск с Supabase API

Публичные параметры берутся в Supabase Dashboard. `service_role` в приложение передавать нельзя.

```bash
fvm flutter run -d chrome \
  --dart-define=APP_ENV=dev \
  --dart-define=SUPABASE_URL=https://<project-ref>.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=<publishable-or-anon-key>
```

## Проверка

```bash
dart format --output=none --set-exit-if-changed .
fvm flutter analyze
fvm flutter test
fvm flutter build web --release
```
