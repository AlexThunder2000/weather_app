part of 'weather_cubit.dart';

class WeatherState {
  final String location;
  final WeatherData weatherData;
  final ApiStatus apiStatus;

  const WeatherState({
    required this.weatherData,
    required this.location,
    required this.apiStatus,
  });

  WeatherState.initial()
      : location = '',
        apiStatus = ApiStatus.loading,
        weatherData = WeatherData(
          main: '',
          description: '',
          icon: '',
          temperature: 0,
          feelsLike: 0,
          humidity: 0,
          windSpeed: 0,
          country: '',
          cityName: '',
        );

  List<Object> get props => [location, weatherData, apiStatus];
}
