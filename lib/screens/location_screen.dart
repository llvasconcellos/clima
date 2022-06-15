import 'package:flutter/material.dart';

import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {
  final dynamic locationWeatherData;

  const LocationScreen({Key? key, this.locationWeatherData}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final WeatherModel weatherModel = WeatherModel();
  late final int _temperature;
  late final String _weatherIcon;
  late final String _cityName;
  late final String _message;

  @override
  void initState() {
    updateUi(widget.locationWeatherData);
    super.initState();
  }

  double _convertToCelsius(double kevin) {
    return kevin - 273.15;
  }

  void updateUi(data) {
    final double temperature = data['main']['temp'];
    _temperature = temperature.toInt();
    int weatherCondition = data['weather'][0]['id'];
    _weatherIcon = weatherModel.getWeatherIcon(weatherCondition);
    _message = weatherModel.getMessage(_temperature);
    _cityName = data['name'];

    // final String weatherMain = data['weather'][0]['main'];
    // final String weatherDescription = data['weather'][0]['description'];
    // final String weatherIcon = data['weather'][0]['icon'];
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
                    onPressed: () {},
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
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
                  "$_message in $_cityName!",
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
