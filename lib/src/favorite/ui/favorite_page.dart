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
          if (fav.isNotEmpty) {
            return ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },

              itemCount: fav.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: FavouriteDataCard(
                    unfavoritePress: () {},
                    deletePress: () {},
                    onFavProductPress: () {},
                    price: fav[index]['email'],
                    productName: fav[index]['name'],
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("Nothing in favorite"));
          }
        },
      ),
    );
  }
}
