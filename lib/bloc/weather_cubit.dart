import 'package:bloc/bloc.dart';
import 'package:location/location.dart';
import 'package:weather_app/model/weather_data_model.dart';
import 'package:weather_app/services/geolocator.dart';
import 'package:weather_app/services/open_weather_api.dart';

part 'weather_state.dart';

enum PageStatus { loading, success, error }

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherState.initial());

  LocationService location = LocationService();
  OpenWeatherAPI weather = OpenWeatherAPI();

  void getWeatherByMyPosition() async {
    LocationData? locationData = await location.determinePosition();
    WeatherData? weatherData;

    if (locationData != null) {
      weatherData = await weather.getDataByPosition(position: locationData);
    } else {
      weatherData = await weather.getDataByLocation(location: 'Kyiv');
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
          pageStatus: PageStatus.error,
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
