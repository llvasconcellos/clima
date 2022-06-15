import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:clima/utilities/constants.dart';
import 'package:clima/services/location.dart';
import 'package:clima/screens/location_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocationData() async {
    // final Location _location = Location();
    // await _location.getCurrentLocation();
    // if (kDebugMode) {
    //   print(_location);
    // }

    const latitude = -25.44144144144144;
    const longitude = -49.303764323032915;
    var networkHelper = NetworkHelper(
      'https://api.openweathermap.org/data/2.5/weather?lat='
      //'${_location.latitude.toString()}&lon=${_location.longitude.toString()}'
      '${latitude.toString()}&lon=${longitude.toString()}'
      '&appid=$kOpenWeatherMapsAPIKey&units=metric',
    );

    final data = await networkHelper.getData();

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(locationWeatherData: data),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          size: 100,
          color: Colors.white,
        ),
      ),
    );
  }
}
