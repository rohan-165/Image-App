# 📸 image-app

A Flutter application that showcases images in an elegant and interactive UI, with support for favorites, previewing, searching, and offline data storage.

---

## 🚀 Features

- **🏠 Home Screen**
  - Displays images in a grid view.
  - Each image includes a favorite icon to add/remove from favorites.
  - Single tap opens the **Image Preview Screen**.
  - Double tap in preview toggles the image as a favorite.

  <img src="screenshots/home.jpg" alt="Home Screen" width="300" height="600"> 

- **🔍 Search Screen**
  - Accessed via a search icon.
  - Allows searching for images.
  - Last search is stored using BLoC state until the session ends or it's cleared.

  <img src="screenshots/search.jpg" alt="Search Screen" width="300" height="600"> 

- **❤️ Favorites Screen**
  - Accessed via the favorite icon in the Home AppBar.
  - Displays saved favorite images.
  - Includes a **Clear All** button to remove all saved favorites.

  <img src="screenshots/favorite.jpg" alt="Favorites Screen" width="300" height="600"> 

- **📦 Local Storage**
  - Uses **Hive** as a local database to persist favorite images.
  - Data remains stored until manually cleared or app is uninstalled.

- **📶 Internet Connectivity Indicator**
  - Shows connection status via a bottom indicator.

  <img src="screenshots/online.jpg" alt="Online View" width="300" height="300">  | <img src="screenshots/offline.jpg" alt="Offline View" width="300" height="300">  

  

---

### Image Preview  
<img src="screenshots/imageview.jpg" alt="Alert Dialog" width="300" height="600">  

### Alert Dialog  
<img src="screenshots/alert1.jpg" alt="Alert Dialog" width="300" height="600">  | <img src="screenshots/alert2.jpg" alt="Alert Dialog" width="300" height="600">



---

## 🛠 Getting Started


1. **Clone the Repository**:  
```bash  
git clone https://github.com/rohan-165/Image-App.git  
cd Image-App  
```

---

```bash
flutter pub get
flutter run
```

Make sure you have Flutter installed. For more information:

- 📘 [Flutter Documentation](https://docs.flutter.dev/)
- 🎯 [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- 🍽️ [Flutter Cookbook](https://docs.flutter.dev/cookbook)

---


You can save this content in your `README.md` file directly. Let me know if you need help with any specific part of the project setup or codebase!