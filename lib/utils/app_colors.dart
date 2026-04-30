import 'package:flutter/material.dart';

class AppColors {
  static const LinearGradient mainBackground = LinearGradient(
    colors: [Color(0xFF012622), Color(0xFF000000)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient premiumButton = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Color glassFill = Color(0x0DFFFFFF);
  static const Color glassBorder = Color(0x1AFFFFFF);
  
  static const Color primaryText = Colors.white;
  static const Color secondaryText = Colors.white70;
  
  static const Color completed = Color(0xFF10B981);
  static const Color cancelled = Color(0xFFEF4444);
  static const Color booked = Color(0xFF3B82F6);
  
  static const Color accentCircle1 = Color(0x1A55F3CD);
  static const Color accentCircle2 = Color(0x1A10B981);
}
