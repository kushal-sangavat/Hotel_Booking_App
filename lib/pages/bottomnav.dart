import 'package:flutter/material.dart';
import 'home.dart';
import 'booking.dart';
import 'profile.dart';
import 'wallet.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavStateState();
}

class _BottomnavStateState extends State<Bottomnav> {
  late List<Widget> pages;

  late Home HomePage;
  late Booking booking;
  late Wallet wallet;
  late Profile profile;

  int currentIndex = 0;

  @override
  void initState() {
    HomePage = Home();
    booking = Booking();
    wallet = Wallet();
    profile = Profile();

    pages = [HomePage, booking, wallet, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 70.0,
        backgroundColor: Colors.white,
        color: Colors.black,
        animationDuration: Duration(milliseconds: 200),
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.shopping_cart, size: 30, color: Colors.white),
          Icon(Icons.wallet, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),

        ],
      ),
      body: pages[currentIndex],
    );
  }
}
