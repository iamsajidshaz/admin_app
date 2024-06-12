import 'package:flutter/material.dart';

class HotelsListing extends StatelessWidget {
  const HotelsListing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "My Hotels Listings",
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
