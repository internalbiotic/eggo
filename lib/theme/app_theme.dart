import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the application.
/// Implements Contemporary Egyptian Minimalism with Desert Modernism color palette
/// optimized for Egypt's restaurant and tourism discovery mobile experience.
class AppTheme {
  AppTheme._();

  // Desert Modernism Color Palette - Warm, sophisticated colors inspired by Egypt's natural landscape
  static const Color primaryLight = Color(
      0xFFD4A574); // Warm gold for primary actions and Egyptian cultural connection
  static const Color primaryVariantLight =
      Color(0xFFE8B86D); // Lighter gold for highlights and active states
  static const Color secondaryLight = Color(
      0xFF2C5F5D); // Deep turquoise for secondary actions and trust indicators
  static const Color secondaryVariantLight =
      Color(0xFF4A7C59); // Muted green for confirmations and positive actions
  static const Color backgroundLight = Color(
      0xFFFEFCF8); // Soft off-white reducing eye strain during extended mobile sessions
  static const Color surfaceLight =
      Color(0xFFFFFFFF); // Pure white for cards and elevated content
  static const Color errorLight =
      Color(0xFFA0522D); // Warm brown-red for errors, culturally sensitive
  static const Color warningLight =
      Color(0xFFB8860B); // Dark goldenrod for alerts maintaining brand harmony
  static const Color successLight =
      Color(0xFF4A7C59); // Muted green for confirmations
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color onSecondaryLight = Color(0xFFFFFFFF);
  static const Color onBackgroundLight =
      Color(0xFF1A1A1A); // Near-black for optimal readability
  static const Color onSurfaceLight = Color(0xFF1A1A1A);
  static const Color onErrorLight = Color(0xFFFFFFFF);

  // Dark theme colors maintaining cultural authenticity
  static const Color primaryDark =
      Color(0xFFE8B86D); // Lighter gold for dark theme visibility
  static const Color primaryVariantDark =
      Color(0xFFD4A574); // Original gold as variant
  static const Color secondaryDark =
      Color(0xFF4A7C59); // Muted green for dark theme
  static const Color secondaryVariantDark =
      Color(0xFF2C5F5D); // Deep turquoise as variant
  static const Color backgroundDark =
      Color(0xFF121212); // Standard dark background
  static const Color surfaceDark =
      Color(0xFF1E1E1E); // Elevated surface for dark theme
  static const Color errorDark =
      Color(0xFFD4A574); // Use primary color for errors in dark theme
  static const Color onPrimaryDark = Color(0xFF1A1A1A);
  static const Color onSecondaryDark = Color(0xFFFFFFFF);
  static const Color onBackgroundDark = Color(0xFFFFFFFF);
  static const Color onSurfaceDark = Color(0xFFFFFFFF);
  static const Color onErrorDark = Color(0xFF1A1A1A);

