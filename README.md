# Movies Database App

A Flutter application that displays trending and now-playing movies using The Movie Database (TMDB) API. Features include movie search with auto-complete, bookmarking, offline support, and deep linking for sharing movies.

## Download APK

 **[Download app-release.apk](https://drive.google.com/drive/folders/10GloDrXbjuHeJb1q8LK3yq0LPbErLCa6?usp=sharing)**

Download the latest APK from Google Drive to install and test the app on your Android device.

## Features

### Core Features

1. **Home Screen** - Displays trending movies and now-playing movies
2. **Movie Details** - Comprehensive movie information including cast, ratings, and overview
3. **Bookmarks** - Save favorite movies for quick access
4. **Offline Support** - All data cached locally for offline viewing
5. **Search** - Search movies with debounced auto-search (searches while typing)
6. **Deep Linking** - Share movies with others via deep links

### Technical Stack

- **Framework**: Flutter
- **Architecture**: Clean Architecture
- **State Management**: Provider
- **Networking**: Retrofit + Dio
- **Local Database**: SQLite (sqflite)
- **Pattern**: Repository Pattern
- **Image Caching**: cached_network_image
- **Deep Linking**: uni_links
- **Sharing**: share_plus
- **Search Debouncing**: RxDart

## Setup Instructions

### 1. Prerequisites

- Flutter SDK (>=3.5.1)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- TMDB API Key

### 2. Get TMDB API Key

1. Go to [TMDB](https://www.themoviedb.org/)
2. Create an account or sign in
3. Navigate to Settings > API
4. Request an API key (it's free)
5. Copy your API key

### 3. Configure API Key

Create a `.env` file in the root directory of the project:

```bash
cp .env.example .env
```

Then open the `.env` file and replace `your_api_key_here` with your actual TMDB API key:

```
TMDB_API_KEY=your_actual_api_key_here
```

**Important:** The `.env` file is gitignored for security. Never commit your API key to version control.

### 4. Install Dependencies

```bash
flutter pub get
```

### 5. Generate Code (JSON Serialization & Retrofit)

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 6. Run the App

```bash
flutter run
```

## Key Features

### Repository Pattern

The app implements the Repository Pattern to abstract data sources with offline-first approach.

### Offline Support

All movies fetched from the API are cached in SQLite. If network fails, data is loaded from local database.

### Search with Debouncing (Bonus Task #6)

Uses RxDart to automatically search after user stops typing (500ms delay). No search button needed!

### Deep Linking & Sharing (Bonus Task #7)

Movies can be shared via deep links. Format: `moviesapp://movie/{movieId}`

**Test on Android:**

```bash
adb shell am start -W -a android.intent.action.VIEW -d "moviesapp://movie/550"
```

**Test on iOS:**

```bash
xcrun simctl openurl booted "moviesapp://movie/550"
```
