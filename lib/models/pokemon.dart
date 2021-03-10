import 'package:pokemon_app/utils/string.dart';

class Pokemon {
  final int id;
  final int height;
  final int weight;
  final String name;
  final String type;

  const Pokemon({this.id, this.name, this.type, this.height, this.weight});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      weight: json['weight'],
      height: json['height'],
      name: capitalize(json['name']),
      type: capitalize(json['types'][0]['type']['name']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name.toLowerCase(),
      'type': type,
      'height': height,
      'weight': weight,
    };
  }
}
