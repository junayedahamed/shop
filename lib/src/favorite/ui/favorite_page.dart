import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocad/src/database/demo_data.dart';
import 'package:ocad/src/favorite/bloc/favorite_bloc.dart';
import 'package:ocad/src/favorite/ui/widget/favourite_data_card.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({super.key});
  final FavoriteBloc favoriteBloc = FavoriteBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<FavoriteBloc, FavoriteState>(
        bloc: favoriteBloc,
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.builder(
            itemCount: fav.length,
            itemBuilder: (context, index) {
              return FavouriteDataCard();
            },
          );
        },
      ),
    );
  }
}
