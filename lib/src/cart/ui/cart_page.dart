import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocad/src/cart/bloc/cart_bloc.dart';
import 'package:ocad/src/cart/ui/widget/cart_item_card.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartBloc cartBloc = CartBloc();
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

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

        if (state is CartLoadErrorMsgState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errormessage)));
        }
        //log(state.toString());
      },
      buildWhen: (previous, current) => current is! CartActionState,
      listenWhen: (previous, current) => current is CartActionState,

      builder: (context, state) {
        switch (state) {
          case CartLoadingState():
            //log("all ok");
            return Center(child: CircularProgressIndicator());

          case CartDataLoadedState():
            //log("all loaded");
            final data = state.cartData;
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
                      //log(index.toString());
                      cartBloc.add(RemoveFromCartEvent(index: index));
                    },
                  );
                },
              ),
            );
          case CartDataLoadErrorState():
            return Center(child: Text("Smoething went wrong"));
          default:
            return Center(child: Text(((state)).toString()));
        }
      },
    );
  }
}
