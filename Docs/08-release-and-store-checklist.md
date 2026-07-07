# Release And Store Checklist

## Важное правило

Перед реальной публикацией нужно перепроверить актуальные требования RuStore, Google Play и App Store. Правила, target SDK, privacy формы и требования к сборкам меняются.

## Web release

Минимум:

- Production Supabase project.
- Production environment variables.
- Domain.
- HTTPS.
- Privacy policy.
- Public offer.
- Delivery and returns pages.
- Analytics.
- Error monitoring.
- SEO metadata.
- Open Graph image.

Build:

```bash
flutter build web --release
```

Проверить:

- Главная открывается.
- Каталог открывается.
- Карточка товара открывается.
- Корзина работает.
- Checkout не ломается.
- Ошибки оплаты обработаны.
- Mobile layout.
- Desktop layout.

## Android shared checklist

- Package ID утвержден.
- App icon.
- Adaptive icon.
- Splash screen.
- Release signing.
- Version code.
- Version name.
- Target SDK соответствует требованиям магазина.
- Privacy policy URL.
- Описание приложения.
- Скриншоты.
- Возрастной рейтинг.
- Data safety / collected data forms.
- Тестовая оплата.
- Production оплата.
- Push permissions.
- Deep links, если используются.

## RuStore

Нужно подготовить:

- Аккаунт разработчика RuStore.
- Приложение в RuStore Console.
- APK или AAB согласно выбранному процессу.
- Подписанная release-сборка.
- Иконка.
- Скриншоты.
- Описание на русском.
- Категория.
- Возрастной рейтинг.
- Данные о собираемых и передаваемых пользовательских данных.
- Privacy policy.
- Тестовые данные для проверки, если нужны.

Если используются платежи внутри приложения:

- Проверить актуальный RuStore Pay SDK.
- Настроить тестовый режим.
- Проверить, что подпись тестовой сборки соответствует требованиям RuStore.
- Проверить deeplink возврата в приложение.

## Google Play

Нужно подготовить:

- Google Play Console account.
- App bundle `.aab`.
- Release signing.
- Store listing.
- App icon.
- Feature graphic.
- Screenshots.
- Privacy policy.
- Data safety form.
- Content rating.
- Target audience.
- Test track.
- Production release.

На дату 18 июня 2026 новые приложения и обновления в Google Play должны target Android 15 / API 35 или выше, кроме отдельных категорий устройств. Перед релизом проверить официальную страницу требований.

## App Store

Нужно подготовить:

- Apple Developer Program.
- Bundle ID.
- App Store Connect app.
- Certificates/profiles или managed signing.
- iOS build через Xcode/Codemagic/Fastlane.
- App icon.
- Screenshots для нужных устройств.
- App privacy details.
- Age rating.
- Review notes.
- Demo account, если функциональность закрыта логином.

Корректное название магазина: `App Store`.

На дату 18 июня 2026 Apple требует актуальные minimum requirements для загрузки приложений через App Store Connect, включая сборку современным Xcode. Перед релизом проверить актуальные требования Apple.

## Legal

Минимальный набор документов:

- Privacy Policy.
- User Agreement или Terms of Use.
- Public Offer для покупок.
- Delivery Policy.
- Return and Refund Policy.
- Consent to Personal Data Processing.
- Cookie Policy для web, если используются cookies/analytics.

Для детского продукта особенно важно:

- Не собирать лишние данные ребенка.
- Не делать агрессивные push/маркетинговые механики для детей.
- Четко указывать, кто покупатель и плательщик.
- Проверить возрастные ограничения и рекламные формулировки.

## Pre-release QA

- Smoke test web.
- Smoke test Android.
- Smoke test iOS.
- Checkout test.
- Payment success.
- Payment failure.
- Order webhook.
- Email notification.
- Push notification.
- Admin order status update.
- Offline/poor network behavior.
- Crash reporting.
- Analytics events.

## Rollback

Для каждого релиза определить:

- Как откатить web.
- Как отключить проблемный feature flag.
- Как остановить промо/drop.
- Как пометить платежную интеграцию на maintenance.
- Кто принимает решение об emergency rollback.

## Official references

- Supabase Flutter Quickstart: https://supabase.com/docs/guides/getting-started/quickstarts/flutter
- Supabase Docs: https://supabase.com/docs
- Google Play target API requirements: https://developer.android.com/google/play/requirements/target-sdk
- Apple App Review Guidelines: https://developer.apple.com/app-store/review/guidelines/
- Apple App Store submitting requirements: https://developer.apple.com/app-store/submitting/
- RuStore publishing docs: https://www.rustore.ru/help/en/developers/publishing-and-verifying-apps
- RuStore user data categories: https://www.rustore.ru/help/en/developers/publishing-and-verifying-apps/app-publication/new-version-app/declare-app-permissions/data-categories
- RuStore Pay SDK Flutter: https://www.rustore.ru/help/en/sdk/pay/flutter/10-3-1
