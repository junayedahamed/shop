// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ocad/src/home/bloc/home_bloc.dart';
// import 'package:ocad/src/home/ui/widget/product_card.dart';
// import 'package:ocad/src/model/product_model/product_model.dart';
// import 'package:ocad/src/util/responsive_util.dart';

// class FoodTab extends StatefulWidget {
//   const FoodTab({super.key});

//   @override
//   State<FoodTab> createState() => _FoodTabState();
// }

// class _FoodTabState extends State<FoodTab> {
//   final HomeBloc homeBloc = HomeBloc();
//   final ScrollController scrollController = ScrollController();
//   @override
//   void initState() {
//     homeBloc.add(FoodInitialEvent());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//     // log(w.toString());
//     int crossCount = 2;
//     double aspectRatio = 0.66;
//     double iconSize = 25;

//     // Use the ResponsiveUtils class to determine the device's screen size.
//     if (ResponsiveUtils.isMobile(context)) {
//       crossCount = 2;
//       iconSize = 25;
//       if (w >= 270 && w <= 420) {
//         aspectRatio = 0.60;
//       } else {
//         aspectRatio = 0.70;
//       }
//     } else if (ResponsiveUtils.isTablet(context)) {
//       crossCount = 3;
//       if (w <= 1000 && w >= 800) {
//         aspectRatio = 0.9;
//       } else {
//         aspectRatio = 0.72;
//       }

//       iconSize = 30;
//     } else if (ResponsiveUtils.isDesktop(context)) {
//       crossCount = 4;
//       aspectRatio = 1.15;
//       iconSize = 35;
//     }

//     // log(aspectRatio.toString());
//     return Scaffold(
//       body: RefreshIndicator(
//         onRefresh: () async {
//           homeBloc.add(OnrefreshEvent());
//         },
//         child: BlocConsumer<HomeBloc, HomeState>(
//           bloc: homeBloc,
//           listener: (context, state) {
//             if (state is AddedToCartState) {
//               //toast for android ios and web only
//               // Fluttertoast.showToast(
//               //   msg: 'Added to cart',
//               //   gravity: ToastGravity.CENTER,
//               //   toastLength: Toast.LENGTH_SHORT,
//               // );

//               //snackbar

//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(SnackBar(content: Text("Added in cart")));
//             }
//             if (state is AddedToFavouriteState) {
//               //toast for android ios and web only
//               // Fluttertoast.showToast(msg: 'Added to Favorite');

//               //snackbar
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(SnackBar(content: Text("Added in favorite")));
//             }
//           },
//           buildWhen: (previous, current) => current is! HomeActionState,
//           listenWhen: (previous, current) => current is HomeActionState,

//           builder: (context, state) {
//             switch (state) {
//               case FoodLoadingState():
//                 return Center(child: CircularProgressIndicator());

//               case FoodLoadFailedState():
//                 final errorMsg = state.errorMessage;
//                 return Center(child: Text(errorMsg.toString()));
//               case FoodLoadedState():
//                 final data = state.data
//                     .where((element) => element.category == Category.food)
//                     .toList();
//                 // log(data.toString());
//                 return GridView.builder(
//                   controller: scrollController,
//                   shrinkWrap: true,
//                   itemCount: data.length,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: crossCount,
//                     crossAxisSpacing: 15,

//                     childAspectRatio: aspectRatio,
//                     mainAxisSpacing: 10,
//                   ),
//                   itemBuilder: (context, index) {
//                     // log(data[index].toString());
//                     // final price = double.parse(data[index]['price']);
//                     // log((data[index]['price'].runtimeType).toString());
//                     final datacell = data[index];
//                     return ProductCard(
//                       description: datacell.description,
//                       iconSize: iconSize,
//                       name: datacell.productname,
//                       price: datacell.price,
//                       cartPress: () {
//                         homeBloc.add(AddToCartEvent(data: data[index]));
//                       },
//                       favoritePress: () {
//                         homeBloc.add(AddToFavouriteEvent(data: data[index]));
//                       },
//                     );
//                   },
//                 );
//               default:
//                 return SizedBox.shrink();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
