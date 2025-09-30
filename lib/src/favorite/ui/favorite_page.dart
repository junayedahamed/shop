import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocad/src/favorite/bloc/favorite_bloc.dart';
import 'package:ocad/src/favorite/ui/widget/favourite_data_card.dart';
import 'package:ocad/src/home/bloc/home_bloc.dart';
import 'package:ocad/src/product_details/ui/widget/product_details_page.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
    return BlocConsumer<FavoriteBloc, FavoriteState>(
      bloc: favoriteBloc,
      buildWhen: (previous, current) => current is! FavoriteActionState,
      listenWhen: (previous, current) => current is FavoriteActionState,
      listener: (context, state) {
        if (state is FavoriteRemovedMessageState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.removedMessage)));
        }
        if (state is FavoriteRemoveErrorState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        // print(state);
        switch (state) {
          case FavoriteInitialDataLoadingSate():
            return Skeletonizer(
              effect: ShimmerEffect(),
              enabled: true,
              enableSwitchAnimation: true,

              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: FavouriteDataCard(
                      addToCart: () {
                        // homeBloc.add(AddToCartEvent(data: datacell));
                      },
                      unfavoritePress: () {
                        // favoriteBloc.add(RemoveFromFavEvent(item: datacell));
                      },

                      onFavProductPress: () {},
                      price: "datacell.price".toString(),
                      productName: "datacell.productname",
                    ),
                  );
                },
              ),
            );

          case FavoriteInitialDataLoadedSate():
            final data = state.productData.reversed.toList();
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

                      onFavProductPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(
                              product: datacell,
                              isFavorite: true,
                            ),
                          ),
                        );
                      },
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
    );
  }
}
