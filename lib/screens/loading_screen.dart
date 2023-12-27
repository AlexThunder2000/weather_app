import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:weather_app/utilities/animation_source.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(),
              Expanded(
                child: RiveAnimation.asset(AnimationSource.loadingRive),
              ),
              Spacer(),
              CircularProgressIndicator(
                color: Colors.blue,
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
