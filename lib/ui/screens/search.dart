import 'package:flutter/material.dart';

import 'package:pokemon_app/models/pokemon.dart';
import 'package:pokemon_app/blocs/pokemon_bloc.dart';
import 'package:pokemon_app/blocs/pokemon_event.dart';
import 'package:pokemon_app/ui/views/stream_builder.dart';

class Search extends StatelessWidget {
  final TextEditingController nameOrIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Search Pokemon')),
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
                      return errorBlock('Can\'t find the pokemon');
                    }
                    return Container();
                  },
                ),
                Spacer(),
                Container(
                  child: Row(
                    children: [
                      SizedBox(
                        child: TextField(
                          controller: nameOrIdController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Pokemon Name or Id',
                          ),
                        ),
                        width: 300.0,
                      ),
                      Spacer(),
                      RaisedButton(
                        child: Container(child: Text('Search')),
                        onPressed: () {
                          if (nameOrIdController.text.isNotEmpty)
                            bloc.eventSink.add(SearchPokemonEvent(
                                nameOrId: nameOrIdController.text));
                        },
                        textColor: Colors.white,
                        color: Color(0xff223256),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ],
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
