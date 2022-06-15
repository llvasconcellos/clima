import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/foundation.dart';

class WeatherModel {
  final String _openWeatherMapURL =
      'https://api.openweathermap.org/data/2.5/weather';

  Future<dynamic> getLocationWeather() async {
    final Location location = Location();
    await location.getCurrentLocation();
    if (kDebugMode) {
      print(location);
    }

    // const latitude = -25.44144144144144;
    // const longitude = -49.303764323032915;
    var networkHelper = NetworkHelper(
      '$_openWeatherMapURL'
      '?lat=${location.latitude.toString()}&lon=${location.longitude.toString()}'
      '&appid=$kOpenWeatherMapsAPIKey&units=metric',
    );

    return networkHelper.getData();
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
