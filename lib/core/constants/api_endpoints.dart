class ApiEndpoints {
  static const String baseUrl = 'https://www.makemycurry.in';

  // Auth
  static const String checkPhoneUri = '/api/v1/auth/check-phone?phone=';
  static const String loginUri = '/api/v1/auth/login';
  static const String verifyOtpUri = '/api/v1/auth/verify-otp';
  // Banners
  static const String bannerUri = '/api/v1/banners';
  static const String bannerStorageUrl = '$baseUrl/storage/app/public/banner/';
}

