import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(ReadersHideout());

class ReadersHideout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Readers Hideout',
      home: HomeScreen(),
    );
  }
}
