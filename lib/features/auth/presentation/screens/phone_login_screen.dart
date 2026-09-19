import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_ecomerse/common/widgets/custom_button.dart';
import 'package:my_ecomerse/common/widgets/custom_text_field.dart';
import 'package:my_ecomerse/core/constants/app_images.dart';
import 'package:my_ecomerse/core/extensions/string_extensions.dart';
import 'package:my_ecomerse/features/auth/presentation/providers/phone_login_provider.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final authState = ref.watch(phoneLoginNotifierProvider);

    // 💡 Listen for Auth API Errors and display clean SnackBar to the user
    ref.listen<AsyncValue<void>>(phoneLoginNotifierProvider, (previous, next) {
      if (previous is AsyncLoading && next is AsyncError) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: Text(next.error.toString()),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),

                // App Logo
                Center(
                  child: Image.asset(
                    AppImages.appLogo,
                    height: 100,
                    width: 100,
                  ),
                ),

                const SizedBox(height: 40),
                const Text(
                  'Login or Sign ',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter your mobile number to receive an OTP',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),

                const SizedBox(height: 30),
                // Phone Input Field with Country Code Prefix
                CustomTextFieldWidget(
                  controller: phoneController,
                  hintText: 'Enter 10-digit mobile number',
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    child: Text(
                      '+91 ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  validator: (val) => val.phoneValidator,
                ),

                const SizedBox(height: 40),

                // Submit Button
                CustomButtonWidget(
                  isLoading: authState.isLoading,
                  buttonText: 'Continue',
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final inputPhone = phoneController.text.trim();
                      final fullPhoneNumber = inputPhone.startsWith('+91')
                          ? inputPhone
                          : '+91$inputPhone';

                      final success = await ref
                          .read(phoneLoginNotifierProvider.notifier)
                          .sendOtp(fullPhoneNumber);

                      if (success && context.mounted) {
                        context.push('/otp', extra: fullPhoneNumber);
                      }
                    }
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
