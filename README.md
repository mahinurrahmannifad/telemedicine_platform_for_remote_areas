# 🩺 Telemedicine Platform for Remote Areas

A full-featured **Flutter-based mobile application** that bridges the healthcare access gap for rural and remote populations. This platform provides **offline-first authentication**, virtual consultations, medical record storage, and health education – all in one app.

## 🚀 Features

- 🔐 **Offline Sign In/Sign Up** (SQLite local database)
- 👩‍⚕️ Doctor & Patient Profiles
- 📅 Appointment Scheduling
- 📄 Medical Report Upload & Viewer
- 🧑‍💻 Admin Panel Integration (optional via API)
- 🌐 Localization Support (Multilingual UI)
- ☁️ Future-ready for Telemedicine APIs (e.g., video calls)
- 🎨 Beautiful and responsive UI with `GetX` state management

---

## 🛠️ Tech Stack

| Tech                    | Purpose                           |
|-------------------------|-----------------------------------|
| `Flutter`               | Cross-platform mobile framework   |
| `GetX`                  | State management & routing        |
| `SQLite (sqflite)`      | Offline user storage              |
| `SharedPreferences`     | Persistent token management       |
| `Dart`                  | Backend & business logic          |
| `Firebase` *(optional)* | Cloud messaging / Auth (future)   |

---

## 🔄 Project Structure

```bash
lib/
├── app/                    # Colors, constants, configs
├── core/                   # Shared logic & widgets
├── features/
│   ├── auth/               # Authentication UI & logic
│   ├── common/             # Bottom nav bar, reusable screens
│   └── patient/doctor/...  # Domain-specific modules
└── main.dart               # Entry point
