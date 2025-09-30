import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.name,
    required this.cartPress,
    required this.favoritePress,
    required this.iconSize,
    required this.description,
    required this.price,
    required this.isFavorite,
  });
  final String name, description;
  final double iconSize;
  final double price;
  final VoidCallback cartPress, favoritePress;
  final bool isFavorite;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 320,
      constraints: BoxConstraints(maxHeight: 450, maxWidth: 300),
      decoration: BoxDecoration(),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Stack(
            alignment: AlignmentGeometry.topRight,

            children: [
              Container(
                height: iconSize + 13,
                width: iconSize + 13,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: IconButton(
                    onPressed: favoritePress,
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_outline,
                      color: isFavorite ? Colors.pink : null,
                      size: iconSize,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    SizedBox(height: 100, child: Placeholder()),
                    SizedBox(height: 2),
                    Text(name, maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text(
                      description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    // Spacer(flex: 2),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Price:$price"),
                        IconButton(
                          onPressed: cartPress,
                          icon: Icon(Icons.shopify, size: iconSize),
                        ),
                      ],
                    ),
                    // SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
