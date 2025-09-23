import 'package:flutter/material.dart';

class FavouriteDataCard extends StatelessWidget {
  const FavouriteDataCard({
    super.key,
    required this.onFavProductPress,

    required this.productName,
    required this.price,
    required this.unfavoritePress,
  });
  final VoidCallback onFavProductPress, unfavoritePress;
  final String productName, price;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 450,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),

        color: Colors.cyan.shade300,
      ),

      child: Center(
        child: ListTile(
          onTap: onFavProductPress,
          leading: CircleAvatar(child: Placeholder()),
          title: Text(productName),
          subtitle: Text(price, style: TextStyle(fontSize: 12)),
          trailing: IconButton(
            onPressed: unfavoritePress,
            icon: Icon(Icons.favorite),
          ),
        ),
      ),
    );
  }
}
