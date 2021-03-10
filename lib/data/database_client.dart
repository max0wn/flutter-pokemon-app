import 'package:pokemon_app/utils/string.dart';

import 'package:pokemon_app/models/pokemon.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

class DatabaseClient {
  Future<Database> init() async {
    return openDatabase(
      join(await getDatabasesPath(), 'pokemons_db.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE pokemons(id INTEGER PRIMARY KEY UNIQUE, name TEXT, type TEXT, height INTEGER, weight INTEGER)');
      },
      version: 1,
    );
  }

  Future<void> insertPokemon(Pokemon pokemon) async {
    final Database db = await init();

    await db.insert(
      'pokemons',
      pokemon.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Pokemon>> pokemons() async {
    final Database db = await init();

    final List<Map<String, dynamic>> maps = await db.query('pokemons');

    return List.generate(maps.length, (i) {
      return Pokemon(
        id: maps[i]['id'],
        name: capitalize(maps[i]['name']),
        type: maps[i]['type'],
        height: maps[i]['height'],
        weight: maps[i]['weight'],
      );
    });
  }

  Future<Pokemon> selectPokemonById(String id) async {
    final Database db = await init();

    final List<Map> maps = await db.query('pokemons',
        columns: ['id', 'name', 'type', 'height', 'weight'],
        where: '"id" = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return Pokemon(
        id: maps[0]['id'],
        name: capitalize(maps[0]['name']),
        type: maps[0]['type'],
        height: maps[0]['height'],
        weight: maps[0]['weight'],
      );
    }

    return null;
  }

  Future<Pokemon> selectPokemonByName(String name) async {
    final Database db = await init();

    final List<Map> maps = await db.query('pokemons',
        columns: ['id', 'name', 'type', 'height', 'weight'],
        where: '"name" = ?',
        whereArgs: [name.toLowerCase()]);

    if (maps.length > 0) {
      return Pokemon(
        id: maps[0]['id'],
        name: capitalize(maps[0]['name']),
        type: maps[0]['type'],
        height: maps[0]['height'],
        weight: maps[0]['weight'],
      );
    }

    return null;
  }
}
