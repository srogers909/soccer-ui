import 'package:flutter/material.dart';

class ScreenUtils {
  static const double galaxyS25UltraWidth = 1440.0;
  static const double galaxyS25UltraHeight = 3088.0;
  static const double galaxyS25UltraAspectRatio = 19.3 / 9.0;

  /// Check if the current device is likely a Galaxy S25 Ultra based on screen dimensions
  static bool isGalaxyS25Ultra(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.height / size.width;
    
    // Allow some tolerance for different DPI scaling
    return deviceRatio > 2.0 && deviceRatio < 2.3;
  }

  /// Get responsive grid count based on screen width and device type
  static int getResponsiveGridCount(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    
    if (isGalaxyS25Ultra(context)) {
      // Galaxy S25 Ultra specific optimizations
      return width > 800 ? 3 : 2;
    }
    
    // General responsive breakpoints
    if (width > 1200) return 4;
    if (width > 800) return 3;
    if (width > 600) return 2;
    return 2;
  }

  /// Get appropriate card aspect ratio for the device
  static double getCardAspectRatio(BuildContext context) {
    if (isGalaxyS25Ultra(context)) {
      return 1.5; // Optimized for Galaxy S25 Ultra
    }
    return 1.4; // Default for other devices
  }

  /// Get safe area paddings optimized for Galaxy S25 Ultra
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    
    if (isGalaxyS25Ultra(context)) {
      // Account for the curved edges and punch hole camera
      return EdgeInsets.only(
        top: padding.top + 8,
        bottom: padding.bottom + 8,
        left: padding.left + 4,
        right: padding.right + 4,
      );
    }
    
    return padding;
  }

  /// Get optimized font scaling for high-density displays
  static double getFontScale(BuildContext context) {
    final textScaler = MediaQuery.of(context).textScaler;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    
    if (isGalaxyS25Ultra(context)) {
      // Ensure text remains readable on high-density display
      return (textScaler.scale(1.0) * 0.95).clamp(0.8, 1.2);
    }
    
    return textScaler.scale(1.0);
  }

  /// Check if device is in landscape mode
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Get responsive spacing based on screen size
  static double getResponsiveSpacing(BuildContext context, {double baseSpacing = 16}) {
    final size = MediaQuery.of(context).size;
    final shortestSide = size.shortestSide;
    
    if (shortestSide > 800) {
      return baseSpacing * 1.5;
    } else if (shortestSide > 600) {
      return baseSpacing * 1.2;
    }
    
    return baseSpacing;
  }
}
