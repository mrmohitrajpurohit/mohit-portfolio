# Mohit Rajpurohit — Portfolio (Flutter Web)

A production‑grade **single‑page portfolio website** built with **Flutter Web**, showcasing professional experience across **Mobile, Web, and AI systems**. This project is designed for **long‑term maintainability**, CI/CD deployment, and secure configuration using Firebase services.

---

## 📌 Project Overview

This portfolio is intended to be shared publicly (e.g. via resume links) and demonstrates:

* Real‑world project showcases (Web + Mobile combined)
* AI & R&D work (LangChain, ML Kit, ARKit demos)
* Skills & technology depth with visual indicators
* Certifications & achievements gallery
* Fully working contact system (Email + Firestore)
* CI/CD deployment via GitHub Actions

Live URL:
👉 [https://mohit-portfolio-db1ad.web.app/](https://mohit-portfolio-db1ad.web.app/)

---

## 🖥️ System Requirements

Minimum system requirements to develop or maintain this project:

* **Operating System**

    * macOS (Intel / Apple Silicon)
    * Windows 10+ (64‑bit)
    * Linux (Ubuntu 20.04+ recommended)
* **RAM**: Minimum 8 GB (16 GB recommended)
* **Disk Space**: 5–8 GB free
* **Internet Connection**: Required (Firebase, EmailJS, CI/CD)

---

## 🧰 Software & Toolchain Versions

This project was built and tested using the following toolchain:

* **Flutter SDK**: >= 3.6.x
* **Dart SDK**: >= 3.6.x
* **Node.js**: >= 18.x (tested with 22.x)
* **Firebase CLI**: >= 15.x
* **FlutterFire CLI**: >= 1.3.x
* **Git**: >= 2.30
* **Browser (Flutter Web)**: Chrome / Edge (latest)

> ⚠️ For long‑term maintenance (e.g. 3–5 years later), always verify Flutter & Firebase breaking changes before upgrading.

---

## ✅ Prerequisites

Before running the project, ensure the following are installed and available in your system PATH:

* Flutter SDK
* Node.js
* Firebase CLI
* FlutterFire CLI
* Git
* Access to the Firebase project (`mohit-portfolio-db1ad`)

Verification commands:

```bash
flutter --version
node --version
firebase --version
flutterfire --version
```

---

## 🚀 Project Setup (First‑Time)

Follow these steps when setting up the project for the first time:

1. Clone the repository

   ```bash
   git clone <repo-url>
   cd mohit-portfolio
   ```

2. Install Flutter dependencies

   ```bash
   flutter pub get
   ```

3. Configure Firebase for the project

   ```bash
   flutterfire configure
   ```

4. Ensure Firebase Remote Config is enabled and populated

5. Run the project locally

   ```bash
   flutter run -d chrome
   ```

---

## 🔥 Firebase Configuration Strategy

This project uses **Firebase client‑side configuration** combined with **Remote Config** for runtime values.

### Key design decisions:

* `firebase_options.dart` is generated using FlutterFire
* It **is safe to commit** (contains public client keys only)
* No sensitive runtime logic depends on hardcoded values
* Dynamic keys (EmailJS, feature flags) are fetched via **Firebase Remote Config**

This approach ensures:

* No environment secrets are leaked in UI code
* Keys can be rotated without redeploying the app
* The project remains safe even in a public repository

---

## 🌍 Environment Configuration (Firebase Remote Config)

The following configuration is expected in Firebase Remote Config (JSON format):

```json
{
  "emailjs_service_id": "<service_id>",
  "emailjs_template_id": "<template_id>",
  "emailjs_public_key": "<public_key>"
}
```

Usage notes:

* Loaded once at app startup
* Cached by Firebase SDK
* Used by Contact form submission logic
* Firestore writes occur regardless of email success/failure

---

## ✉️ Contact Form Architecture

The contact system is designed with **reliability and traceability**:

1. User submits contact form
2. Data is saved to **Firestore** (`contact_messages` collection)
3. Email is sent via **EmailJS**
4. Status is recorded:

    * `email_sent: true/false`
    * `email_error: <error message if any>`

This ensures:

* Messages are never lost
* Failures can be audited later
* EmailJS downtime does not break data capture

---

## ▶️ Running Locally

To start the project locally:

```bash
flutter run -d chrome
```

Notes:

* Uses Firebase Web configuration
* Firestore writes work in real‑time
* EmailJS sends real emails
* Hot reload supported

---

## 📦 Build & Deployment

### Local Production Build

```bash
flutter build web
```

### Hosting

* Firebase Hosting (`build/web`)
* SPA routing via `index.html` rewrite

### CI/CD (GitHub Actions)

Two pipelines are configured:

1. **Pull Request Preview**

    * Deploys preview channel
    * Used for testing changes

2. **Merge to `dev_build_upload`**

    * Triggers production deployment
    * Updates live site

All Firebase credentials are managed via **GitHub Secrets**.

---

## 🧠 Long‑Term Maintenance Notes

* Always review Flutter & Firebase changelogs before upgrades
* EmailJS templates should be versioned carefully
* Firestore schema should remain backward compatible
* Remote Config keys should never be deleted abruptly

---

## 🛠️ Tech Stack Summary

* **Frontend**: Flutter Web
* **Backend Services**: Firebase (Firestore, Hosting, Remote Config)
* **Email**: EmailJS
* **CI/CD**: GitHub Actions
* **AI R&D**: LangChain, ML Kit, ARKit demos

---

## 📄 License

This project is for **professional portfolio use**. Code reuse is permitted with attribution.

---

## 🙌 Author

**Mohit Rajpurohit**
Software Developer (Mobile • Web • AI)
