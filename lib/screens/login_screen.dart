import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    setState(() {
      _emailError = _validateEmail(email);
      _passwordError = _validatePassword(password);
    });

    if (_emailError == null && _passwordError == null) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
    }
  }

  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }

    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final viewInsets = MediaQuery.viewInsetsOf(context);
    final screenWidth = screenSize.width;
    final isCompact = screenWidth < 360;
    final isWide = screenWidth >= 700;
    final horizontalPadding = isWide
        ? 32.0
        : isCompact
        ? 16.0
        : 24.0;
    final cardPadding = isWide
        ? 36.0
        : isCompact
        ? 20.0
        : 32.0;
    final cardMaxWidth = isWide ? 460.0 : 420.0;
    final titleFontSize = isWide
        ? 38.0
        : isCompact
        ? 28.0
        : 32.0;
    final subtitleFontSize = isWide
        ? 18.0
        : isCompact
        ? 14.0
        : 16.0;
    final titleSpacing = isCompact ? 32.0 : 40.0;
    final fieldSpacing = isCompact ? 16.0 : 20.0;
    final buttonHeight = isWide
        ? 58.0
        : isCompact
        ? 50.0
        : 54.0;
    final cardRadius = isCompact ? 20.0 : 24.0;
    final inputRadius = isCompact ? 10.0 : 12.0;
    final topCircleSize = isWide
        ? 240.0
        : isCompact
        ? 140.0
        : 200.0;
    final bottomCircleSize = isWide
        ? 180.0
        : isCompact
        ? 110.0
        : 150.0;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.mainBackground),
        child: Stack(
          children: [
            Positioned(
              top: isCompact ? -30 : -50,
              right: isCompact ? -30 : -50,
              child: Container(
                width: topCircleSize,
                height: topCircleSize,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accentCircle1,
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: isCompact ? 35 : 50,
                    sigmaY: isCompact ? 35 : 50,
                  ),
                  child: Container(color: Colors.transparent),
                ),
              ),
            ),
            Positioned(
              bottom: isCompact ? -20 : -30,
              left: isCompact ? -20 : -30,
              child: Container(
                width: bottomCircleSize,
                height: bottomCircleSize,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accentCircle2,
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: isCompact ? 28 : 40,
                    sigmaY: isCompact ? 28 : 40,
                  ),
                  child: Container(color: Colors.transparent),
                ),
              ),
            ),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    24,
                    horizontalPadding,
                    24 + viewInsets.bottom,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: cardMaxWidth),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(cardRadius),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          padding: EdgeInsets.all(cardPadding),
                          decoration: AppStyles.glassDecoration.copyWith(
                            borderRadius: BorderRadius.circular(cardRadius),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Trips & Bookings',
                                style: AppStyles.heading.copyWith(
                                  fontSize: titleFontSize,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Login to view and manage your trips.',
                                style: AppStyles.subHeading.copyWith(
                                  fontSize: subtitleFontSize,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: titleSpacing),
                              _buildTextField(
                                controller: _emailController,
                                label: 'Email',
                                hint: 'you@example.com',
                                error: _emailError,
                                icon: Icons.email_outlined,
                                labelFontSize: isCompact ? 13.0 : 14.0,
                                textFontSize: isCompact ? 14.0 : 16.0,
                                iconSize: isCompact ? 18.0 : 20.0,
                                inputRadius: inputRadius,
                              ),
                              SizedBox(height: fieldSpacing),
                              _buildTextField(
                                controller: _passwordController,
                                label: 'Password',
                                hint: 'Enter your password',
                                error: _passwordError,
                                icon: Icons.lock_outline_rounded,
                                labelFontSize: isCompact ? 13.0 : 14.0,
                                textFontSize: isCompact ? 14.0 : 16.0,
                                iconSize: isCompact ? 18.0 : 20.0,
                                inputRadius: inputRadius,
                                isPassword: true,
                              ),
                              SizedBox(height: isCompact ? 24 : 32),
                              Container(
                                height: buttonHeight,
                                decoration: AppStyles.buttonDecoration,
                                child: ElevatedButton(
                                  onPressed: _submit,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        inputRadius,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'LOGIN',
                                    style: AppStyles.button.copyWith(
                                      fontSize: isCompact ? 14.0 : 16.0,
                                      letterSpacing: isCompact ? 1.0 : 1.2,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: isCompact ? 20 : 24),
                              Center(
                                child: Text(
                                  "Don't have an account? Sign Up",
                                  style: AppStyles.subHeading.copyWith(
                                    fontSize: isCompact ? 13.0 : 14.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    String? error,
    required IconData icon,
    required double labelFontSize,
    required double textFontSize,
    required double iconSize,
    required double inputRadius,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyles.label.copyWith(fontSize: labelFontSize)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: textFontSize,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.primaryText.withOpacity(0.3),
              fontSize: textFontSize,
            ),
            prefixIcon: Icon(
              icon,
              color: AppColors.secondaryText,
              size: iconSize,
            ),
            filled: true,
            fillColor: AppColors.glassFill,
            errorText: error,
            errorStyle: const TextStyle(color: Colors.redAccent),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: textFontSize >= 16 ? 18 : 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(inputRadius),
              borderSide: BorderSide(color: AppColors.glassBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(inputRadius),
              borderSide: const BorderSide(color: AppColors.completed),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(inputRadius),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(inputRadius),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
          ),
        ),
      ],
    );
  }
}
