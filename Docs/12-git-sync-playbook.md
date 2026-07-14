# Git Sync Playbook

Памятка для синхронизации проекта между участниками команды через GitHub/GitLab и для работы с помощью Codex.

Цель: чтобы у владельца проекта и студента проект обновлялся управляемо, без ручной пересылки архивов и без риска потерять изменения.

## 1. Главный принцип

Код синхронизируем через Git:

```text
local project -> commit -> push -> remote repository -> pull/clone by another developer
```

Не используем для кода:

- Google Drive.
- Dropbox.
- Яндекс Диск.
- Telegram zip-архивы.
- Ручное копирование папок.

Для кода используем GitHub/GitLab. Для дизайна - Figma. Для задач - GitHub Projects, YouTrack, Linear или Notion.

## 2. Рекомендуемая схема веток

```text
main
feature/*
bugfix/*
hotfix/*
```

Правила:

- `main` - стабильная ветка.
- Новая задача делается в отдельной ветке.
- В `main` напрямую лучше не пушить после старта разработки.
- Изменения попадают в `main` через Pull Request.
- Перед началом работы делаем `git pull`.
- Перед пушем проверяем `git status` и diff.

## 3. Первичная настройка репозитория владельцем

Создать пустой репозиторий на GitHub/GitLab, например:

```text
criminal-brushes
```

Текущий репозиторий проекта:

```text
https://github.com/IndustryRU/criminal-brushes
```

В локальной папке проекта:

```powershell
git init
git branch -M main
git remote add origin https://github.com/IndustryRU/criminal-brushes.git
git status
git add .
git commit -m "chore: initial project docs"
git push -u origin main
```

Заменить:

```text
https://github.com/IndustryRU/criminal-brushes.git
```

на реальный URL репозитория.

## 4. Подключение студента

Студент получает доступ к репозиторию и клонирует проект:

```powershell
git clone https://github.com/ORG/criminal-brushes.git
cd criminal-brushes
git status
```

Проверяет документацию:

```powershell
Get-ChildItem Docs
```

Если проект уже содержит Flutter app:

```powershell
cd apps/customer_app
flutter pub get
flutter doctor -v
flutter analyze
```

Если команда использует FVM:

```powershell
fvm install
cd apps/customer_app
fvm flutter pub get
fvm flutter analyze
```

Для Supabase студент получает доступ к проекту `criminal-brushes-dev` и локально создает `.env.dev` по `.env.example`.

## 5. Ежедневный ручной сценарий работы

Перед началом работы:

```powershell
git checkout main
git pull
git checkout -b feature/task-name
```

Пример:

```powershell
git checkout main
git pull
git checkout -b feature/home-screen
```

После изменений:

```powershell
git status
git diff
git add .
git commit -m "feat: add home screen"
git push -u origin feature/home-screen
```

После этого открыть Pull Request на GitHub/GitLab из:

```text
feature/home-screen -> main
```

## 6. Если нужно просто забрать свежие изменения

Если нет своих незакоммиченных изменений:

```powershell
git checkout main
git pull
```

Если есть свои изменения:

```powershell
git status
git add .
git commit -m "wip: save local changes"
git checkout main
git pull
```

Лучше не делать `git pull`, если не понимаете, какие локальные изменения сейчас лежат в рабочей папке.

## 7. Как обновить свою feature-ветку от main

Когда другой участник уже влил изменения в `main`:

```powershell
git checkout main
git pull
git checkout feature/task-name
git merge main
```

Если возник конфликт, не паниковать:

```powershell
git status
```

Открыть конфликтные файлы, выбрать нужные изменения, затем:

```powershell
git add .
git commit
```

Если конфликт сложный, лучше попросить Codex помочь.

## 8. Что нельзя коммитить

Нельзя добавлять в Git:

- `.env`
- `.env.dev`
- `.env.prod`
- API keys.
- Supabase service role key.
- Payment secret key.
- Webhook secrets.
- Keystore files.
- Apple certificates.
- Большие временные файлы.
- `build/`
- `.dart_tool/`
- `.fvm/`

В репозитории должен быть только пример:

```text
.env.example
```

## 9. Полезные команды диагностики

Показать состояние:

```powershell
git status
```

Показать удаленный репозиторий:

```powershell
git remote -v
```

Показать ветки:

```powershell
git branch
git branch -a
```

Показать последние коммиты:

```powershell
git log --oneline --decorate -10
```

Показать изменения:

```powershell
git diff
```

Показать изменения, уже добавленные в commit:

```powershell
git diff --cached
```

## 10. Промпты для Codex

Эти короткие промпты можно отправлять Codex в проекте. Перед операциями с Git Codex должен проверить `git status`, чтобы не затереть чужие изменения.

### Проверить состояние проекта

```text
Кодекс, проверь текущее состояние Git: ветку, remote, незакоммиченные изменения и последние коммиты. Ничего не меняй, только дай краткий отчет и рекомендации.
```

