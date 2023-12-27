import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:weather_app/utilities/animation_source.dart';
import 'package:weather_app/utilities/text_style_source.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({
    super.key,
  });

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Spacer(),
          const Expanded(
            child: RiveAnimation.asset(AnimationSource.loadingRive),
          ),
          Text(
            "Welcome to WeatherApp",
            style: TextStyleSource.inter32.copyWith(
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Text(
                'created by Bihnyak Oleksandr',
                style: TextStyleSource.inter14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
