import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_cubit.dart';
import 'package:weather_app/utilities/text_style_source.dart';
import 'package:weather_app/widgets/background_container.dart';
import 'package:weather_app/widgets/weather_info.dart';

class DetailsScreen extends StatelessWidget {
  static const path = '/details';

  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state.weatherData.cityName),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              BackgroundContainer(
                weather: state.weatherData.main,
              ),
              Column(
                children: [
                  Hero(
                    tag: 'WeatherInfo',
                    child: WeatherInfo(weatherData: state.weatherData),
                  ),
                  Container(
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
                    child: Column(
                      children: [
                        Text(
                          'Feels like: ${state.weatherData.feelsLike.round().toString()}°C',
                          style: TextStyleSource.inter16,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Humidity: ${state.weatherData.humidity.toString()}%',
                          style: TextStyleSource.inter16,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Wind speed: ${state.weatherData.windSpeed.toString()} m/s',
                          style: TextStyleSource.inter16,
                        ),
                        const SizedBox(height: 16),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Temperature max:',
                                    style: TextStyleSource.inter16,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${state.weatherData.temperatureMax.round().toString()}°C',
                                    style: TextStyleSource.inter24,
                                  ),
                                ],
                              ),
                              const VerticalDivider(
                                color: Colors.black,
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Temperature min:',
                                    style: TextStyleSource.inter16,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${state.weatherData.temperatureMin.round().toString()}°C',
                                    style: TextStyleSource.inter24,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
