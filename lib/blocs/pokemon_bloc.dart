import 'dart:async';

import 'pokemon_event.dart';

import 'package:pokemon_app/models/pokemon.dart';
import 'package:pokemon_app/data/database_client.dart';
import 'package:pokemon_app/resources/repository.dart';

class PokemonBloc {
  final client = DatabaseClient();
  final _repository = Repository();
  final _eventController = StreamController<PokemonEvent>();
  final _stateController = StreamController<Pokemon>.broadcast();

  Stream<Pokemon> get pokemon => _stateController.stream;
  StreamSink<Pokemon> get _pokemon => _stateController.sink;
  Sink<PokemonEvent> get eventSink => _eventController.sink;

  PokemonBloc() {
    _eventController.stream.listen((event) => _eventToState(event));
  }

  _pullFromCache(dynamic param) async {
    return num.tryParse(param) == null
        ? await client.selectPokemonByName(param)
        : await client.selectPokemonById(param);
  }

  _eventToState(PokemonEvent event) async {
    Pokemon pokemon = await _pullFromCache(event.nameOrId);
    if (pokemon == null) {
      try {
        pokemon = await _repository.fetchPokemon(event.nameOrId);
      } catch (Exception) {
        _pokemon.addError('Failed to fetch pokemon.');
        return;
      }
      await client.insertPokemon(pokemon);
    }
    _pokemon.add(pokemon);
  }

  dispose() {
    _stateController.close();
    _eventController.close();
  }
}

final PokemonBloc bloc = PokemonBloc();
