import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ocad/src/account/ui/widget/profile_tiles.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Center(
            child: CircleAvatar(
              maxRadius: 35,
              minRadius: 20,
              child: Image.network(
                // errorBuilder: (context, error, stackTrace) {
                //   return Icon(Icons.person, size: 30);
                // },
                "https://c9yois02lm.ufs.sh/f/RXJBrPvyVfAxYX3edhJSAb5pao2WXGiI8NF04zLZqOKJlnyt",
                // loadingBuilder: (context, child, loadingProgress) {
                //   log((loadingProgress?.expectedTotalBytes).toString());
                //   return CircularProgressIndicator();
                // },
              ),
            ),
          ),
          Text(
            "User name",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Text("Member since 2025", style: TextStyle(color: Colors.grey)),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(),
          ),
          Column(
            spacing: 15,
            children: [
              ProfileTiles(
                leadingIcon: Icons.person_outline,
                tileName: "Personal Information",
                ontap: () {},
              ),
              ProfileTiles(
                leadingIcon: Icons.location_on,
                tileName: "Set up location",
                ontap: () {},
              ),
              ProfileTiles(
                leadingIcon: Icons.edit,
                tileName: "Update Information",
                ontap: () {},
              ),

              ProfileTiles(
                leadingIcon: Icons.settings,
                tileName: "Settings",
                ontap: () {},
              ),
              ProfileTiles(
                leadingIcon: Icons.security,
                tileName: "Security",
                ontap: () {},
              ),
              ProfileTiles(
                leadingIcon: Icons.help,
                tileName: "Help",
                ontap: () {},
              ),
            ],
          ),
          Divider(),
          ProfileTiles(
            leadingIcon: Icons.logout,
            tileName: "Logout",
            ontap: () {},
          ),
        ],
      ),
    );
  }
}
