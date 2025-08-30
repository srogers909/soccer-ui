# ⚽ Soccer Manager UI

A sophisticated Flutter mobile application for soccer management simulation, featuring advanced Multi-BLoC architecture and seamless integration with realistic data generation. Built specifically for mobile devices with Galaxy S25 Ultra optimization.

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.9+-blue.svg)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey.svg)](https://flutter.dev/docs/development/tools/sdk/release-notes)

## 🌟 Features

### 📱 Modern Mobile-First Design
- **Responsive UI**: Optimized for Galaxy S25 Ultra and various screen sizes
- **Material Design 3**: Beautiful, consistent interface following Google's latest design principles
- **Dark/Light Themes**: Automatic system theme detection with custom soccer-themed styling
- **Smooth Animations**: Fluid transitions and engaging user interactions

### 🏗️ Advanced Architecture
- **Multi-BLoC State Management**: Robust state management using flutter_bloc pattern
- **Clean Architecture**: Feature-based organization with separation of concerns
- **Go Router Navigation**: Type-safe, declarative routing for smooth navigation flows
- **Repository Pattern**: Efficient data management and caching strategies

### 🎮 Core Management Features
- **📊 Dashboard**: Comprehensive overview with next match info, quick stats, and manager actions
- **👥 Squad Management**: Complete player roster with detailed statistics and performance tracking
- **⚽ Tactics & Formation**: Advanced tactical setup with formation visualization
- **💰 Transfer Market**: Player trading and contract management system
- **🏆 League Management**: View standings, fixtures, and league progression
- **💼 Financial Management**: Budget tracking, revenue streams, and financial planning

### 🔧 Advanced Generation Integration
- **Variable Squad Sizes**: Dynamic squad generation (18-32 players) based on team reputation
- **Realistic Data**: Integration with comprehensive soccer data generator
- **League Creator Wizard**: Step-by-step league creation with extensive customization
- **Cultural Authenticity**: Support for 20+ countries with authentic naming and structures

### 📊 Data Persistence & Performance
- **Local Storage**: Efficient data persistence using shared_preferences
- **JSON Serialization**: Fast data serialization with json_annotation
- **Memory Optimization**: Optimized for mobile device performance
- **Offline Support**: Full functionality without internet connection

## 🚀 Quick Start

### Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK 3.0+**: [Install Flutter](https://docs.flutter.dev/get-started/install)
- **Dart 3.9+**: Included with Flutter SDK
- **Android Studio** or **VS Code**: [IDE Setup](https://docs.flutter.dev/get-started/editor)
- **Android SDK**: For Android development
- **Xcode**: For iOS development (macOS only)

### Galaxy S25 Ultra Setup

For optimal Galaxy S25 Ultra development experience:

1. **Enable Developer Options**:
   ```bash
   Settings → About phone → Tap "Build number" 7 times
   ```

2. **Enable USB Debugging**:
   ```bash
   Settings → Developer options → USB debugging → Enable
   ```

3. **Connect Device**: Use USB-C cable and verify connection:
   ```bash
   flutter devices
   ```

### Installation

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd soccer-engine-dart-full/ui
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Generate code** (for JSON serialization):
   ```bash
   dart run build_runner build
   ```

4. **Run the app**:
   ```bash
   # For connected device
   flutter run
   
   # For specific device
   flutter run -d <device-id>
   
   # For Galaxy S25 Ultra (if multiple devices)
   flutter run -d SM-S928U  # Replace with your device ID
   ```

### First Launch

On first launch, the app will guide you through:

1. **Welcome Screen**: Introduction to soccer management features
2. **League Creation**: Step-by-step wizard to create your first league
3. **Team Selection**: Choose your team from generated realistic leagues
4. **Dashboard Tour**: Interactive tutorial of key features

## 📖 Detailed Usage

### 🏠 Dashboard Overview

The dashboard serves as your management command center:

```dart
// The dashboard automatically loads with:
// - Current game day and time
// - Next match information
// - Quick team statistics
// - Manager action shortcuts
```

**Key Dashboard Components:**
- **Day Info Card**: Current season, matchday, and date
- **Next Match Card**: Upcoming fixture with opponent details
- **Quick Stats Card**: Team form, league position, recent results
- **Manager Action Grid**: Quick access to all management features

### 👥 Squad Management

Comprehensive player management with advanced features:

```dart
// Squad features include:
// - Player roster with positions and ratings
// - Detailed player statistics and attributes
// - Performance tracking and development
// - Contract and transfer status
```

**Squad Organization:**
- **Formation View**: Visual representation of your tactical setup
- **Player List**: Sortable and filterable player roster
- **Statistics**: Detailed player performance metrics
- **Development**: Track player growth and potential

### ⚽ Tactical System

Advanced tactical management with realistic formations:

```dart
// Tactical options include:
// - Formation selection (4-4-2, 4-3-3, 3-5-2, etc.)
// - Player role assignments
// - Tactical instructions
// - Match-specific adjustments
```

**Tactical Features:**
- **Formation Builder**: Visual formation editor
- **Role Assignment**: Specific player instructions
- **Tactical Presets**: Save and load tactical setups
- **Match Analysis**: Post-match tactical performance

### 🏆 League Management

Complete league system with realistic progression:

```dart
// League features include:
// - Real-time league tables
// - Fixture schedules and results
// - Historical performance tracking
// - Cup competitions
```

### 🔧 League Creator Wizard

The League Creator provides a step-by-step process for generating realistic leagues:

```dart
// Step 1: Country Selection
final country = await showCountrySelection();

// Step 2: Configuration
final config = GenerationConfig.defaultForCountry(country);

// Step 3: Generation
final league = await leagueGenerator.generateCompleteLeague(
  country: country,
  config: config,
);

// Results in variable squad sizes:
// Manchester City: 28 players (high reputation)
// Brighton: 19 players (lower reputation)
```

**Wizard Steps:**
1. **Country Selection**: Choose from 20+ supported countries
2. **League Configuration**: Customize divisions, teams, and structure
3. **Generation Options**: Variable squad sizes, domestic player percentages
4. **Preview**: Review generated league before finalizing
5. **Team Selection**: Choose your management team

### 💰 Financial Management

Comprehensive budget and financial tracking:

```dart
// Financial tracking includes:
// - Transfer budget management
// - Player wage calculations
// - Revenue from matches and competitions
// - Financial fair play compliance
```

## 🏗️ Architecture Deep Dive

### Multi-BLoC State Management

The app uses a sophisticated Multi-BLoC architecture for state management:

```dart
MultiBlocProvider(
  providers: [
    BlocProvider<GameBloc>(
      create: (context) => GameBloc()..add(InitializeGameEvent()),
    ),
    BlocProvider<LeagueGenerationBloc>(
      create: (context) => LeagueGenerationBloc(),
    ),
    // Additional BLoCs for each feature
  ],
  child: MaterialApp.router(/* ... */),
)
```

**BLoC Structure:**
- **GameBloc**: Core game state and progression
- **LeagueGenerationBloc**: League creation and data generation
- **SquadBloc**: Player and team management
- **TacticsBloc**: Formation and tactical state
- **FinancesBloc**: Budget and financial tracking

### Feature-Based Organization

The codebase follows a clean, feature-based architecture:

```
lib/
├── core/                    # Shared utilities and themes
│   ├── models/             # Core data models
│   ├── theme/              # App theming and styling
│   └── utils/              # Utility functions
└── features/               # Feature modules
    ├── dashboard/          # Main dashboard
    ├── squad/              # Squad management
    ├── tactics/            # Tactical management
    ├── transfers/          # Transfer market
    ├── league/             # League and competitions
    ├── finances/           # Financial management
    └── game/               # Core game logic
```

### Integration Architecture

Seamless integration with engine and generator projects:

```dart
dependencies:
  soccer_engine:            # Match simulation engine
    path: ../engine
  soccer_data_generator:    # Realistic data generation
    path: ../generator
```

## 📱 Mobile Development Guide

### Screen Responsiveness

The app uses adaptive layouts for various screen sizes:

```dart
// Responsive design using ScreenUtils
class ScreenUtils {
  static bool isTablet(BuildContext context) => /* ... */;
  static bool isPhone(BuildContext context) => /* ... */;
  static double getScaledSize(BuildContext context, double size) => /* ... */;
}

// Usage in widgets
Widget build(BuildContext context) {
  final isTablet = ScreenUtils.isTablet(context);
  return GridView.count(
    crossAxisCount: isTablet ? 4 : 2,
    children: /* ... */,
  );
}
```

### Performance Optimization

**Memory Management:**
- Efficient BLoC state management with proper disposal
- Image caching and optimization
- Lazy loading for large datasets
- Background processing for data generation

**Battery Optimization:**
- Minimal background processing
- Efficient animation usage
- Smart refresh strategies
- Resource cleanup

### Testing on Galaxy S25 Ultra

**Device-Specific Optimizations:**
- High refresh rate support (120Hz)
- Edge-to-edge display utilization
- S Pen integration ready
- Optimized for large screen real estate

**Performance Testing:**
```bash
# Run performance profiling
flutter run --profile

# Memory usage analysis
flutter run --trace-startup

# Build optimization
flutter build apk --analyze-size
```

## ⚙️ Configuration & Customization

### Theme Customization

Customize the app's appearance with comprehensive theming:

```dart
// lib/core/theme/app_theme.dart
class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF2E7D32), // Soccer green
      brightness: Brightness.light,
    ),
    fontFamily: GoogleFonts.roboto().fontFamily,
    // Custom soccer-themed styling
  );
  
  static ThemeData get darkTheme => /* ... */;
}
```

### App Configuration

Configure various app behaviors:

```dart
// Shared preferences for user settings
class AppConfig {
  static const String selectedTeamKey = 'selected_team';
  static const String difficultyLevelKey = 'difficulty_level';
  static const String notificationsEnabledKey = 'notifications_enabled';
}
```

### Data Generation Settings

Customize league generation parameters:

```dart
// Default configuration for realistic gameplay
final config = GenerationConfig(
  playerConfig: PlayerConfig(
    useVariableSquadSizes: true,
    minSquadSize: 18,
    maxSquadSize: 32,
    reputationInfluence: 0.6,
    domesticPlayerPercentage: 75,
  ),
  // Additional configuration options
);
```

## 🧪 Testing and Quality Assurance

### Running Tests

Comprehensive testing suite for reliability:

```bash
# Run all tests
flutter test

# Run widget tests
flutter test test/widget_test.dart

# Run integration tests
flutter test integration_test/

# Test coverage report
flutter test --coverage
```

### Testing Strategy

**Unit Tests**: BLoC logic and business rules
**Widget Tests**: UI components and interactions
**Integration Tests**: Complete user workflows
**Golden Tests**: Visual regression testing

### Code Quality

**Linting and Formatting:**
```bash
# Analyze code quality
flutter analyze

# Format code
dart format lib/

# Check for unused dependencies
flutter pub deps
```

## 🔄 Data Flow and State Management

### BLoC Event Flow

Understanding the app's reactive data flow:

```dart
// Example: League Generation Flow
1. User selects country in LeagueCreatorPage
2. UI dispatches GenerateLeagueEvent to LeagueGenerationBloc
3. BLoC calls soccer_data_generator to create realistic league
4. Generated data flows to GameBloc for core game state
5. UI rebuilds automatically with new league data
```

### State Persistence

Data persistence strategy:

```dart
// Game state persistence
class GameRepository {
  static Future<void> saveGameState(GameState state) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('game_state', jsonEncode(state.toJson()));
  }
  
  static Future<GameState?> loadGameState() async {
    // Load and deserialize saved state
  }
}
```

## 🚀 Build and Deployment

### Building for Release

**Android APK:**
```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# App Bundle for Play Store
flutter build appbundle --release
```

**iOS App:**
```bash
# iOS build
flutter build ios --release

# Archive for App Store
flutter build ipa
```

### Galaxy S25 Ultra Optimization

**Build optimizations for Galaxy S25 Ultra:**
```bash
# Target arm64-v8a for optimal performance
flutter build apk --target-platform android-arm64 --release

# Enable obfuscation for release builds
flutter build apk --obfuscate --split-debug-info=build/debug-info
```

### Performance Profiling

```bash
# Profile app performance
flutter run --profile

# Analyze app size
flutter build apk --analyze-size

# Memory leak detection
flutter run --trace-startup
```

## 🔧 Development Workflow

### Adding New Features

Follow the established feature-based architecture:

1. **Create Feature Directory**:
   ```
   lib/features/new_feature/
   ├── presentation/
   │   ├── bloc/
   │   ├── pages/
   │   └── widgets/
   ├── data/
   │   ├── models/
   │   └── repositories/
   └── domain/
       ├── entities/
       └── use_cases/
   ```

2. **Implement BLoC Pattern**:
   ```dart
   class NewFeatureBloc extends Bloc<NewFeatureEvent, NewFeatureState> {
     NewFeatureBloc() : super(NewFeatureInitial()) {
       on<LoadNewFeatureEvent>(_onLoadNewFeature);
     }
   }
   ```

3. **Add Navigation Route**:
   ```dart
   GoRoute(
     path: '/new-feature',
     name: 'new-feature',
     builder: (context, state) => const NewFeaturePage(),
   ),
   ```

### Code Generation

Regenerate code when models change:

```bash
# Watch mode for development
dart run build_runner watch

# One-time generation
dart run build_runner build

# Clean and rebuild
dart run build_runner build --delete-conflicting-outputs
```

## 🤝 Contributing

We welcome contributions to improve the Soccer Manager UI! Here's how to get started:

### Development Setup

1. **Fork and Clone**:
   ```bash
   git clone https://github.com/yourusername/soccer-engine-dart-full.git
   cd soccer-engine-dart-full/ui
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   dart run build_runner build
   ```

3. **Create Feature Branch**:
   ```bash
   git checkout -b feature/amazing-ui-feature
   ```

### Development Guidelines

**Code Style:**
- Follow Flutter/Dart style guide
- Use meaningful variable and function names
- Add documentation for public APIs
- Maintain consistent file organization

**Testing Requirements:**
- Write unit tests for BLoC logic
- Create widget tests for UI components
- Add integration tests for user workflows
- Maintain test coverage above 80%

**UI/UX Guidelines:**
- Follow Material Design 3 principles
- Ensure responsive design for all screen sizes
- Test on both Android and iOS
- Optimize for Galaxy S25 Ultra experience

## 📋 Roadmap

### Version 1.1.0 Goals
- **Match Engine Integration**: Real-time match simulation and visualization
- **Advanced Statistics**: Detailed player and team analytics
- **Career Mode**: Long-term management progression
- **Cloud Save**: Cross-device game synchronization

### Version 1.2.0 Goals
- **Multiplayer Features**: Online leagues and tournaments
- **Custom Competitions**: User-created tournament formats
- **Enhanced AI**: Improved computer-controlled team behavior
- **Advanced Tactics**: More sophisticated tactical options

### Long-term Vision
- **VR/AR Integration**: Immersive match viewing experience
- **Machine Learning**: AI-powered player development and transfer recommendations
- **Global Leaderboards**: Worldwide manager rankings
- **Esports Integration**: Competitive soccer management tournaments

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](../LICENSE) file for details.

## 🆘 Support and Resources

### Documentation
- **Flutter Documentation**: [docs.flutter.dev](https://docs.flutter.dev)
- **BLoC Library**: [bloclibrary.dev](https://bloclibrary.dev)
- **Go Router**: [pub.dev/packages/go_router](https://pub.dev/packages/go_router)

### Development Resources
- **Material Design 3**: [m3.material.io](https://m3.material.io)
- **Galaxy S25 Ultra Guidelines**: Samsung Developer Documentation
- **Flutter Performance**: [docs.flutter.dev/perf](https://docs.flutter.dev/perf)

### Getting Help
- **Issues**: Report bugs via GitHub Issues
- **Discussions**: Join project discussions for feature requests
- **Testing**: Run integration tests to see full feature demos

### Quick Development Commands

```bash
# Start development with hot reload
flutter run

# Run tests with coverage
flutter test --coverage

# Analyze code quality
flutter analyze

# Format all Dart files
dart format .

# Update dependencies
flutter pub upgrade

# Build release APK
flutter build apk --release
```

---

**Ready to manage your soccer empire? Install Flutter, clone the repository, and start your journey to soccer management greatness! ⚽🏆**
