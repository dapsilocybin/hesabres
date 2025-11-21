import 'package:flutter/material.dart';

class AppTheme {
  // 🌱 Default soft-blue seed
  static const Color _defaultSeedColor = Color(0xFF8AB6F9);

  // 🩵 Light Neomorphic Theme
  static ThemeData lightTheme({Color? seedColor}) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor ?? _defaultSeedColor,
      brightness: Brightness.light,
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      fontFamily: 'Poppins',
      scaffoldBackgroundColor: const Color(0xFFEFF3FA),

      // 🌤️ General style — soft and clean
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 6,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadowColor: colorScheme.primary.withOpacity(0.4),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),

      // 🧱 Card design (neomorphic effect)
      cardTheme: CardThemeData(
        color: const Color(0xFFEFF3FA),
        elevation: 6,
        shadowColor: Colors.black12,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),

      // 🧊 Input fields (TextFormField, etc.)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFEFF3FA),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(
          color: colorScheme.onSurface.withOpacity(0.5),
        ),
        prefixIconColor: colorScheme.primary.withOpacity(0.7),
      ),

      // 🧭 AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFFEFF3FA),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: colorScheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        iconTheme: IconThemeData(color: colorScheme.primary),
      ),

      // 🔘 Floating Action Button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // 🧾 Texts
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: colorScheme.onBackground,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: colorScheme.onBackground.withOpacity(0.85),
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: colorScheme.onBackground.withOpacity(0.75),
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: colorScheme.onBackground.withOpacity(0.65),
        ),
      ),

      // ⚙️ Neomorphic touch for containers (via default box shadows)
      extensions: <ThemeExtension<dynamic>>[
        NeomorphismStyleExtension.light(),
      ],
    );
  }

  // 🌙 Dark Neomorphic Theme
  static ThemeData darkTheme({Color? seedColor}) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor ?? _defaultSeedColor,
      brightness: Brightness.dark,
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      fontFamily: 'Poppins',
      scaffoldBackgroundColor: const Color(0xFF181A1F),

      cardTheme: CardThemeData(
        color: const Color(0xFF1E2228),
        elevation: 8,
        shadowColor: Colors.black54,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 6,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadowColor: colorScheme.primary.withOpacity(0.5),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1E2228),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(
          color: colorScheme.onSurface.withOpacity(0.5),
        ),
        prefixIconColor: colorScheme.primary.withOpacity(0.7),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF181A1F),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: colorScheme.onBackground,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        iconTheme: IconThemeData(color: colorScheme.primary),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: colorScheme.onBackground,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: colorScheme.onBackground.withOpacity(0.8),
        ),
      ),

      extensions: <ThemeExtension<dynamic>>[
        NeomorphismStyleExtension.dark(),
      ],
    );
  }
}

/// 🌟 Custom Theme Extension for neomorphic container shadows
@immutable
class NeomorphismStyleExtension extends ThemeExtension<NeomorphismStyleExtension> {
  final List<BoxShadow> shadows;
  final Color backgroundColor;

  const NeomorphismStyleExtension({
    required this.shadows,
    required this.backgroundColor,
  });

  factory NeomorphismStyleExtension.light() {
    return NeomorphismStyleExtension(
      backgroundColor: const Color(0xFFEFF3FA),
      shadows: [
        const BoxShadow(
          color: Colors.white,
          offset: Offset(-6, -6),
          blurRadius: 12,
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: const Offset(6, 6),
          blurRadius: 12,
        ),
      ],
    );
  }

  factory NeomorphismStyleExtension.dark() {
    return NeomorphismStyleExtension(
      backgroundColor: const Color(0xFF1E2228),
      shadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.6),
          offset: const Offset(6, 6),
          blurRadius: 12,
        ),
        BoxShadow(
          color: Colors.white.withOpacity(0.05),
          offset: const Offset(-6, -6),
          blurRadius: 12,
        ),
      ],
    );
  }

  @override
  NeomorphismStyleExtension copyWith({
    List<BoxShadow>? shadows,
    Color? backgroundColor,
  }) {
    return NeomorphismStyleExtension(
      shadows: shadows ?? this.shadows,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  NeomorphismStyleExtension lerp(
      ThemeExtension<NeomorphismStyleExtension>? other, double t) {
    if (other is! NeomorphismStyleExtension) return this;
    return NeomorphismStyleExtension(
      shadows: other.shadows,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
    );
  }
}
  