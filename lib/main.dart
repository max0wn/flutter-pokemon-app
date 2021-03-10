import 'package:flutter/material.dart';

import 'ui/screens/home.dart';

void main() => runApp(PokemonApp());

class PokemonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
