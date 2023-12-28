import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/model/weather_data_model.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/services/open_weather_api.dart';

part 'weather_state.dart';

enum PageStatus { loading, success, error, serviceError }

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherState.initial());

  LocationService location = LocationService();
  OpenWeatherAPI weather = OpenWeatherAPI();

  void getWeatherByMyPosition() async {
    Position? position = await location.determinePosition();
    WeatherData? weatherData;

    if (position != null) {
      weatherData = await weather.getDataByPosition(position: position);
    }

    if (weatherData != null) {
      emit(
        WeatherState(
          weatherData: weatherData,
          location: state.location,
          pageStatus: PageStatus.success,
        ),
      );
    } else {
      emit(
        WeatherState(
          weatherData: state.weatherData,
          location: state.location,
          pageStatus: PageStatus.serviceError,
        ),
      );
    }
  }

  void enterLocation({required String location}) {
    emit(
      WeatherState(
        weatherData: state.weatherData,
        location: location,
        pageStatus: state.pageStatus,
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
          pageStatus: PageStatus.success,
        ),
      );
    } else {
      emit(
        WeatherState(
          weatherData: state.weatherData,
          location: state.location,
          pageStatus: PageStatus.error,
        ),
      );
    }
  }

  void changePageStatus({required PageStatus pageStatus}) {
    emit(
      WeatherState(
        weatherData: state.weatherData,
        location: state.location,
        pageStatus: pageStatus,
      ),
    );
  }
}
