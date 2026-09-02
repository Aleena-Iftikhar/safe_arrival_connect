# SafeArrive 🛡️

> Arrive Safe. Stay Connected.

SafeArrive is a Flutter app that lets you set up a journey — destination, arrival message, and chosen contacts — and keeps a saved record of it, so your loved ones know where you're headed and when you've arrived. Built for students, working professionals, and solo travelers who want a simple way to keep family informed.

---

## The Problem

Every day, people — especially students living in hostels and women traveling alone — have to manually remember to text their families when they reach somewhere. It's easy to forget, and the uncertainty causes unnecessary worry. SafeArrive makes it simple to set up a journey once and keep a clear, saved history of where you went and what message was meant to reach your contacts.

---

## Features

- 📍 **Journey Setup** — set a destination name, address, and pin location on the map
- 💬 **Custom Arrival Message** — write a personalized message for your contacts
- 👨‍👩‍👧 **Recipient Selection** — choose one or more contacts to notify per journey
- 🏠 **Dashboard** — home screen always shows your most recently saved journey
- 🕘 **Journey History** — scrollable list of all previously saved journeys with pull-to-refresh
- ⚡ **Live Sync** — save a journey and it instantly reflects on both the dashboard and history, no manual refresh needed
- 🔌 **REST API Backend** — Flask + MySQL backend persists all journey data

---

## Tech Stack

**Frontend**
- Flutter (Dart)
- [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) — state management (`AsyncNotifierProvider` for async backend data)
- [http](https://pub.dev/packages/http) — REST API communication
- Material Design components with a custom UI theme

**Backend**
- Python (Flask)
- Flask-CORS
- MySQL (via `mysql-connector-python`)
- `python-dotenv` for environment configuration

---

## Project Architecture

```
lib/
 ├── main.dart                  # App entry point, wrapped in ProviderScope
 ├── homeScreen.dart            # Dashboard — shows latest journey
 ├── destinationSetup.dart      # Setup Journey screen (create/save)
 ├── historyPage.dart           # Full journey history list
 ├── models/
 │    └── journey_model.dart    # Journey data model
 ├── providers/
 │    └── journey_provider.dart # Riverpod AsyncNotifier for journey state
 └── commonWidget/
      └── bottomNavigationBar.dart

backend/
 └── app.py                     # Flask REST API (Journey CRUD endpoints)
```

### State Management Flow

The app uses a single `journeyProvider` (Riverpod `AsyncNotifier`) as the source of truth for all journey data fetched from the backend:

- **Dashboard** watches a derived `latestJourneyProvider` to always display the most recent journey.
- **History** watches `journeyProvider` directly to render the full list.
- **Setup Journey** calls `saveJourney()` on the provider, which posts to the backend and then refreshes the shared state — so both Dashboard and History update automatically without extra API calls or manual navigation logic.

---

## API Endpoints

| Method | Endpoint         | Description                          |
|--------|------------------|---------------------------------------|
| POST   | `/journey`       | Save a new journey                    |
| GET    | `/journey/latest`| Fetch the most recently saved journey |
| GET    | `/journey/all`   | Fetch the last 20 saved journeys      |

---

## Getting Started

### Prerequisites
- Flutter SDK installed
- Python 3.x
- MySQL server running locally
- Android emulator or physical device

### Backend Setup

```bash
cd backend
pip install flask flask-cors mysql-connector-python python-dotenv
```

Create a `.env` file in the backend folder:
```
DB_PASSWORD=your_mysql_password
```

Create the database and table:
```sql
CREATE DATABASE safearrive;

USE safearrive;

CREATE TABLE journeys (
    id INT AUTO_INCREMENT PRIMARY KEY,
    destination_name VARCHAR(255) NOT NULL,
    destination_address VARCHAR(255) NOT NULL,
    message TEXT,
    contacts JSON,
    status VARCHAR(50) DEFAULT 'active',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

Run the server:
```bash
python app.py
```
The API will be available at `http://localhost:3000`.

### Flutter App Setup

```bash
flutter pub get
flutter run
```

> **Note:** The app connects to `http://10.0.2.2:3000` by default, which points to your local machine's `localhost` when running on the **Android emulator**. If you're using a physical device, update the `baseUrl` in `journey_provider.dart` to your machine's local network IP.

---

## Roadmap

- [ ] Automatic GPS-based arrival detection
- [ ] Auto-send arrival message via WhatsApp/SMS
- [ ] Delay alerts if not arrived within expected time
- [ ] User authentication (multi-user support)
- [ ] Multilingual support (English, Urdu, Arabic)
