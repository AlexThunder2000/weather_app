import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_data_model.dart';
import 'package:weather_app/utilities/text_style_source.dart';
import 'package:weather_app/widgets/animation_icon.dart';

class WeatherInfo extends StatelessWidget {
  final WeatherData weatherData;
  const WeatherInfo({
    super.key,
    required this.weatherData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade800.withOpacity(0.7),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AnimationIcon(
                  mainCondition: weatherData.main,
                ),
                Column(
                  children: [
                    Text(
                      '${weatherData.temperature.round().toString()}°C',
                      style: TextStyleSource.inter32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      weatherData.main,
                      style: TextStyleSource.inter16,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${weatherData.cityName},${weatherData.country}',
                      style: TextStyleSource.inter14,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
