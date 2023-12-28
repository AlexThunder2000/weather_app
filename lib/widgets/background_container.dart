import 'package:flutter/material.dart';
import 'package:weather_app/utilities/animation_source.dart';
import 'package:weather_app/utilities/image_source.dart';

class BackgroundContainer extends StatelessWidget {
  final String weather;
  const BackgroundContainer({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            _getWeatherBackground(
              mainCondition: weather,
            ),
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

String _getWeatherBackground({required String? mainCondition}) {
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
      return ImageSource.cloud;
    case 'rain':
    case 'drizzle':
    case 'shower rain':
    case 'thunderstorm':
      return ImageSource.rain;
    case 'snow':
      return ImageSource.snow;
    case 'clear':
      return ImageSource.sun;
    default:
      return ImageSource.sun;
  }
}
