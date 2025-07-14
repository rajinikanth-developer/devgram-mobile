# 🚀 Devgram - A Social Networking App for Developers

Devgram is a simple yet functional **social networking mobile app** built with **Flutter**, specifically designed for developers. It enables users to share text and image posts, like content, and manage their personal feed and profile.

## 📱 Features

### 🔐 Authentication
- **Sign-up** with email and password (with basic validation)
- **Auto-login** for returning users (persistent login using local storage)

### 📰 Feed Screen
- Displays a **list of posts** shared by users
- Posts support:
  - **Text-based content**
  - **Image-based content**
  - **Double-tap to like** posts (react feature)

### 👤 Profile Screen (Tab Navigation)
- View **logged-in user's profile**
- See a **list of all posts created** by the user
  
### ✏️ Create Post
- Create and publish new posts
- Post options:
  - **Text content**
  - **Image content**(optional)
  - Optional **description**

### 🚪 Logout
- Secure **logout functionality**
- Logging in with another user immediately shows **their personalized feed**

---

## 🛠️ Tech Stack

- **Flutter** (Dart)
- **Hive** (for storage)
- **State Management:BLoC**
---

## 📦 Installation

1. **Clone the repo:**

git clone https://github.com/rajinikanth-developer/devgram-mobile.git
cd devgram-mobile
flutter pub get
flutter run
