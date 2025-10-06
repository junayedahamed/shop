import 'package:flutter/material.dart';
import 'package:ocad/src/account/fetch_user_data/fetch_user_data.dart';
import 'package:ocad/src/account/ui/widget/null_account.dart';
import 'package:ocad/src/account/ui/widget/profile_tiles.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final FetchUserData fetchUserData = FetchUserData();
  @override
  void initState() {
    fetchUserData.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: fetchUserData,
      builder: (context, asyncSnapshot) {
        return SingleChildScrollView(
          child: fetchUserData.user != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CircleAvatar(
                          maxRadius: 35,
                          minRadius: 20,
                          child: Image.network(
                            // errorBuilder: (context, error, stackTrace) {
                            //   return Icon(Icons.person, size: 30);
                            // },
                            fetchUserData.user?.profileImage ??
                                "https://c9yois02lm.ufs.sh/f/RXJBrPvyVfAxxuWHv4z3g6Ua32SlhOEPT9iwZ1z8GCQDWjyF",
                            // loadingBuilder: (context, child, loadingProgress) {
                            //   log((loadingProgress?.expectedTotalBytes).toString());
                            //   return CircularProgressIndicator();
                            // },
                          ),
                        ),
                      ),
                    ),
                    Text(
                      fetchUserData.user?.name ?? "No name",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "User from ${fetchUserData.user?.createdAt.year.toString() ?? " -- "}",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(fetchUserData.user?.email ?? "No email"),
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
                          leadingIcon: Icons.shopping_bag_outlined,
                          tileName: "My orders",
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
                )
              : NullUserAccount(),
        );
      },
    );
  }
}
