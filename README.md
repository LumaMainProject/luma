# Luma — Инструкция по проекту

## Структура проекта


core/                # Константы и базовые настройки
  constants/         # Глобальные константы
  router/            # Навигация (роутинг страниц)
  theme/             # Общая тема приложения

data/                # Работа с данными и сервером
  models/            # Модели данных
  repositories/      # Репозитории для работы с сервером

logic/               # Бизнес-логика (BLoC и Cubit)
  ...                # Папки по функциям (авторизация, заказы и т.п.)

presentation/        # Визуальная часть
  screens/           # Страницы приложения
    buyer_screens/   # Страницы для покупателя
    seller_screens/  # Страницы для продавца
    register_screens/# Регистрация и онбординг
  widgets/           # Общие виджеты


---

# Стек технологий проекта **Luma**

## Основное

* **Flutter** (3.x)
* **Dart** (3.8.1)

## Архитектура

* **BLoC / Cubit** — управление состоянием
* **Equatable** — упрощает сравнение объектов
* **GoRouter** — навигация

## Аутентификация и данные

* **Firebase Core** — базовое подключение
* **Firebase Auth** — авторизация пользователей
* **Cloud Firestore** — база данных
* **Firebase Storage** — хранение файлов (фото, видео)
* **Shared Preferences** — локальное хранилище
* **Hive + Hive Flutter** — оффлайн-данные и кэширование

## UI и UX

* **Cupertino Icons** — иконки в iOS-стиле
* **Shimmer** — мерцающие заглушки
* **Cached Network Image** — кэш изображений
* **Intl** — интернационализация (даты, числа, переводы)
* **Collection** — расширенные коллекции

## Визуализация

* **fl_chart** — графики и диаграммы

## Медиа

* **Image Picker** — выбор изображений
* **Permission Handler** — управление правами
* **Video Player (+ Web)** — воспроизведение видео
* **Visibility Detector** — отслеживание видимости виджетов

## Сетевые возможности

* **URL Launcher** — открытие внешних ссылок

## Разработка и тесты

* **Flutter Test** — юнит-тесты
* **Flutter Lints** — правила стиля кода

## Ассеты

* Изображения: `assets/images/`
* Видео: `assets/videos/`


---

## Установка и запуск

### 1. Установка зависимостей

bash
flutter pub get


### 2. Запуск локально

Для Web:

bash
flutter run -d chrome


Для Android:

bash
flutter run -d emulator-5554


Для iOS (на macOS):

bash
flutter run -d ios


---

## Работа с Firebase

### Билд и деплой

bash
flutter clean
flutter build web
firebase deploy


### Конфигурация

* `firebase_options.dart` — хранит параметры подключения.
* Для корректного запуска нужны файлы:

  * `google-services.json` (Android)
  * `GoogleService-Info.plist` (iOS)

На данный момент у Firebase настроен полный доступ ко всем данным.
После завершения разработки рекомендуется ограничить права в `firestore.rules` и `storage.rules`.

---

## Git

### Основные команды

bash
git add .
git commit -m "Комментарий"
git push


Основной репозиторий: [ссылка на GitHub]

---

## Известные ограничения

* Не все функции работают на Web (например, карты).
* Firebase Storage имеет неограниченные права доступа (рекомендуется изменить).

---

## Полезно знать

* Вся логика работы (авторизация, данные, API) находится в `logic/` и `data/`.
* Визуальные элементы (UI) собраны в `presentation/`.
* Основные константы для конфигурации приложения находятся в `core/constants/`.
