import 'dart:convert';

import 'package:assesmant_task/core/model/pokemon_page_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDataCubit extends Cubit<AppDataState> {
  AppDataCubit() : super(AppDataState.initial());
  List<PokemonListing> favoritePokemonList = [];
  Future<void> loadAppData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final _favoritePokemonList =
        sharedPreferences.getStringList('favoritePokemonList') ?? [];

    favoritePokemonList = _favoritePokemonList.map((data) {
      Map<String, dynamic> map = jsonDecode(data);
      return PokemonListing.fromMap(map);
    }).toList();
  }
}

class AppDataState {
  final List<PokemonListing> favoritePokemonList;

  AppDataState({required this.favoritePokemonList});

  factory AppDataState.initial() => AppDataState(favoritePokemonList: []);
}