  // Text colors with proper emphasis levels
  static const Color textPrimaryLight =
      Color(0xFF1A1A1A); // Near-black for optimal readability
  static const Color textSecondaryLight =
      Color(0xFF666666); // Medium gray for supporting information
  static const Color textDisabledLight =
      Color(0xFF999999); // Light gray for disabled states

  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFCCCCCC);
  static const Color textDisabledDark = Color(0xFF888888);

  // Shadow and divider colors for subtle elevation
  static const Color shadowLight =
      Color(0x33000000); // 20% opacity black for subtle depth
  static const Color shadowDark =
      Color(0x33FFFFFF); // 20% opacity white for dark theme
  static const Color dividerLight =
      Color(0x1A000000); // 10% opacity for minimal borders
  static const Color dividerDark = Color(0x1AFFFFFF);

  /// Light theme implementing Contemporary Egyptian Minimalism
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: primaryLight,
          onPrimary: onPrimaryLight,
          primaryContainer: primaryVariantLight,
          onPrimaryContainer: onPrimaryLight,
          secondary: secondaryLight,
          onSecondary: onSecondaryLight,
          secondaryContainer: secondaryVariantLight,
          onSecondaryContainer: onSecondaryLight,
          tertiary: warningLight,
          onTertiary: onPrimaryLight,
          tertiaryContainer: successLight,
          onTertiaryContainer: onSecondaryLight,
          error: errorLight,
          onError: onErrorLight,
          surface: surfaceLight,
          onSurface: onSurfaceLight,
          onSurfaceVariant: textSecondaryLight,
          outline: dividerLight,
          outlineVariant: dividerLight.withValues(alpha: 0.5),
          shadow: shadowLight,
          scrim: shadowLight,
          inverseSurface: surfaceDark,
          onInverseSurface: onSurfaceDark,
          inversePrimary: primaryDark),
      scaffoldBackgroundColor: backgroundLight,
      cardColor: surfaceLight,
      dividerColor: dividerLight,

      // AppBar theme for contextual navigation
      appBarTheme: AppBarTheme(
          backgroundColor: backgroundLight,
          foregroundColor: textPrimaryLight,
          elevation: 0,
          scrolledUnderElevation: 2,
          shadowColor: shadowLight,
          surfaceTintColor: Colors.transparent,
          titleTextStyle: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: textPrimaryLight),
          iconTheme: const IconThemeData(color: textPrimaryLight, size: 24)),

      // Card theme with subtle elevation for location-aware cards
      cardTheme: CardTheme(
          color: surfaceLight,
          elevation: 2,
          shadowColor: shadowLight,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),

      // Bottom navigation for primary discovery
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: surfaceLight,
          selectedItemColor: primaryLight,
          unselectedItemColor: textSecondaryLight,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          selectedLabelStyle:
              GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
          unselectedLabelStyle:
              GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400)),

      // Floating action button for quick actions
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryLight,
          foregroundColor: onPrimaryLight,
          elevation: 6,
          shape: CircleBorder()),

      // Button themes with Egyptian cultural aesthetics
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: onPrimaryLight,
              backgroundColor: primaryLight,
              elevation: 2,
              shadowColor: shadowLight,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w500))),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              foregroundColor: primaryLight,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              side: const BorderSide(color: primaryLight, width: 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w500))),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: primaryLight,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w500))),

      // Typography with bilingual support
      textTheme: _buildTextTheme(isLight: true),

      // Input decoration for forms with cultural sensitivity
      inputDecorationTheme: InputDecorationTheme(
          fillColor: surfaceLight,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: dividerLight)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: dividerLight)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: primaryLight, width: 2)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: errorLight)),
          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: errorLight, width: 2)),
          labelStyle: GoogleFonts.inter(color: textSecondaryLight, fontSize: 16, fontWeight: FontWeight.w400),
          hintStyle: GoogleFonts.inter(color: textDisabledLight, fontSize: 16, fontWeight: FontWeight.w400),
          errorStyle: GoogleFonts.inter(color: errorLight, fontSize: 12, fontWeight: FontWeight.w400)),

      // Interactive elements with micro-feedback
      switchTheme: SwitchThemeData(thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight;
        }
        return textDisabledLight;
      }), trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight.withValues(alpha: 0.3);
        }
        return textDisabledLight.withValues(alpha: 0.3);
      })),
      checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return primaryLight;
            }
            return Colors.transparent;
          }),
          checkColor: WidgetStateProperty.all(onPrimaryLight),
          side: const BorderSide(color: textSecondaryLight, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
      radioTheme: RadioThemeData(fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight;
        }
        return textSecondaryLight;
      })),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: primaryLight, linearTrackColor: dividerLight, circularTrackColor: dividerLight),
      sliderTheme: SliderThemeData(activeTrackColor: primaryLight, thumbColor: primaryLight, overlayColor: primaryLight.withValues(alpha: 0.2), inactiveTrackColor: dividerLight, valueIndicatorColor: primaryLight, valueIndicatorTextStyle: GoogleFonts.jetBrainsMono(color: onPrimaryLight, fontSize: 12, fontWeight: FontWeight.w400)),

      // Tab bar theme for content navigation
      tabBarTheme: TabBarTheme(labelColor: primaryLight, unselectedLabelColor: textSecondaryLight, indicatorColor: primaryLight, indicatorSize: TabBarIndicatorSize.label, labelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500), unselectedLabelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400)),

      // Tooltip theme for helpful information
      tooltipTheme: TooltipThemeData(decoration: BoxDecoration(color: textPrimaryLight.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(8)), textStyle: GoogleFonts.inter(color: backgroundLight, fontSize: 12, fontWeight: FontWeight.w400), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),

      // Snackbar theme for feedback
      snackBarTheme: SnackBarThemeData(backgroundColor: textPrimaryLight, contentTextStyle: GoogleFonts.inter(color: backgroundLight, fontSize: 14, fontWeight: FontWeight.w400), actionTextColor: primaryLight, behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),

      // Dialog theme for contextual bottom sheets
      dialogTheme: DialogTheme(backgroundColor: surfaceLight, elevation: 8, shadowColor: shadowLight, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), titleTextStyle: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: textPrimaryLight), contentTextStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400, color: textPrimaryLight)),

      // Bottom sheet theme for filtering and quick actions
      bottomSheetTheme: const BottomSheetThemeData(backgroundColor: surfaceLight, elevation: 8, shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16)))));

  /// Dark theme maintaining cultural authenticity with modern efficiency
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: primaryDark,
          onPrimary: onPrimaryDark,
          primaryContainer: primaryVariantDark,
          onPrimaryContainer: onPrimaryDark,
          secondary: secondaryDark,
          onSecondary: onSecondaryDark,
          secondaryContainer: secondaryVariantDark,
          onSecondaryContainer: onSecondaryDark,
          tertiary: warningLight,
          onTertiary: onPrimaryDark,
          tertiaryContainer: successLight,
          onTertiaryContainer: onSecondaryDark,
          error: errorDark,
          onError: onErrorDark,
          surface: surfaceDark,
          onSurface: onSurfaceDark,
          onSurfaceVariant: textSecondaryDark,
          outline: dividerDark,
          outlineVariant: dividerDark.withValues(alpha: 0.5),
          shadow: shadowDark,
          scrim: shadowDark,
          inverseSurface: surfaceLight,
          onInverseSurface: onSurfaceLight,
          inversePrimary: primaryLight),
      scaffoldBackgroundColor: backgroundDark,
      cardColor: surfaceDark,
      dividerColor: dividerDark,
      appBarTheme: AppBarTheme(
          backgroundColor: backgroundDark,
          foregroundColor: textPrimaryDark,
          elevation: 0,
          scrolledUnderElevation: 2,
          shadowColor: shadowDark,
          surfaceTintColor: Colors.transparent,
          titleTextStyle: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: textPrimaryDark),
          iconTheme: const IconThemeData(color: textPrimaryDark, size: 24)),
      cardTheme: CardTheme(
          color: surfaceDark,
          elevation: 2,
          shadowColor: shadowDark,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: surfaceDark,
          selectedItemColor: primaryDark,
          unselectedItemColor: textSecondaryDark,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          selectedLabelStyle:
              GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
          unselectedLabelStyle:
              GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400)),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryDark,
          foregroundColor: onPrimaryDark,
          elevation: 6,
          shape: CircleBorder()),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: onPrimaryDark,
              backgroundColor: primaryDark,
              elevation: 2,
              shadowColor: shadowDark,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w500))),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              foregroundColor: primaryDark,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              side: const BorderSide(color: primaryDark, width: 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w500))),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: primaryDark,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w500))),
      textTheme: _buildTextTheme(isLight: false),
      inputDecorationTheme: InputDecorationTheme(
          fillColor: surfaceDark,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: dividerDark)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: dividerDark)),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: primaryDark, width: 2)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: errorDark)),
          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: errorDark, width: 2)),
          labelStyle: GoogleFonts.inter(color: textSecondaryDark, fontSize: 16, fontWeight: FontWeight.w400),
          hintStyle: GoogleFonts.inter(color: textDisabledDark, fontSize: 16, fontWeight: FontWeight.w400),
          errorStyle: GoogleFonts.inter(color: errorDark, fontSize: 12, fontWeight: FontWeight.w400)),
      switchTheme: SwitchThemeData(thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryDark;
        }
        return textDisabledDark;
      }), trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryDark.withValues(alpha: 0.3);
        }
        return textDisabledDark.withValues(alpha: 0.3);
      })),
      checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return primaryDark;
            }
            return Colors.transparent;
          }),
          checkColor: WidgetStateProperty.all(onPrimaryDark),
          side: const BorderSide(color: textSecondaryDark, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
      radioTheme: RadioThemeData(fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryDark;
        }
        return textSecondaryDark;
      })),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: primaryDark, linearTrackColor: dividerDark, circularTrackColor: dividerDark),
      sliderTheme: SliderThemeData(activeTrackColor: primaryDark, thumbColor: primaryDark, overlayColor: primaryDark.withValues(alpha: 0.2), inactiveTrackColor: dividerDark, valueIndicatorColor: primaryDark, valueIndicatorTextStyle: GoogleFonts.jetBrainsMono(color: onPrimaryDark, fontSize: 12, fontWeight: FontWeight.w400)),
      tabBarTheme: TabBarTheme(labelColor: primaryDark, unselectedLabelColor: textSecondaryDark, indicatorColor: primaryDark, indicatorSize: TabBarIndicatorSize.label, labelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500), unselectedLabelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400)),
      tooltipTheme: TooltipThemeData(decoration: BoxDecoration(color: textPrimaryDark.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(8)), textStyle: GoogleFonts.inter(color: backgroundDark, fontSize: 12, fontWeight: FontWeight.w400), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
      snackBarTheme: SnackBarThemeData(backgroundColor: textPrimaryDark, contentTextStyle: GoogleFonts.inter(color: backgroundDark, fontSize: 14, fontWeight: FontWeight.w400), actionTextColor: primaryDark, behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      dialogTheme: DialogTheme(backgroundColor: surfaceDark, elevation: 8, shadowColor: shadowDark, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), titleTextStyle: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: textPrimaryDark), contentTextStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400, color: textPrimaryDark)),
      bottomSheetTheme: const BottomSheetThemeData(backgroundColor: surfaceDark, elevation: 8, shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16)))));

  /// Helper method to build text theme with bilingual typography scaling
  /// Supports Arabic RTL layouts while maintaining visual hierarchy consistency
  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color textPrimary = isLight ? textPrimaryLight : textPrimaryDark;
    final Color textSecondary =
        isLight ? textSecondaryLight : textSecondaryDark;
    final Color textDisabled = isLight ? textDisabledLight : textDisabledDark;

    return TextTheme(
        // Display styles for large headings
        displayLarge: GoogleFonts.poppins(
            fontSize: 57,
            fontWeight: FontWeight.w400,
            color: textPrimary,
            letterSpacing: -0.25),
        displayMedium: GoogleFonts.poppins(
            fontSize: 45, fontWeight: FontWeight.w400, color: textPrimary),
        displaySmall: GoogleFonts.poppins(
            fontSize: 36, fontWeight: FontWeight.w400, color: textPrimary),

        // Headline styles for section headers
        headlineLarge: GoogleFonts.poppins(
            fontSize: 32, fontWeight: FontWeight.w600, color: textPrimary),
        headlineMedium: GoogleFonts.poppins(
            fontSize: 28, fontWeight: FontWeight.w600, color: textPrimary),
        headlineSmall: GoogleFonts.poppins(
            fontSize: 24, fontWeight: FontWeight.w600, color: textPrimary),

        // Title styles for cards and components
        titleLarge: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: textPrimary,
            letterSpacing: 0),
        titleMedium: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textPrimary,
            letterSpacing: 0.15),
        titleSmall: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textPrimary,
            letterSpacing: 0.1),

        // Body text optimized for extended mobile reading
        bodyLarge: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: textPrimary,
            letterSpacing: 0.5,
            height: 1.5),
        bodyMedium: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: textPrimary,
            letterSpacing: 0.25,
            height: 1.43),
        bodySmall: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: textSecondary,
            letterSpacing: 0.4,
            height: 1.33),

        // Label styles for UI elements
        labelLarge: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textPrimary,
            letterSpacing: 0.1),
        labelMedium: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textSecondary,
            letterSpacing: 0.5),
        labelSmall: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: textDisabled,
            letterSpacing: 0.5));
  }
}