### Инициализировать Git-репозиторий

```text
Кодекс, инициализируй Git в текущей папке, создай ветку main, проверь .gitignore, сделай первый commit с текущей документацией. Перед commit покажи, какие файлы попадут в commit.
```

После этого вручную добавить remote или дать Codex URL:

```text
Кодекс, добавь remote origin: https://github.com/ORG/criminal-brushes.git, проверь remote -v и запушь main. Перед push проверь git status.
```

### Забрать свежие изменения

```text
Кодекс, безопасно обнови проект из remote. Сначала проверь git status. Если есть незакоммиченные изменения, остановись и объясни варианты. Если рабочая папка чистая, сделай git pull.
```

### Создать feature-ветку

```text
Кодекс, создай новую ветку feature/home-screen от актуальной main. Сначала обнови main через pull, если рабочая папка чистая. Если есть локальные изменения, остановись и покажи их.
```

### Сделать commit

```text
Кодекс, подготовь commit для текущих изменений. Сначала покажи git status и кратко перечисли измененные файлы. Проверь, что в commit не попадут секреты, .env и build-файлы. Затем предложи commit message.
```

Если commit message устраивает:

```text
Кодекс, сделай commit с сообщением: "feat: add home screen". После commit покажи последние 3 коммита.
```

### Запушить ветку

```text
Кодекс, запушь текущую ветку в origin. Сначала проверь ветку, git status и remote. Если есть незакоммиченные изменения, остановись. Если все чисто, выполни push.
```

### Подготовить Pull Request

```text
Кодекс, подготовь текст Pull Request для текущей ветки: summary, что изменилось, как проверить, риски и чеклист. Не пушь ничего без отдельной команды.
```

### Помочь с конфликтом

```text
Кодекс, помоги разобрать Git conflict. Сначала покажи конфликтные файлы через git status. Затем объясни, какие варианты разрешения есть, и предложи безопасное решение. Не удаляй чужие изменения без подтверждения.
```

### Проверить перед merge

```text
Кодекс, проведи pre-merge проверку: git status, flutter analyze, flutter test, список измененных файлов и краткий риск-анализ. Ничего не пушь.
```

## 11. Промпты для студента

Студент может использовать такие формулировки у себя:

### Первое подключение

```text
Кодекс, помоги мне подключиться к проекту Criminal Brushes. Я уже получил доступ к GitHub и Supabase cloud project. Проверь, что установлены Git, Flutter, Dart, Android Studio, FVM, Node.js и Supabase CLI. Docker не обязателен. Затем помоги клонировать репозиторий, выполнить fvm install и подготовить .env.dev по .env.example.
```

### Начать задачу

```text
Кодекс, помоги начать новую задачу. Сначала обнови main, затем создай feature-ветку с понятным названием. Если есть локальные изменения, остановись и покажи их.
```

### Завершить задачу

```text
Кодекс, помоги завершить задачу: проверь git status, запусти анализ/тесты, подготовь commit, затем запушь feature-ветку. Перед commit покажи список файлов и убедись, что нет секретов.
```

### Обновиться от команды

```text
Кодекс, помоги безопасно подтянуть последние изменения команды. Проверь текущую ветку и локальные изменения. Если можно, сделай pull. Если нельзя, объясни, что сохранить или закоммитить.
```

## 12. Ручной quick reference

Создать ветку:

```powershell
git checkout main
git pull
git checkout -b feature/task-name
```

Посмотреть изменения:

```powershell
git status
git diff
```

Сделать commit:

```powershell
git add .
git commit -m "feat: describe change"
```

Запушить:

```powershell
git push -u origin feature/task-name
```

Подтянуть main:

```powershell
git checkout main
git pull
```

Удалить локальную ветку после merge:

```powershell
git branch -d feature/task-name
```

## 13. Минимальные правила безопасности

- Никогда не отправлять Codex секреты в чат.
- Никогда не коммитить `.env`.
- Перед push всегда смотреть `git status`.
- Перед merge запускать analyze/test.
- Не использовать `git reset --hard`, если не уверены на 100%.
- Не использовать force push в общих ветках.
- Если Git просит решить конфликт, сначала остановиться и разобраться.

## 14. Как мы работаем с помощью Codex

Хороший формат задачи для Codex:

```text
Кодекс, задача: добавить экран каталога.
Контекст: работаем в feature/catalog-screen.
Требования: карточки товара, моковые данные, адаптивность web/mobile.
Перед изменениями проверь git status.
После изменений запусти flutter analyze и flutter test.
Commit не делай, пока я не подтвержу.
```

Если нужно, чтобы Codex сделал все до push:

```text
Кодекс, реализуй задачу в отдельной feature-ветке, проверь analyze/test, сделай commit и push. Перед commit покажи список файлов и commit message. Если есть незнакомые локальные изменения, остановись.
```

Такой формат помогает Codex работать как аккуратный инженер, а не как случайный терминал с руками.
