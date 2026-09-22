import 'package:flutter_test/flutter_test.dart';
import 'package:my_ecomerse/core/extensions/string_extensions.dart';

void main() {
  group('StringValidatorExtension Tests -', () {
    
    group('isValidPhone:', () {
      test('Returns true for valid 10-digit Indian mobile numbers', () {
        expect('9876543210'.isValidPhone, true);
        expect('6123456789'.isValidPhone, true);
      });

      test('Returns false for invalid numbers, lengths, or wrong start digit', () {
        expect('1234567890'.isValidPhone, false); // Starts with 1
        expect('98765'.isValidPhone, false);      // Too short
        expect('98765432101'.isValidPhone, false);// Too long
        expect('98765ABCD0'.isValidPhone, false); // Contains letters
        expect(''.isValidPhone, false);           // Empty
        expect(null.isValidPhone, false);         // Null
      });
    });

    group('phoneValidator:', () {
      test('Returns error if empty or null', () {
        expect(''.phoneValidator, 'Mobile number is required');
        expect(null.phoneValidator, 'Mobile number is required');
      });

      test('Returns invalid format error for wrong numbers', () {
        expect('12345'.phoneValidator, 'Please enter a valid 10-digit mobile number');
      });

      test('Returns null when phone number is valid', () {
        expect('9876543210'.phoneValidator, null);
      });
    });

    group('isValidOtp:', () {
      test('Returns true for exactly 6 digits', () {
        expect('123456'.isValidOtp, true);
        expect('000000'.isValidOtp, true);
      });

      test('Returns false for invalid OTPs', () {
        expect('12345'.isValidOtp, false);   // Too short
        expect('1234567'.isValidOtp, false); // Too long
        expect('12A456'.isValidOtp, false);  // Contains letters
      });
    });
  });
}
