import 'package:pokemon_app/models/pokemon.dart';
import 'package:pokemon_app/resources/pokemon_api_provider.dart';

class Repository {
  final PokemonApiProvider api = PokemonApiProvider();

  Future<Pokemon> fetchPokemon(String nameOrId) => api.fetchPokemon(nameOrId);
}
