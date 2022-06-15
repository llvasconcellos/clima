import 'package:flutter/material.dart';

import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  final dynamic locationWeatherData;

  const LocationScreen({Key? key, this.locationWeatherData}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final WeatherModel weatherModel = WeatherModel();
  late int _temperature;
  late String _weatherIcon;
  late String _weatherMessage;

  @override
  void initState() {
    updateUi(widget.locationWeatherData);
    super.initState();
  }

  double _convertToCelsius(double kevin) {
    return kevin - 273.15;
  }

  void updateUi(data) {
    setState(() {
      if (data == null) {
        _temperature = 0;
        _weatherIcon = 'Error';
        _weatherMessage = 'Unable to get weather data';
      } else {
        final double temperature = data['main']['temp'];
        _temperature = temperature.toInt();
        int weatherCondition = data['weather'][0]['id'];
        _weatherIcon = weatherModel.getWeatherIcon(weatherCondition);
        String message = weatherModel.getMessage(_temperature);
        String city = data['name'];
        _weatherMessage = '$message in $city';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var data = await weatherModel.getLocationWeather();
                      updateUi(data);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CityScreen(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$_temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      _weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  _weatherMessage,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
