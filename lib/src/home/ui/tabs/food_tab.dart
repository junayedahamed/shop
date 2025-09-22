import 'dart:developer';

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
        listener: (context, state) {},
        buildWhen: (previous, current) => current is! HomeActionState,
        listenWhen: (previous, current) => current is HomeActionState,

        builder: (context, state) {
          switch (state) {
            case FoodLoadingState():
              return Center(child: CircularProgressIndicator());

            case FoodLoadFailedState():
              return Center(child: Text("Failed to load"));
            case FoodLoadedState():
              final data = state.data;
              return GridView.builder(
                itemCount: data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  // log(data[index]);
                  return ProductCard();
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
