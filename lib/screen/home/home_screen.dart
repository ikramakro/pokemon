import 'package:assesmant_task/core/constant/colors.dart';
import 'package:assesmant_task/core/model/pokemon_page_response.dart';
import 'package:assesmant_task/core/utils/utils.dart';
import 'package:assesmant_task/screen/cubit/pokemon_cubit.dart';
import 'package:assesmant_task/screen/favorites/favorites_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PokemonList extends StatefulWidget {
  const PokemonList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  final _pokemonCubit = PokemonCubit();
  List<PokemonListing> favoritePokemonList1 = [];
  @override
  void initState() {
    super.initState();

    _pokemonCubit.loadPokemonPage(1);
    _pokemonCubit.loadAppData();

    print(_pokemonCubit.favoritePokemonList.length);
    favoritePokemonList1 = _pokemonCubit.favoritePokemonList;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: SafeArea(
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Get.back();
              },
              leading: const Icon(Icons.home),
              title: const Text('Home'),
            ),
            ListTile(
              onTap: () {
                Get.to(() => FavoritesScreen(
                      favoritePokemonList: _pokemonCubit.favoritePokemonList,
                    ));
              },
              leading: const Icon(Icons.favorite),
              title: const Text('Favorites'),
            ),
            ListTile(
              onTap: () {
                Get.back();
                _pokemonCubit.logout();
              },
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
            )
          ],
        ),
      )),
      appBar: AppBar(
        title: const Text('Pokedex'),
      ),
      body: BlocBuilder<PokemonCubit, PokemonState>(
        bloc: _pokemonCubit,
        builder: (context, state) {
          if (state is PokemonInitial) {
            return const CircularProgressIndicator();
          } else if (state is PokemonLoadInProgress) {
            return const LinearProgressIndicator();
          } else if (state is PokemonPageLoadSuccess) {
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8),
                    itemCount: state.pokemonListings!.length,
                    itemBuilder: (context, index) {
                      print(
                          '=====  ${_pokemonCubit.favoritePokemonList.length}');
                      // Check if the current Pokemon is a favorite
                      final isFavorite = favoritePokemonList1
                          .contains(state.pokemonListings![index]);
                      Get.log(isFavorite.toString());
                      // Fill the favorites icon red if the current Pokemon is a favorite
                      final favoritesIconColor =
                          isFavorite ? Colors.red : Colors.black;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.1),
                                offset: const Offset(-6.0, -6.0),
                                blurRadius: 16.0,
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.60),
                                offset: const Offset(6.0, 6.0),
                                blurRadius: 16.0,
                              ),
                            ],
                            color: kprimary1Color,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () =>
                                      _pokemonCubit.toggleFavoritePokemon(
                                          state.pokemonListings![index]),
                                  icon: Icon(Icons.favorite,
                                      color: favoritesIconColor),
                                ),
                              ),
                              Container(
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              AssetImage('assets/pokeball.png'),
                                          opacity: 0.1)),
                                  child: getSvgImage(
                                      imageName: state
                                          .pokemonListings![index].imageUrl,
                                      height: 0.120.sh,
                                      width: 0.130.sw)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(state.pokemonListings![index].name!,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is PokemonPageLoadFailed) {
            return Text(
              'Error loading Pokemon: ${state.error}',
              style: const TextStyle(color: Colors.red),
            );
          } else {
            return Text('Unknown state: $state');
          }
        },
      ),
    );
  }
}
