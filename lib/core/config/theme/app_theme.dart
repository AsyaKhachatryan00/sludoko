import 'package:flutter/material.dart';
import 'text_styles.dart';
import 'app_colors.dart';

final class AppTheme {
  AppTheme._();

  static ThemeData get standard {
    return ThemeData(
      useMaterial3: true,
      splashFactory: NoSplash.splashFactory, // Disable all ripple splashes
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: AppColors.white),
        color: AppColors.mainBg,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      scaffoldBackgroundColor: AppColors.mainBg,
      textTheme: _textTheme,
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: AppTextStyle.displayLarge,
      displayMedium: AppTextStyle.displayMedium,
      displaySmall: AppTextStyle.displaySmall,
      titleMedium: AppTextStyle.titleMedium,
      labelLarge: AppTextStyle.labelLarge
    );
  }
}
