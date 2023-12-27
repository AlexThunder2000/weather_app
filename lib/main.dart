import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_cubit.dart';
import 'package:weather_app/screens/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => WeatherCubit()..getWeatherByMyPosition(),
        child: const HomeScreen(),
      ),
    ),
  );
}
