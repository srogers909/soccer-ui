import 'package:flutter/services.dart';

/// Service for managing system UI visibility and immersive mode
class SystemUIService {
  /// Enable immersive mode - hides status bar and navigation bar
  static Future<void> enableImmersiveMode() async {
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
      overlays: [],
    );
  }

  /// Disable immersive mode - shows status bar and navigation bar
  static Future<void> disableImmersiveMode() async {
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: SystemUiOverlay.values,
    );
  }

  /// Set preferred orientation to portrait
  static Future<void> setPortraitOrientation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  /// Reset orientation to system default
  static Future<void> resetOrientation() async {
    await SystemChrome.setPreferredOrientations([]);
  }
}
