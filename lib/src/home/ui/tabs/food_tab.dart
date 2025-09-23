import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocad/src/home/bloc/home_bloc.dart';
import 'package:ocad/src/home/ui/widget/product_card.dart';

class FoodTab extends StatefulWidget {
  const FoodTab({super.key});

  @override
  State<FoodTab> createState() => _FoodTabState();
}

class _FoodTabState extends State<FoodTab> {
  final HomeBloc homeBloc = HomeBloc();
  @override
  void initState() {
    homeBloc.add(FoodInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listener: (context, state) {
          if (state is AddedToCartState) {
            //toast for android ios and web only
            // Fluttertoast.showToast(
            //   msg: 'Added to cart',
            //   gravity: ToastGravity.CENTER,
            //   toastLength: Toast.LENGTH_SHORT,
            // );

            //snackbar

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Adde in cart")));
          }
          if (state is AddedToFavouriteState) {
            //toast for android ios and web only
            // Fluttertoast.showToast(msg: 'Added to Favorite');

            //snackbar
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Adde in favorite")));
          }
        },
        buildWhen: (previous, current) => current is! HomeActionState,
        listenWhen: (previous, current) => current is HomeActionState,

        builder: (context, state) {
          switch (state) {
            case FoodLoadingState():
              return Center(child: CircularProgressIndicator());

            case FoodLoadFailedState():
              return Center(child: Text("Failed to load data"));
            case FoodLoadedState():
              final data = state.data;
              return GridView.builder(
                itemCount: data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.66,
                ),
                itemBuilder: (context, index) {
                  // log(data[index].toString());
                  return ProductCard(
                    name: data[index]['name'],
                    cartPress: () {
                      homeBloc.add(AddToCartEvent(data: data[index]));
                    },
                    favoritePress: () {
                      homeBloc.add(AddToFavouriteEvent(data: data[index]));
                    },
                  );
                },
              );
            default:
              return Center(child: Text(state.toString()));
          }
        },
      ),
    );
  }
}
