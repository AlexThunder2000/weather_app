import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/bloc/weather_cubit.dart';
import 'package:weather_app/screens/error_screen.dart';
import 'package:weather_app/screens/loading_screen.dart';
import 'package:weather_app/services/open_weather_api.dart';
import 'package:weather_app/utilities/animation_source.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Position position;
  OpenWeatherAPI openWeatherAPI = OpenWeatherAPI();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state.apiStatus == ApiStatus.loading) {
          return const LoadingScreen();
        } else if (state.apiStatus == ApiStatus.error) {
          return const ErrorScreen();
        } else {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      getWeatherAnimation(
                        mainCondition: state.weatherData.main,
                      ),
                    ),
                    Text(
                        '${state.weatherData.cityName},${state.weatherData.country}'),
                    Text(state.weatherData.main),
                    Text(
                        '${state.weatherData.temperature.round().toString()}°C'),
                  ],
                ),
              ),
            ),
          );
        }
      },
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
