import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/utilities/animation_source.dart';
import 'package:weather_app/utilities/text_style_source.dart';
import 'package:weather_app/widgets/custom_elevated_button.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  const CustomDialog({
    super.key,
    required this.title,
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
            Text(
              title,
              style: TextStyleSource.inter16,
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
