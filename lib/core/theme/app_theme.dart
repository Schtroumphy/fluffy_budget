import 'package:fluffy_budget/core/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_color.dart';

class AppTheme {
  ThemeData get themeData {
    final colorSchema = ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
    );

    final theme = ThemeData.from(colorScheme: colorSchema);

    return theme.copyWith(
        dividerTheme: DividerThemeData(color: AppColor.black.withOpacity(.15)),
        hintColor: AppColor.black[30],
        textTheme: theme.textTheme.copyWith(
          headlineSmall: TextStyles.quickXL,
          bodyLarge: TextStyles.quickXL,
          labelMedium: TextStyles.quickM,
        ),
        inputDecorationTheme: theme.inputDecorationTheme.copyWith(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: Insets.i8,
          ),
        ),
        iconTheme: theme.iconTheme.copyWith(
          size: Insets.i24,
        ),
        dropdownMenuTheme: theme.dropdownMenuTheme.copyWith(
          textStyle: theme.textTheme.bodyLarge,
        ));
  }
}

class TextStyles {
  static final quickXL = GoogleFonts.quicksand(
    fontSize: TextSize.xl,
    color: Colors.black,
  );

  static final quickM = GoogleFonts.quicksand(
    fontSize: TextSize.m,
    color: Colors.black,
  );

  static final noDataGray = GoogleFonts.quicksand(
    fontSize: TextSize.m,
    color: Colors.grey,
    fontStyle: FontStyle.italic
  );

  static final interM = GoogleFonts.inter(
    fontSize: TextSize.m,
    color: Colors.black,
  );
}
