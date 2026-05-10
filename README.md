# Smart Farmer Land Assistant

AI Powered Multilingual Land Record Verification System

---

## Overview

Smart Farmer Land Assistant is a Flutter-based mobile application designed to help farmers easily access and verify land records using voice interaction and biometric authentication.

The system was built as a hackathon MVP to solve the problem of low adoption of digital land record systems among farmers.

---

# Problem Statement

Many farmers do not use existing digital land record systems because:

* records are difficult to access
* systems are not available in local languages
* low digital literacy
* lack of trust in online records
* dependence on middlemen and agents

---

# Our Solution

This application provides:

* Voice-based interaction
* Multilingual support
* Fingerprint authentication
* QR secured certificates
* Automatic PDF generation
* Farmer-friendly UI

Farmers only need to:

1. Open app
2. Select language
3. Speak land number
4. Verify identity
5. Receive certificate

---

# Features

## Multilingual Voice Assistant

Supports:

* English
* Kannada
* Hindi

The app speaks and listens in the selected language.

---

## Voice-Based Land Search

Farmers can simply speak their land number instead of typing.

---

## Biometric Authentication

Fingerprint authentication improves:

* security
* trust
* identity verification

---

## QR-Based Land Certificate

The system generates:

* government-style land certificate
* QR code verification
* farmer details
* land details

---

## Automatic PDF Generation

Certificates are automatically generated as downloadable PDF files.

---

# Technologies Used

* Flutter
* Dart
* speech_to_text
* flutter_tts
* local_auth
* qr_flutter
* pdf
* printing

---

# App Workflow

```text
User opens app
↓
Select language
↓
App asks for land number
↓
Farmer speaks land number
↓
Fingerprint verification
↓
Land certificate generated
↓
QR PDF created
↓
Voice confirmation
```

---

# Demo Land Numbers

Use these sample land numbers:

```text
ka 102938
ka 204050
land 777
```

---

# Installation

## Clone Repository

```bash
git clone <your-github-repository-link>
```

---

## Open Project

```bash
cd farmer_land_app
```

---

## Install Dependencies

```bash
flutter pub get
```

---

## Run App

```bash
flutter run
```

---

# Build APK

```bash
flutter build apk --release
```

APK location:

```text
build/app/outputs/flutter-apk/app-release.apk
```

---

# Future Improvements

* Aadhaar integration
* Real government database connection
* Face authentication
* Cloud storage
* Offline support
* SMS notifications
* Real-time land verification

---

# Real World Impact

This solution helps:

* rural farmers
* digitally illiterate users
* government land services
* secure document verification
* fraud reduction

---

# Authors

Hackathon Project by:

* Sharan
* Muthahar

---

# License

This project is developed for educational and hackathon purposes.
