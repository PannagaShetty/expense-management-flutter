import 'package:flutter/material.dart';
import 'package:myapp/core/theme/app_colors.dart';

class AppTheme {
  static _border([Color color = AppColors.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 3),
        borderRadius: BorderRadius.circular(8),
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(24),
      enabledBorder: _border(),
      focusedBorder: _border(AppColors.gradient2),
      errorBorder: _border(AppColors.errorColor.withOpacity(0.6)),
      focusedErrorBorder: _border(AppColors.errorColor),
      hintStyle: const TextStyle(
        color: AppColors.greyColor,
      ),
    ),
  );
}
