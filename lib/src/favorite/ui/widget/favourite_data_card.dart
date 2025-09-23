import 'package:flutter/material.dart';

class FavouriteDataCard extends StatelessWidget {
  const FavouriteDataCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 450,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),

        color: Colors.cyan.shade300,
      ),

      //TODO design favourite data card
      child: ListTile(
        leading: CircleAvatar(child: Placeholder()),
        title: Text("Helelels"),
        subtitle: Text("550"),
        trailing: Row(children: [
            
          ],
        ),
      ),
    );
  }
}
