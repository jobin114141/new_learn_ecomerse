extension StringValidatorExtension on String? {
  /// Returns true if the string is a valid 10-digit mobile number starting with 6-9
  bool get isValidPhone {
    if (this == null || this!.trim().isEmpty) return false;
    return RegExp(r'^[6-9]\d{9}$').hasMatch(this!.trim());
  }

  /// Form validator returning error message string or null
  String? get phoneValidator {
    if (this == null || this!.trim().isEmpty) {
      return 'Mobile number is required';
    }
    if (!isValidPhone) {
      return 'Please enter a valid 10-digit mobile number';
    }
    return null;
  }

  bool get isValidOtp {
    if (this == null || this!.trim().isEmpty) return false;
    return RegExp(r'^\d{6}$').hasMatch(this!.trim());
  }
}
