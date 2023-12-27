import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/utilities/animation_source.dart';

class AnimationIcon extends StatelessWidget {
  final String mainCondition;
  const AnimationIcon({
    super.key,
    required this.mainCondition,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: Lottie.asset(
        getWeatherAnimation(
          mainCondition: mainCondition,
        ),
      ),
    );
  }
}

String getWeatherAnimation({required String? mainCondition}) {
  if (mainCondition == null) {
    return AnimationSource.sun;
  }
  switch (mainCondition.toLowerCase()) {
    case 'clouds':
    case 'mist':
    case 'smoke':
    case 'haze':
    case 'dust':
    case 'fog':
      return AnimationSource.cloud;
    case 'rain':
    case 'drizzle':
    case 'shower rain':
      return AnimationSource.rain;
    case 'thunderstorm':
      return AnimationSource.thunder;
    case 'clear':
      return AnimationSource.sun;
    default:
      return AnimationSource.sun;
  }
}
