import 'dart:convert';

import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:weather_app/model/weather_data_model.dart';
import 'package:weather_app/utilities/constant.dart';

class OpenWeatherAPI {
  Future<WeatherData?> getDataByPosition(
      {required LocationData position}) async {
    Response response = await get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}7&appid=${Constant.apiKey}&units=metric'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      WeatherData weatherData = WeatherData.fromJson(jsonData);
      return weatherData;
    } else {
      return null;
    }
  }

  Future<WeatherData?> getDataByLocation({required String location}) async {
    Response response = await get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=${Constant.apiKey}&units=metric'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      WeatherData weatherData = WeatherData.fromJson(jsonData);
      return weatherData;
    } else {
      return null;
    }
  }
}
