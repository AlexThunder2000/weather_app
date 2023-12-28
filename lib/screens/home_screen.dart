import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/bloc/weather_cubit.dart';
import 'package:weather_app/screens/details_screen.dart';
import 'package:weather_app/screens/loading_screen.dart';
import 'package:weather_app/widgets/background_container.dart';
import 'package:weather_app/widgets/custom_dialog.dart';
import 'package:weather_app/widgets/custom_elevated_button.dart';
import 'package:weather_app/widgets/weather_info.dart';

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
            builder: (_) => const CustomDialog(
              title:
                  'You entered a non-existent location or something went wrong. Please try again',
            ),
          );
        }
        if (state.pageStatus == PageStatus.serviceError) {
          context
              .read<WeatherCubit>()
              .changePageStatus(pageStatus: PageStatus.success);
          showDialog(
            context: context,
            builder: (_) => const CustomDialog(
              title:
                  'In order to use this function, you must enable geolocation and give permission. Please try again',
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.pageStatus == PageStatus.loading) {
          return const LoadingScreen();
        } else {
          return Stack(
            children: [
              BackgroundContainer(
                weather: state.weatherData.main,
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
                                  if (value.isNotEmpty) {
                                    context
                                        .read<WeatherCubit>()
                                        .getWeatherByLocation();
                                  }
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
                        flex: 5,
                      ),
                      Hero(
                        tag: 'WeatherInfo',
                        child: WeatherInfo(weatherData: state.weatherData),
                      ),
                      CustomElevatedButton(
                        title: 'More details',
                        callback: () {
                          context.push(DetailsScreen.path);
                        },
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
