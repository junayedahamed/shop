import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocad/src/cart/bloc/cart_bloc.dart';
import 'package:ocad/src/cart/ui/widget/cart_item_card.dart';
import 'package:ocad/src/database/demo_data.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});
  final CartBloc cartBloc = CartBloc();
  // final RuntimeData runtimeData = RuntimeData();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      bloc: cartBloc,
      listener: (context, state) {
        if (state is RemovedFromCartMsgState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Removed From Cart")));
        }
        // log(state.toString());
      },
      buildWhen: (previous, current) => current is! CartActionState,
      listenWhen: (previous, current) => current is CartActionState,
      builder: (context, state) {
        // log(state.toString());
        final data = cart;
        if (data.isEmpty) {
          return Center(child: Text("Cart is Empty"));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemCount: data.length,

            itemBuilder: (context, index) {
              final datacell = data[index];
              return CartItemCard(
                onCartProductPress: () {
                  //navigate another page
                },
                productName: datacell.productname,
                price: datacell.price.toString(),
                deletePress: () {
                  log(index.toString());
                  cartBloc.add(RemoveFromCartEvent(index: index));
                },
              );
            },
          ),
        );
      },
    );
  }
}
