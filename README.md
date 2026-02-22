# 360 Creator - Flutter Application

A comprehensive social media marketing agency platform built with Flutter, MobX, and Supabase.

## Features

- **Home Feed** - Video post grid with infinite scroll, likes, and engagement metrics
- **Inquiry System** - Contact form with project type, budget, and timeline selection
- **Booking System** - Book projects with reference to portfolio videos
- **About Page** - Agency info, team members, testimonials, and contact details
- **Video Detail** - Full video player with project information and CTAs

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter (Web + Mobile) |
| State Management | MobX |
| Backend | Supabase (PostgreSQL) |
| Navigation | GoRouter |
| Image Caching | cached_network_image |
| Animations | Shimmer |

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── config/                      # App configuration
│   ├── supabase_config.dart
│   └── app_constants.dart
├── data/
│   ├── models/                  # Data models
│   ├── repositories/            # Data access layer
│   └── providers/
├── features/
│   ├── home/                    # Home feed
│   ├── video_detail/            # Video detail screen
│   ├── inquiry/                 # Inquiry form
│   ├── booking/                 # Booking form
│   └── about/                   # About page
├── shared/
│   ├── widgets/                 # Reusable components
│   ├── theme/                   # Colors, text styles, theme
│   └── utils/                   # Helpers and validators
└── router/                      # Navigation
    └── app_router.dart
```

## Setup Instructions

### 1. Prerequisites
- Flutter SDK 3.0+
- Dart SDK 3.0+
- A Supabase account

### 2. Supabase Setup
1. Create a new Supabase project at [supabase.com](https://supabase.com)
2. Run `supabase_schema.sql` in the Supabase SQL Editor
3. Copy your project URL and anon key

### 3. Configure Credentials
Update `lib/config/supabase_config.dart`:
```dart
static const String supabaseUrl = 'YOUR_SUPABASE_URL';
static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
```

Also uncomment in `lib/main.dart`:
```dart
await SupabaseConfig.initialize();
```

And set `useDemoData = false` in `lib/features/home/store/home_store.dart`.

### 4. Install Dependencies
```bash
flutter pub get
```

### 5. Generate MobX Code (optional - .g.dart files are pre-generated)
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 6. Run the App
```bash
# Web
flutter run -d chrome

# Android
flutter run -d android

# iOS
flutter run -d ios
```

## Color Palette

| Color | Hex | Usage |
|-------|-----|-------|
| Primary | `#FF6B6B` | Main CTA, highlights |
| Secondary | `#4ECDC4` | Hashtags, accents |
| Accent | `#FFD93D` | Stars, badges |
| Background | `#F7F7F7` | App background |
| Text | `#2C3E50` | Primary text |

## Database Tables

- `videos_posts` - Video content portfolio
- `inquiries` - Client inquiry submissions
- `bookings` - Project booking requests
- `agency_info` - Agency details, team, testimonials

## Demo Mode

The app ships with demo data enabled (`useDemoData = true` in `HomeStore`).
Toggle this to `false` after configuring Supabase to use live data.

## Deployment

### Web (Vercel/Netlify)
```bash
flutter build web --release
# Deploy the build/web directory
```

### Android
```bash
flutter build apk --release
# or for Play Store
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## License

&copy; 2024 360 Creator. All rights reserved.