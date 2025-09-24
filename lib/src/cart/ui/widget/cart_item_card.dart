import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.onCartProductPress,

    required this.productName,
    required this.price,
    required this.deletePress,
  });
  final VoidCallback onCartProductPress, deletePress;
  final String productName, price;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,

      width: 450,

      decoration: BoxDecoration(
        color: Colors.lightGreen.shade400,
        borderRadius: BorderRadius.circular(15),
      ),

      child: Center(
        child: ListTile(
          onTap: onCartProductPress,
          leading: CircleAvatar(child: Placeholder()),
          title: Text(productName),
          subtitle: Text(price, style: TextStyle(fontSize: 12)),
          trailing: IconButton(
            onPressed: deletePress,
            icon: Icon(Icons.delete),
          ),
        ),
      ),
    );
  }
}
