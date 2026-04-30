import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppStyles {
  static TextStyle heading = GoogleFonts.outfit(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
  );

  static TextStyle subHeading = GoogleFonts.outfit(
    fontSize: 16,
    color: AppColors.secondaryText,
  );

  static TextStyle label = GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryText,
  );

  static TextStyle button = GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
    letterSpacing: 1.2,
  );

  static const BoxDecoration glassDecoration = BoxDecoration(
    color: AppColors.glassFill,
    borderRadius: BorderRadius.all(Radius.circular(24)),
    border: Border.fromBorderSide(
      BorderSide(
        color: AppColors.glassBorder,
        width: 1,
      ),
    ),
  );

  static BoxDecoration buttonDecoration = BoxDecoration(
    gradient: AppColors.premiumButton,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: AppColors.completed.withValues(alpha: 0.3),
        blurRadius: 15,
        offset: const Offset(0, 5),
      ),
    ],
  );
}
