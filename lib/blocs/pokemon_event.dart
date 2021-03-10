import 'dart:math';

final Random _random = Random();

abstract class PokemonEvent {
  final String nameOrId;

  PokemonEvent(this.nameOrId);
}

class SearchPokemonEvent extends PokemonEvent {
  final String nameOrId;

  SearchPokemonEvent({this.nameOrId}) : super(nameOrId);
}

class RandomPokemonEvent extends PokemonEvent {
  RandomPokemonEvent() : super((_random.nextInt(899) + 1).toString());
}
