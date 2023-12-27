class WeatherData {
  final String main;
  final String description;
  final String icon;
  final double temperature;
  final double temperatureMin;
  final double temperatureMax;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final String country;
  final String cityName;

  WeatherData({
    required this.main,
    required this.description,
    required this.icon,
    required this.temperature,
    required this.temperatureMin,
    required this.temperatureMax,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.country,
    required this.cityName,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      main: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      temperature: json['main']['temp'].toDouble(),
      temperatureMin: json['main']['temp_min'].toDouble(),
      temperatureMax: json['main']['temp_max'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      country: json['sys']['country'],
      cityName: json['name'],
    );
  }
}
