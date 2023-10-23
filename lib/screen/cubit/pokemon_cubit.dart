import 'dart:convert';
import 'package:assesmant_task/core/model/pokemon_page_response.dart';
import 'package:assesmant_task/core/repositry/auth_repository.dart';
import 'package:assesmant_task/core/repositry/pokemon_repository.dart';
import 'package:assesmant_task/screen/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokemonCubit extends Cubit<PokemonState> {
  final _pokemonRepository = PokemonRepository();

  List<PokemonListing> favoritePokemonList = [];

  PokemonCubit() : super(PokemonInitial());
  AuthRepository auth = AuthRepository();
  Future<void> loadPokemonPage(int page) async {
    emit(PokemonLoadInProgress());

    try {
      final pokemonPageResponse = await _pokemonRepository.getPokemonPage(page);
      emit(PokemonPageLoadSuccess(
          pokemonListings: pokemonPageResponse.pokemonListings,
          canLoadNextPage: pokemonPageResponse.canLoadNextPage));
    } catch (e) {
      // emit(PokemonPageLoadFailed(error: e));
    }
  }

  Future<void> logout() async {
    await auth.logout().then((value) => Get.to(() => LoginPage()));
  }

  Future<void> toggleFavoritePokemon(PokemonListing pokemon) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final favoritePokemonList =
        sharedPreferences.getStringList('favoritePokemonList') ?? [];

    favoritePokemonList.add(jsonEncode(pokemon.toMap()));
    await sharedPreferences.setStringList(
        'favoritePokemonList', favoritePokemonList);
    loadAppData();
  }

  Future<void> loadAppData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final _favoritePokemonList =
        sharedPreferences.getStringList('favoritePokemonList') ?? [];

    favoritePokemonList = _favoritePokemonList.map((data) {
      Map<String, dynamic> map = jsonDecode(data);
      return PokemonListing.fromMap(map);
    }).toList();
    emit(state);
  }
}

abstract class PokemonState {}

class PokemonInitial extends PokemonState {}

class PokemonLoadInProgress extends PokemonState {}

class PokemonPageLoadSuccess extends PokemonState {
  final List<PokemonListing>? pokemonListings;
  final bool? canLoadNextPage;

  PokemonPageLoadSuccess(
      {@required this.pokemonListings, @required this.canLoadNextPage});
}

class PokemonPageLoadFailed extends PokemonState {
  final Error? error;

  PokemonPageLoadFailed({@required this.error});
}
