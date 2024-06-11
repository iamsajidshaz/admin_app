import 'package:admin_app/nav_pages/account.dart';
import 'package:admin_app/nav_pages/bookings.dart';
import 'package:admin_app/nav_pages/home.dart';
import 'package:admin_app/providers/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final screens = [
    //home
    const Home(),
    //bookings
    const Bookings(),
    //account
    const Account(),
  ];

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      // bottom nav bar
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.blue.shade100,
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        child: NavigationBar(
          animationDuration: const Duration(seconds: 3),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          backgroundColor: const Color(0xFFf1f5fb),
          selectedIndex: appProvider.index,
          onDestinationSelected: (index) => appProvider.setIndex(index),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'HOME',
              selectedIcon: Icon(Icons.home_filled),
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_border),
              label: 'BOOKINGS',
              selectedIcon: Icon(Icons.favorite),
            ),
            NavigationDestination(
              icon: Icon(CupertinoIcons.person),
              label: 'ACCOUNT',
              selectedIcon: Icon(CupertinoIcons.person_fill),
            ),
          ],
        ),
      ),
      body: screens[appProvider.index],
    );
  }
}
