Here's an updated version of your `README.md` file for the **image-app** project, replacing the default Flutter content with the app-specific description you provided:

---

# 📸 image-app

A Flutter application that showcases images in an elegant and interactive UI, with support for favorites, previewing, searching, and offline data storage.

---

## 🚀 Features

- **🏠 Home Screen**
  - Displays images in a grid view.
  - Each image includes a favorite icon to add/remove from favorites.
  - Single tap opens the **Image Preview Screen**.
  - Double tap in preview toggles the image as a favorite.

- **🔍 Search Screen**
  - Accessed via a search icon.
  - Allows searching for images.
  - Last search is stored using BLoC state until the session ends or it's cleared.

- **❤️ Favorites Screen**
  - Accessed via the favorite icon in the Home AppBar.
  - Displays saved favorite images.
  - Includes a **Clear All** button to remove all saved favorites.

- **📦 Local Storage**
  - Uses **Hive** as a local database to persist favorite images.
  - Data remains stored until manually cleared or app is uninstalled.

- **📶 Internet Connectivity Indicator**
  - Shows connection status via a bottom indicator.

---

## 🖼️ Screenshots

| Home Screen | Image Preview | Favorites | Search |
|-------------|----------------|------------|--------|
| ![Home](screenshots/home.png) | ![Preview](screenshots/preview.png) | ![Favorites](screenshots/favorites.png) | ![Search](screenshots/search.png) |

---

## 🛠 Getting Started

To run this project:

```bash
flutter pub get
flutter run
```

Make sure you have Flutter installed. For more information:

- 📘 [Flutter Documentation](https://docs.flutter.dev/)
- 🎯 [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- 🍽️ [Flutter Cookbook](https://docs.flutter.dev/cookbook)

---

Let me know if you'd like to include installation requirements, API details (if any), or contribution guidelines!