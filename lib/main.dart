import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/bloc/weather_cubit.dart';
import 'package:weather_app/services/open_weather_api.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => WeatherCubit()..getWeatherByMyPosition(),
        child: const WeatherApp(),
      ),
    ),
  );
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  late Position position;
  OpenWeatherAPI openWeatherAPI = OpenWeatherAPI();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: state.apiStatus == ApiStatus.loading
                  ? const CircularProgressIndicator()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.weatherData.cityName),
                        Text(state.weatherData.temperature.toString()),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
