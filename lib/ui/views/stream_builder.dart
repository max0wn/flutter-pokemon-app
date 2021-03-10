import 'package:flutter/material.dart';
import 'package:pokemon_app/models/pokemon.dart';

Widget _row(String title, String text, TextStyle style) {
  return Row(
    children: [
      Text(
        title,
        style: style,
      ),
      Text(
        text,
        style: style,
      ),
    ],
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
  );
}

Widget errorBlock(String error) {
  return Container(
    margin: EdgeInsets.only(top: 10.0),
    child: Column(
      children: [
        Row(
          children: [
            Text(
              'Can\'t find the pokemon',
              style: TextStyle(fontSize: 22.0),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ],
    ),
  );
}

Widget itemBuilder(AsyncSnapshot<Pokemon> snapshot) {
  final TextStyle style = TextStyle(fontSize: 22.0);

  return Container(
    child: Column(
      children: [
        _row('Id: ', snapshot.data.id.toString(), style),
        SizedBox(height: 15.0),
        _row('Name: ', snapshot.data.name, style),
        SizedBox(height: 15.0),
        _row('Height: ', snapshot.data.height.toString(), style),
        SizedBox(height: 15.0),
        _row('Weight: ', snapshot.data.weight.toString(), style),
        SizedBox(height: 15.0),
        _row('Type: ', snapshot.data.type, style),
        SizedBox(height: 15.0),
      ],
    ),
    margin: EdgeInsets.only(top: 10.0),
  );
}
