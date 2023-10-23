import 'package:flutter/foundation.dart';
/*
count:1118
next:"https://pokeapi.co/api/v2/pokemon?offset=300&limit=100"
previous:"https://pokeapi.co/api/v2/pokemon?offset=100&limit=100"
result: [  {name:"unown"
  url:"https://pokeapi.co/api/v2/pokemon/201/"}
  {name:"wobbuffet"
  url:"https://pokeapi.co/api/v2/pokemon/202/"}
]
 */

class PokemonListing {
  final int? id;
  final String? name;
  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/$id.svg';

  PokemonListing({@required this.id, @required this.name});

  factory PokemonListing.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    final url = json['url'] as String;
    final id = int.parse(url.split('/')[6]);

    return PokemonListing(id: id, name: name);
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'id': id,
    };
  }

  factory PokemonListing.fromMap(Map<String, dynamic> map) {
    return PokemonListing(
      name: map['name'],
      id: map['id'],
    );
  }
}

class PokemonPageResponse {
  final List<PokemonListing>? pokemonListings;
  final bool? canLoadNextPage;

  PokemonPageResponse(
      {@required this.pokemonListings, @required this.canLoadNextPage});

  factory PokemonPageResponse.fromJson(Map<String, dynamic> json) {
    final canLoadNextPage = json['next'] != null;
    final pokemonListings = (json['results'] as List)
        .map((listingJson) => PokemonListing.fromJson(listingJson))
        .toList();

    return PokemonPageResponse(
        pokemonListings: pokemonListings, canLoadNextPage: canLoadNextPage);
  }
}
