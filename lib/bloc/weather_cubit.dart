import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/model/weather_data_model.dart';
import 'package:weather_app/services/geolocator.dart';
import 'package:weather_app/services/open_weather_api.dart';

part 'weather_state.dart';

enum ApiStatus { loading, success, error }

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherState.initial());

  LocationService location = LocationService();
  OpenWeatherAPI weather = OpenWeatherAPI();

  void getWeatherByMyPosition() async {
    Position position = await location.determinePosition();

    WeatherData? weatherData =
        await weather.getDataByPosition(position: position);
    if (weatherData != null) {
      emit(
        WeatherState(
          weatherData: weatherData,
          location: state.location,
          apiStatus: ApiStatus.success,
        ),
      );
    } else {
      emit(
        WeatherState(
          weatherData: state.weatherData,
          location: state.location,
          apiStatus: ApiStatus.error,
        ),
      );
    }
  }

  void enterLocation({required String location}) {
    emit(
      WeatherState(
        weatherData: state.weatherData,
        location: location,
        apiStatus: state.apiStatus,
      ),
    );
  }

  void getWeatherByLocation() async {
    WeatherData? weatherData =
        await weather.getDataByLocation(location: state.location);
    if (weatherData != null) {
      emit(
        WeatherState(
          weatherData: weatherData,
          location: state.location,
          apiStatus: ApiStatus.success,
        ),
      );
    } else {
      emit(
        WeatherState(
          weatherData: state.weatherData,
          location: state.location,
          apiStatus: ApiStatus.error,
        ),
      );
    }
  }
}
