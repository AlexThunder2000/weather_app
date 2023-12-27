import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/utilities/animation_source.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              child: Lottie.asset(AnimationSource.error),
            ),
            const Text(
              'Something went wrong\nPlease try again later',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
