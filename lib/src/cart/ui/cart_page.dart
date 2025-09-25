import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocad/src/cart/bloc/cart_bloc.dart';
import 'package:ocad/src/cart/ui/widget/cart_item_card.dart';
import 'package:ocad/src/database/demo_data.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});
  final CartBloc cartBloc = CartBloc();
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

        if (RuntimeData.cart.isEmpty) {
          return Center(child: Text("Cart is Empty"));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemCount: RuntimeData.cart.length,

            itemBuilder: (context, index) {
              return CartItemCard(
                onCartProductPress: () {
                  //navigate another page
                },
                productName: RuntimeData.cart[index]['name'],
                price: RuntimeData.cart[index]['email'],
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
