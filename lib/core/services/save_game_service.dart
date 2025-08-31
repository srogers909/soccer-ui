import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing save game data
class SaveGameService {
  static const String _saveGameKey = 'has_save_game';
  static const String _gameDataKey = 'game_data';

  /// Check if a save game exists
  static Future<bool> hasSaveGame() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_saveGameKey) ?? false;
  }

  /// Mark that a save game exists
  static Future<void> markSaveGameExists() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_saveGameKey, true);
  }

  /// Clear save game data
  static Future<void> clearSaveGame() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_saveGameKey);
    await prefs.remove(_gameDataKey);
  }

  /// Save game data (basic implementation)
  static Future<void> saveGameData(String gameData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_gameDataKey, gameData);
    await markSaveGameExists();
  }

  /// Load game data
  static Future<String?> loadGameData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_gameDataKey);
  }
}
