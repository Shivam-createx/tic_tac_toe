# ❌ Tic Tac Toe Multiplayer Game ⭕

A modern, real-time multiplayer **Tic Tac Toe** application built with **Flutter** (for cross-platform frontend clients) and **Node.js with Socket.io** (for real-time server-side state synchronization and matchmaking).

This project supports live peer-to-peer multiplayer rooms, live player status updates, interactive state management, and a clean, responsive user experience.

---

## 🚀 Live Demo & Architecture

- **Frontend Client:** Hosted on **Firebase Hosting** (`https://tic-tac-toe-number1.web.app`)
- **Backend WebSocket Server:** Deployed on **Railway**

---

## ✨ Features

- **Real-Time Multiplayer:** Instant room creation, joining via room codes, and synchronized gameplay via WebSockets (`Socket.io`).
- **Cross-Platform Frontend:** Built using Flutter, capable of running smoothly on Web, Android, and iOS.
- **State Management:** Reactive state handled cleanly to track player turns, score points, active game boards, and live room states.
- **Robust Input & Error Handling:** Input sanitization for usernames, length validations, and clean socket error recovery.
- **Persistent Backend:** Scalable Node.js / Express backend with robust connection handling and room isolation.

---

## 🛠️ Tech Stack

### Frontend

- **Framework:** [Flutter](https://flutter.dev/) (Dart)
- **Networking:** `socket_io_client`
- **Hosting:** Firebase Hosting

### Backend

- **Runtime:** [Node.js](https://nodejs.org/) & [Express](https://expressjs.com/)
- **Real-Time Engine:** [Socket.io](https://socket.io/)
- **Hosting:** Railway

---

## 📂 Project Structure

```text
tic-tac-toe/
│
├── lib/                     # Flutter frontend source code
│   ├── models/              # Data models (e.g., Player, Room)
│   ├── providers/           # State providers / controllers
│   ├── screens/             # UI screens (Game, Lobby, Main Screen)
│   └── widgets/             # Reusable UI components & dialogs
│
├── server/                  # Node.js backend source code
│   ├── index.js             # Main socket server entry point
│   └── package.json         # Backend dependencies
│
├── firebase.json            # Firebase hosting configurations
└── pubspec.yaml             # Flutter dependencies & metadata
```

---

## ⚙️ Getting Started Locally

If you want to run or develop this project on your local machine, follow these steps:

### 1. Clone the Repository

```bash
git clone https://github.com/Shivam-createx/tic_tac_toe.git
cd tic_tac_toe
```

### 2. Set Up & Run the Backend Server

```bash
cd server
npm install
npm run dev
```

_(The local server will start on port `3000`)_

### 3. Run the Flutter App

Open a separate terminal window at the root of the project:

```bash
flutter pub get
flutter run
```

---

## 🚀 Deployment

### Backend (Railway)

1. Push your `server` code to a standalone repository.
2. Link it to [Railway](https://railway.app/).
3. Ensure your `package.json` contains a proper start script (`"start": "node index.js"`).
4. Railway will automatically build and expose your live WebSocket endpoint.

### Frontend (Firebase Hosting)

1. Initialize Firebase in your root project:
   ```bash
   firebase init hosting
   ```
2. Build the web app for production:
   ```bash
   flutter build web --release
   ```
3. Deploy to Firebase:
   ```bash
   firebase deploy --only hosting
   ```

---

## 👨‍💻 Author

Built by **Shivam** as an advanced full-stack real-time application project.
