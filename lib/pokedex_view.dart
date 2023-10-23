// import 'package:assesmant_task/bloc/pokemon_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'bloc/pokemon_state.dart';

// class PokedexView extends StatelessWidget {
//   const PokedexView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Pokedex'),
//       ),
//       body: BlocBuilder<PokemonBloc, PokemonState>(
//         builder: (context, state) {
//           if (state is PokemonLoadInProgress) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (state is PokemonPageLoadSuccess) {
//             return GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3),
//               itemCount: state.pokemonListings!.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   child: GridTile(
//                     child: Column(
//                       children: [
//                         Image.network(state.pokemonListings![index].imageUrl),
//                         Text(state.pokemonListings![index].name!)
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else if (state is PokemonPageLoadFailed) {
//             return Center(
//               child: Text(state.error.toString()),
//             );
//           } else {
//             return Container();
//           }
//         },
//       ),
//     );
//   }
// }
