import 'package:flutter/material.dart';

class NavBarTop extends StatelessWidget {
  const NavBarTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // create navbar button with spacing contain : profile, aeroport, avions, vols, logout
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // profile
          Container(
            width: 50,
            child: IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {},
            ),
          ),
          // aeroport
          Container(
            width: 50,
            child: IconButton(
              icon: const Icon(Icons.airplanemode_active),
              onPressed: () {},
            ),
          ),
          // avions
          Container(
            width: 50,
            child: IconButton(
              icon: const Icon(Icons.airplanemode_active),
              onPressed: () {},
            ),
          ),
          // vols
          Container(
            width: 50,
            child: IconButton(
              icon: const Icon(Icons.airplanemode_active),
              onPressed: () {},
            ),
          ),
          // logout
          Container(
            width: 50,
            child: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
