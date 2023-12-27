import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_cubit.dart';
import 'package:weather_app/screens/loading_screen.dart';
import 'package:weather_app/utilities/animation_source.dart';
import 'package:weather_app/utilities/image_source.dart';
import 'package:weather_app/widgets/animation_icon.dart';
import 'package:weather_app/widgets/custom_dialog.dart';
import 'package:weather_app/widgets/custom_elevated_button.dart';

class HomeScreen extends StatefulWidget {
  static const path = '/';
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
    return BlocConsumer<WeatherCubit, WeatherState>(
      listener: (context, state) {
        if (state.pageStatus == PageStatus.error) {
          context
              .read<WeatherCubit>()
              .changePageStatus(pageStatus: PageStatus.success);
          showDialog(
            context: context,
            builder: (_) => const CustomDialog(),
          );
        }
      },
      builder: (context, state) {
        if (state.pageStatus == PageStatus.loading) {
          return const LoadingScreen();
        } else {
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
                      const Spacer(
                        flex: 3,
                      ),
                      Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                AnimationIcon(
                                  mainCondition: state.weatherData.main,
                                ),
                                Column(
                                  children: [
                                    Text(
                                        '${state.weatherData.cityName},${state.weatherData.country}'),
                                    Text(state.weatherData.main),
                                    Text(
                                        '${state.weatherData.temperature.round().toString()}°C'),
                                  ],
                                ),
                              ],
                            ),
                            CustomElevatedButton(
                              title: 'More detail',
                              callback: () {
                                print('123');
                              },
                            ),
                          ],
                        ),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      },
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
