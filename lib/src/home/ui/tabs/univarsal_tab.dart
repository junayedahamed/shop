import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocad/src/cart/bloc/cart_bloc.dart';
import 'package:ocad/src/database/demo_data.dart';
import 'package:ocad/src/home/bloc/home_bloc.dart';
import 'package:ocad/src/home/ui/widget/product_card.dart';
import 'package:ocad/src/model/product_model/product_model.dart';
import 'package:ocad/src/product_details/ui/widget/product_details_page.dart';
import 'package:ocad/src/util/responsive_util.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../favorite/bloc/favorite_bloc.dart';

class UniversalTab extends StatefulWidget {
  const UniversalTab({super.key, required this.category});

  final Category category;
  @override
  State<UniversalTab> createState() => _UniversalTabState();
}

class _UniversalTabState extends State<UniversalTab> {
  final HomeBloc homeBloc = HomeBloc();
  final FavoriteBloc favoriteBloc = FavoriteBloc();
  final ScrollController scrollController = ScrollController();
  final CartBloc cartBloc = CartBloc();
  @override
  void initState() {
    getAllNecessary();
    super.initState();
  }

  void getAllNecessary() async {
    await Future.microtask(() {
      homeBloc.add(FoodInitialEvent());
    });
    await Future.microtask(() {
      favoriteBloc.add(FavoriteDataInitialEvent());
    });
    await Future.microtask(() {
      cartBloc.add(CartInitialEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    // final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    // log(w.toString());s
    int crossCount = 2;
    double aspectRatio = 0.66;
    double iconSize = 25;

    // Use the ResponsiveUtils class to determine the device's screen size.
    if (ResponsiveUtils.isMobile(context)) {
      crossCount = 2;
      iconSize = 25;
      if (w >= 270 && w <= 420) {
        aspectRatio = 0.60;
      } else {
        aspectRatio = 0.70;
      }
    } else if (ResponsiveUtils.isTablet(context)) {
      crossCount = 3;
      if (w <= 1000 && w >= 800) {
        aspectRatio = 0.9;
      } else {
        aspectRatio = 0.72;
      }

      iconSize = 30;
    } else if (ResponsiveUtils.isDesktop(context)) {
      crossCount = 4;
      aspectRatio = 1.15;
      iconSize = 35;
    }

    // log(aspectRatio.toString());
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          homeBloc.add(OnrefreshEvent());
        },
        child: BlocConsumer<HomeBloc, HomeState>(
          bloc: homeBloc,
          listener: (context, state) {
            if (state is AddedToCartMsgState) {
              //toast for android ios and web only
              // Fluttertoast.showToast(
              //   msg: 'Added to cart',
              //   gravity: ToastGravity.CENTER,
              //   toastLength: Toast.LENGTH_SHORT,
              // );

              //snackbar

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.cartAddMessage)));
            }
            if (state is AddedToFavouriteState) {
              //toast for android ios and web only
              // Fluttertoast.showToast(msg: 'Added to Favorite');
              // final message = state.message;
              //snackbar
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          buildWhen: (previous, current) => current is! HomeActionState,
          listenWhen: (previous, current) => current is HomeActionState,

          builder: (context, state) {
            switch (state) {
              case FoodLoadingState():
                return Skeletonizer(
                  enabled: true,
                  effect: ShimmerEffect(),
                  enableSwitchAnimation: true,
                  child: GridView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossCount,
                      crossAxisSpacing: 15,

                      childAspectRatio: 0.66,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return ProductCard(
                        isFavorite: false,
                        description: 'Loading...',
                        iconSize: iconSize,
                        name: 'Loading...',
                        price: 0.0,
                        cartPress: () {},
                        favoritePress: () {},
                      );
                    },
                  ),
                );

              case FoodLoadFailedState():
                final errorMsg = state.errorMessage;
                return Center(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Center(child: Text(errorMsg.toString())),
                    ),
                  ),
                );
              case FoodLoadedState():
                final data = state.data
                    .where((element) => element.category == widget.category)
                    .toList();
                final favorited = data
                    .map((e) => favorite.contains(e))
                    .toList();
                // log(favorited.toString());
                // log(data.toString());
                return GridView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  itemCount: data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossCount,
                    crossAxisSpacing: 15,

                    childAspectRatio: aspectRatio,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    // log(data[index].toString());
                    // final price = double.parse(data[index]['price']);
                    // log((data[index]['price'].runtimeType).toString());
                    final datacell = data[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(
                              product: datacell,
                              isFavorite: favorited[index],
                            ),
                          ),
                        );
                      },
                      child: ProductCard(
                        isFavorite: favorited[index],
                        description: datacell.description,
                        iconSize: iconSize,
                        name: datacell.productname,
                        price: datacell.price,
                        cartPress: () {
                          homeBloc.add(AddToCartEvent(data: data[index]));
                        },
                        favoritePress: () {
                          homeBloc.add(AddToFavouriteEvent(data: data[index]));
                        },
                      ),
                    );
                  },
                );

              default:
                return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
