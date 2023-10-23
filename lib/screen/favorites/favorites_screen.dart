// ignore_for_file: must_be_immutable

import 'package:assesmant_task/core/constant/colors.dart';
import 'package:assesmant_task/core/model/pokemon_page_response.dart';
import 'package:assesmant_task/core/utils/utils.dart';
import 'package:assesmant_task/screen/cubit/pokemon_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesScreen extends StatefulWidget {
  FavoritesScreen({super.key, required this.favoritePokemonList});
  List<PokemonListing> favoritePokemonList;

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final _pokemonCubit = PokemonCubit();
  @override
  void initState() {
    super.initState();
    _pokemonCubit.loadPokemonPage(1);
    _pokemonCubit.loadAppData();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<PokemonCubit>(context);
    print(cubit.favoritePokemonList.length);
    return Scaffold(
      appBar: AppBar(
        title: const Text('favorites'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
              itemCount: widget.favoritePokemonList.length,
              itemBuilder: (context, index) {
                // Fill the favorites icon red if the current Pokemon is a favorite

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
                        Container(
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/pokeball.png'),
                                    opacity: 0.1)),
                            child: getSvgImage(
                                imageName:
                                    widget.favoritePokemonList[index].imageUrl,
                                height: 0.120.sh,
                                width: 0.130.sw)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(widget.favoritePokemonList[index].name!,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
