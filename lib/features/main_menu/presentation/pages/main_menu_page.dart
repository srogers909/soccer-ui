import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/services/system_ui_service.dart';
import '../../../../core/services/save_game_service.dart';

/// Main menu page with immersive full-screen experience
class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  bool _hasSaveGame = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeScreen();
  }

  Future<void> _initializeScreen() async {
    // Enable immersive mode for full-screen gaming experience
    await SystemUIService.enableImmersiveMode();
    await SystemUIService.setPortraitOrientation();
    
    // Check for existing save game
    final hasSave = await SaveGameService.hasSaveGame();
    
    setState(() {
      _hasSaveGame = hasSave;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    // Reset system UI when leaving the main menu
    SystemUIService.disableImmersiveMode();
    super.dispose();
  }

  void _onNewGame() {
    // Navigate to league creator or game setup
    context.go('/league-creator');
  }

  void _onContinueGame() {
    if (_hasSaveGame) {
      // Navigate to dashboard to continue existing game
      context.go('/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: const Color(0xFF2D2D2D), // Dark grey background
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Game Title
                    Text(
                      'Tactics FC',
                      style: TextStyle(
                        fontSize: screenSize.width * 0.08, // Responsive font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    SizedBox(height: screenSize.height * 0.15), // Responsive spacing
                    
                    // New Game Button
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _onNewGame,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF2D2D2D),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'New Game',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Continue Game Button
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _hasSaveGame ? _onContinueGame : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _hasSaveGame ? Colors.white : Colors.grey[600],
                          foregroundColor: _hasSaveGame ? const Color(0xFF2D2D2D) : Colors.grey[400],
                          elevation: _hasSaveGame ? 4 : 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Continue Game',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: _hasSaveGame ? const Color(0xFF2D2D2D) : Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                    
                    if (!_hasSaveGame) ...[
                      const SizedBox(height: 12),
                      Text(
                        'No saved game found',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[400],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
      ),
    );
  }
}
