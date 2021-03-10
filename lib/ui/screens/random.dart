import 'package:flutter/material.dart';

import 'package:pokemon_app/models/pokemon.dart';
import 'package:pokemon_app/blocs/pokemon_bloc.dart';
import 'package:pokemon_app/blocs/pokemon_event.dart';
import 'package:pokemon_app/ui/views/stream_builder.dart';

class Random extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Random Pokemon')),
        body: Center(
          child: Container(
            child: Column(
              children: [
                StreamBuilder(
                  stream: bloc.pokemon,
                  builder:
                      (BuildContext context, AsyncSnapshot<Pokemon> snapshot) {
                    if (snapshot.hasData) {
                      return itemBuilder(snapshot);
                    } else if (snapshot.hasError) {
                      return errorBlock('Can\'t generate a pokemon');
                    }
                    return Container();
                  },
                ),
                Spacer(),
                Container(
                  child: Row(
                    children: [
                      RaisedButton(
                        child: Container(child: Text('Random')),
                        onPressed: () =>
                            bloc.eventSink.add(RandomPokemonEvent()),
                        textColor: Colors.white,
                        color: Color(0xff223256),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
              ],
            ),
            padding: EdgeInsets.all(10.0),
          ),
        ),
      ),
    );
  }
}
