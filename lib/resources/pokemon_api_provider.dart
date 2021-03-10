import 'package:http/http.dart' as http;
import 'package:pokemon_app/models/pokemon.dart';

import 'dart:convert';

class PokemonApiProvider {
  final url = 'https://pokeapi.co/api/v2/pokemon/';

  Future<Pokemon> fetchPokemon(String nameOrId) async {
    final response = await http.get(url + nameOrId);

    if (response.statusCode == 200) {
      return Pokemon.fromJson(jsonDecode(response.body));
    }

    throw Exception('Failed to get response.');
  }
}
