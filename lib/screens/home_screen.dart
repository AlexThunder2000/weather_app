import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/bloc/weather_cubit.dart';
import 'package:weather_app/utilities/animation_source.dart';
import 'package:weather_app/utilities/image_source.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(),
      child: BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    _getWeatherBackground(
                      mainCondition: state.weatherData.main,
                    ),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 32),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                suffixIcon: const Icon(Icons.search),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 16,
                                ),
                                hintText: 'Enter location...',
                              ),
                              onChanged: (value) {
                                context
                                    .read<WeatherCubit>()
                                    .enterLocation(location: value.trim());
                              },
                              onSubmitted: (value) {
                                context
                                    .read<WeatherCubit>()
                                    .getWeatherByLocation();
                                setState(() {
                                  controller.text = '';
                                });
                              },
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(50.0),
                            onTap: () {
                              context
                                  .read<WeatherCubit>()
                                  .getWeatherByMyPosition();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(16),
                              child: Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
          ],
        );
      }),
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
