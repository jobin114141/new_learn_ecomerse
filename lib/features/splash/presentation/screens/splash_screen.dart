import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_ecomerse/common/widgets/custom_loading_widget.dart';
import 'package:my_ecomerse/core/constants/app_images.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // useEffect(() {
    //   final timer = Timer(const Duration(seconds: 3), () {
    //     if (context.mounted) {
    //       context.go(RouteNames.login);
    //     }
    //   });
    //   return () => timer.cancel();
    // }, const []);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo from AppImages
            Image.asset(AppImages.appLogo, height: 150, width: 150),
            const SizedBox(height: 30),
            // Loading indicator
             CustomLoadingWidget(color: Colors.black12,),
             
          ],
        ),
      ),
    );
  }
}
