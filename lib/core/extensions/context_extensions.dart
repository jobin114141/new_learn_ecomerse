import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  // Screen sizes
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  // Theme shortcuts
  ThemeData get theme => Theme.of(this);
  Color get primaryColor => Theme.of(this).primaryColor;

  // SnackBar helper
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : null,
      ),
    );
  }

  // Dismiss keyboard
  void dismissKeyboard() {
    FocusScope.of(this).unfocus();
  }
}
