import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocad/src/database/demo_data.dart';
import 'package:ocad/src/favorite/bloc/favorite_bloc.dart';
import 'package:ocad/src/favorite/ui/widget/favourite_data_card.dart';
import 'package:ocad/src/home/bloc/home_bloc.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final FavoriteBloc favoriteBloc = FavoriteBloc();

  final HomeBloc homeBloc = HomeBloc();
  @override
  void initState() {
    favoriteBloc.add(FavoriteDataInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<FavoriteBloc, FavoriteState>(
        bloc: favoriteBloc,
        buildWhen: (previous, current) => current is! FavoriteActionState,
        listenWhen: (previous, current) => current is FavoriteActionState,
        listener: (context, state) {
          if (state is FavoriteRemovedMessageState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.removedMessage)));
          }
        },
        builder: (context, state) {
          // print(state);
          switch (state) {
            case FavoriteInitialDataLoadingSate():
              return Center(child: CircularProgressIndicator());

            case FavoriteInitialDataLoadedSate():
              final data = favorite.reversed.toList();
              // log(data.toString());
              if (data.isNotEmpty) {
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },

                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final datacell = data[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: FavouriteDataCard(
                        addToCart: () {
                          homeBloc.add(AddToCartEvent(data: datacell));
                        },
                        unfavoritePress: () {
                          favoriteBloc.add(RemoveFromFavEvent(item: datacell));
                        },

                        onFavProductPress: () {},
                        price: datacell.price.toString(),
                        productName: datacell.productname,
                      ),
                    );
                  },
                );
              } else {
                return Center(child: Text("Nothing in favorite"));
              }
            case FavoriteInitialDataLoadErrorSate():
              return Center(child: Text(state.errormessage));
            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
