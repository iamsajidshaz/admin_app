import 'package:admin_app/listing_pages/homestay/homestay_listing.dart';
import 'package:admin_app/listing_pages/hotels/hotels_listing.dart';
import 'package:admin_app/listing_pages/shops/shops_listing.dart';
import 'package:admin_app/listing_pages/taxi/taxi_listing.dart';
import 'package:admin_app/pages/support_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/manage_listing_box.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Dashboard",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        leading: const Icon(Icons.dashboard_outlined),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const SupportPage(),
                ),
              );
            },
            icon: Image.asset("assets/images/icon_support.png"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                "Manage",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 60,
                ),
              ),
              Text(
                "Your Listings",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 60,
                ),
              ),
              //
              SizedBox(
                height: 25,
              ),
              // listing managing boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      //
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomestayListing(),
                        ),
                      );
                    },
                    child: ManageListingBox(
                      name: "HomeStay",
                      colorone: Colors.blue,
                      colortwo: Colors.cyan,
                      colorthree: Colors.tealAccent,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaxisListing(),
                        ),
                      );
                    },
                    child: ManageListingBox(
                      name: "Taxi",
                      colorone: Colors.blue,
                      colortwo: Colors.cyan,
                      colorthree: Colors.lightGreenAccent,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      //
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HotelsListing(),
                        ),
                      );
                    },
                    child: ManageListingBox(
                      name: "Hotel",
                      colorone: Colors.blue,
                      colortwo: Colors.cyan,
                      colorthree: Colors.indigoAccent,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShopsListing(),
                        ),
                      );
                    },
                    child: ManageListingBox(
                      name: "Shop",
                      colorone: Colors.blue,
                      colortwo: Colors.cyan,
                      colorthree: Colors.cyanAccent,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
