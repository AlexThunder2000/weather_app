part of 'weather_cubit.dart';

class WeatherState {
  final String location;
  final WeatherData weatherData;
  final PageStatus pageStatus;

  const WeatherState({
    required this.weatherData,
    required this.location,
    required this.pageStatus,
  });

  WeatherState.initial()
      : location = 'Kyiv',
        pageStatus = PageStatus.loading,
        weatherData = WeatherData(
          main: '',
          description: '',
          icon: '',
          temperature: 0,
          feelsLike: 0,
          humidity: 0,
          windSpeed: 0,
          temperatureMin: 0,
          temperatureMax: 0,
          country: '',
          cityName: '',
        );

  List<Object> get props => [location, weatherData, pageStatus];
}
