import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/foundation.dart';

class WeatherModel {
  final String _openWeatherMapURL =
      'https://api.openweathermap.org/data/2.5/weather';

  Future<dynamic> getCityWeather(String cityName) {
    var networkHelper = NetworkHelper(
      '$_openWeatherMapURL?q=$cityName&appid=$kOpenWeatherMapsAPIKey&units=metric',
    );
    return networkHelper.getData();
  }

  Future<dynamic> getLocationWeather() async {
    final Location location = Location();
    await location.getCurrentLocation();
    if (kDebugMode) {
      print(location);
    }
    var networkHelper = NetworkHelper(
      '$_openWeatherMapURL'
      '?lat=${location.latitude.toString()}&lon=${location.longitude.toString()}'
      '&appid=$kOpenWeatherMapsAPIKey&units=metric',
    );

    return networkHelper.getData();
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
