import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.name,
    required this.cartPress,
    required this.favoritePress,
  });
  final String name;
  final VoidCallback cartPress, favoritePress;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Container(
      height: h * .30,
      width: w * .45,
      constraints: BoxConstraints(maxHeight: 450, maxWidth: 300),
      decoration: BoxDecoration(),
      child: Card(
        // color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Stack(
            alignment: AlignmentGeometry.topRight,
            children: [
              IconButton(
                onPressed: favoritePress,
                icon: Icon(Icons.favorite_outline),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  SizedBox(height: 2),
                  SizedBox(height: 100, child: Placeholder()),
                  Text(name),
                  Text("Product Desc..................................."),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Price:1111"),
                      IconButton(
                        onPressed: cartPress,
                        icon: Icon(Icons.shopify),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
