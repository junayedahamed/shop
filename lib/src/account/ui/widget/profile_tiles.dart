import 'package:flutter/material.dart';

class ProfileTiles extends StatelessWidget {
  const ProfileTiles({
    super.key,
    required this.tileName,
    required this.ontap,
    required this.leadingIcon,
  });
  final String tileName;
  final VoidCallback ontap;
  final IconData leadingIcon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        height: 45,
        decoration: BoxDecoration(
          border: Border.all(width: .7, color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Row(
                spacing: 10,
                children: [
                  Icon(leadingIcon, size: 22, color: Colors.grey.shade700),
                  Text(
                    tileName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey.shade700,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
