import 'package:flutter/material.dart';

class ShopsListing extends StatelessWidget {
  const ShopsListing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "My Shops Listings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 24,
          ),
        ),
      ),
      body: Center(
        child: Text("FEATURE COMING SOON"),
      ),
    );
  }
}
