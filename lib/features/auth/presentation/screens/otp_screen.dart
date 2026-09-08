import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_ecomerse/common/widgets/custom_button.dart';
import 'package:my_ecomerse/core/constants/app_images.dart';
import 'package:my_ecomerse/core/extensions/string_extensions.dart';
import 'package:my_ecomerse/features/auth/presentation/providers/otp_provider.dart';
import 'package:my_ecomerse/features/auth/presentation/providers/phone_login_provider.dart';

class OtpScreen extends HookConsumerWidget {
  final String phoneNumber;

  const OtpScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 6 controllers & focus nodes for OTP digits
    final digitControllers = List.generate(
      6,
      (_) => useTextEditingController(),
    );
    final focusNodes = List.generate(6, (_) => useFocusNode());

    // Function to extract full 6-digit OTP
    String getOtpCode() {
      return digitControllers.map((c) => c.text.trim()).join();
    }

    // 💡 Listen ONLY to dedicated OTP Provider errors
    ref.listen<AsyncValue<void>>(otpNotifierProvider, (previous, next) {
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // 1. Header Widget (Logo, Title, Phone display)
              _OtpHeaderWidget(phoneNumber: phoneNumber),

              const SizedBox(height: 36),

              // 2. OTP Pin Box Input Fields Widget
              _OtpInputFieldsWidget(
                digitControllers: digitControllers,
                focusNodes: focusNodes,
              ),

              const SizedBox(height: 24),

              // 3. Resend Timer & Resend Button Widget
              _ResendTimerWidget(phoneNumber: phoneNumber),

              const SizedBox(height: 40),

              // 4. Verify & Submit Button Widget
              _VerifyButtonWidget(
                getOtpCode: getOtpCode,
                phoneNumber: phoneNumber,
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

/// 1. Header Widget with App Logo & Title
class _OtpHeaderWidget extends StatelessWidget {
  final String phoneNumber;

  const _OtpHeaderWidget({required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    final formattedPhone = phoneNumber.startsWith('+91')
        ? phoneNumber
        : '+91 $phoneNumber';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Image.asset(AppImages.appLogo, height: 90, width: 90)),
        const SizedBox(height: 30),
        const Text(
          'Verify Phone',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            text: 'Code is sent to ',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            children: [
              TextSpan(
                text: formattedPhone,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 2. OTP Input Boxes (6 Digits)
class _OtpInputFieldsWidget extends StatelessWidget {
  final List<TextEditingController> digitControllers;
  final List<FocusNode> focusNodes;

  const _OtpInputFieldsWidget({
    required this.digitControllers,
    required this.focusNodes,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return SizedBox(
          width: 46,
          height: 56,
          child: TextFormField(
            controller: digitControllers[index],
            focusNode: focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              counterText: '',
              contentPadding: EdgeInsets.zero,
              filled: true,
              fillColor: Colors.grey.shade100,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < digitControllers.length - 1) {
                focusNodes[index + 1].requestFocus();
              } else if (value.isEmpty && index > 0) {
                focusNodes[index - 1].requestFocus();
              }
            },
          ),
        );
      }),
    );
  }
}

/// 3. Resend Countdown Timer Widget (Rebuilds locally every second)
class _ResendTimerWidget extends HookConsumerWidget {
  final String phoneNumber;

  const _ResendTimerWidget({required this.phoneNumber});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerSeconds = useState<int>(30);
    final isResendActive = useState<bool>(false);

    useEffect(() {
      Timer? timer;
      if (timerSeconds.value > 0) {
        timer = Timer.periodic(const Duration(seconds: 1), (t) {
          if (timerSeconds.value > 1) {
            timerSeconds.value--;
          } else {
            timerSeconds.value = 0;
            isResendActive.value = true;
            t.cancel();
          }
        });
      }
      return () => timer?.cancel();
    }, [timerSeconds.value]);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Didn't receive code? ",
          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        ),
        GestureDetector(
          onTap: isResendActive.value
              ? () async {
                  isResendActive.value = false;
                  timerSeconds.value = 30;

                  await ref
                      .read(phoneLoginNotifierProvider.notifier)
                      .sendOtp(phoneNumber);
                }
              : null,
          child: Text(
            isResendActive.value
                ? 'Resend Code'
                : 'Resend in ${timerSeconds.value}s',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isResendActive.value
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}

/// 4. Verify & Submit Button Widget
class _VerifyButtonWidget extends ConsumerWidget {
  final String Function() getOtpCode;
  final String phoneNumber;

  const _VerifyButtonWidget({
    required this.getOtpCode,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(otpNotifierProvider);

    return CustomButtonWidget(
      isLoading: authState.isLoading,
      buttonText: 'Verify and Proceed',
      onPressed: () async {
        final otp = getOtpCode();
        if (!otp.isValidOtp) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please enter full 6-digit OTP')),
          );
          return;
        }

        await ref
            .read(otpNotifierProvider.notifier)
            .verifyOtp(phoneNumber, otp);
        // if (context.mounted && success) {
        //   debugPrint("moving to home page");
        //   context.pushReplacement(RouteNames.homePage);
        // }
      },
    );
  }
}
