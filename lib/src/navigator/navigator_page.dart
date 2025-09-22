import 'package:flutter/material.dart';
import 'package:ocad/src/account/ui/account_page.dart';
import 'package:ocad/src/cart/ui/cart_page.dart';
import 'package:ocad/src/favorite/ui/favorite_page.dart';
import 'package:ocad/src/home/ui/home_page.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  final List pages = [HomePage(), FavoritePage(), CartPage(), AccountPage()];
  int index = 0;
  void changeSelection(int indx) {
    setState(() {
      index = indx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shop")),
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
            backgroundColor: Colors.cyanAccent,
            tooltip: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '',
            tooltip: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '',
            tooltip: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
            tooltip: 'Account',
          ),
        ],
        onTap: changeSelection,
      ),
    );
  }
}
