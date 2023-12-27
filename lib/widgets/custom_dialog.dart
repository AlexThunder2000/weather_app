import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/utilities/animation_source.dart';
import 'package:weather_app/widgets/custom_elevated_button.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 100,
              child: Lottie.asset(AnimationSource.error),
            ),
            const Text(
              'You entered a non-existent location or something went wrong. Please try again',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            CustomElevatedButton(
              title: 'Understand',
              callback: () {
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
