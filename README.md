# YieldPlus Farm Assistant - Mobile App

AI-Powered Farm Assistant Mobile Application built with Flutter.

## Features

- **AI-Powered Tools**: Soil analysis, crop planning, pest identification, water optimization, and market price estimation
- **Farm Management**: Create and manage multiple farms with full CRUD operations
- **Saved Plans**: Save and review your farming plans
- **Real-time Sync**: Seamless sync with web app via shared Supabase backend
- **Offline Support**: Local caching for offline access

## Tech Stack

- **Framework**: Flutter 3.x
- **Backend**: Supabase (shared with web app)
- **AI**: Gemini AI via Supabase Edge Functions
- **State Management**: Provider

## Prerequisites

- Flutter SDK 3.x or higher
- Dart 3.x or higher
- Android Studio / Xcode (for platform builds)

## Setup

1. Clone this repository
2. Navigate to project directory
3. Install dependencies:
   `\ash
   flutter pub get
   `\

4. Run the app:
   `\ash
   flutter run
   `\

## Build

### Android
`\ash
flutter build apk --release
`\

### iOS
`\ash
flutter build ios --release
`\

### Web
`\ash
flutter build web
`\

## Project Structure

`\
lib/
 main.dart              # Entry point
 core/                  # Constants, theme, utilities
 data/                  # Models and repositories
 services/              # API and business logic services
 presentation/          # UI screens and widgets
`\

## CI/CD

This project uses GitHub Actions for continuous integration:
- Automated testing on push/PR
- APK build for Android
- Web build for deployment

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

## License

MIT License
