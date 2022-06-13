import 'package:flutter/material.dart';

import 'screens/loading_screen.dart';

void main() {
  runApp(const Clima());
}

class Clima extends StatelessWidget {
  const Clima({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const LoadingScreen(),
    );
  }
}
