import 'package:flutter/material.dart';

const kOpenWeatherMapsAPIKey = 'fe5d2613b91eb47674bc1ae5a0fa4eb3';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const kTextFieldInputDecoration = InputDecoration(
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color: Color(0xff424242),
  ),
  filled: true,
  fillColor: Color(0x77ffffff),
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide.none,
  ),
);

const String kLocationServicesDisabledMessage =
    'Location services are disabled.';
const String kPermissionDeniedMessage = 'Permission denied.';
const String kPermissionDeniedForeverMessage = 'Permission denied forever.';
const String kPermissionGrantedMessage = 'Permission granted.';
