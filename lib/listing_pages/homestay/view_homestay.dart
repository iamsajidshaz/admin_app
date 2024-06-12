import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeStayView extends StatefulWidget {
  final String fac1;
  final String fac2;
  final String fac3;
  final String fac4;
  final String fac5;
  final String imageOne;
  final String imageTwo;
  final String imageThree;
  final String imageFour;
  final String activityOne;
  final String activityTwo;
  final String activityThree;
  final String name;
  final String location;
  const HomeStayView({
    super.key,
    required this.fac1,
    required this.fac2,
    required this.fac3,
    required this.fac4,
    required this.fac5,
    required this.imageOne,
    required this.imageTwo,
    required this.imageThree,
    required this.imageFour,
    required this.activityOne,
    required this.activityTwo,
    required this.activityThree,
    required this.name,
    required this.location,
  });

  @override
  State<HomeStayView> createState() => _HomeStayViewState();
}

class _HomeStayViewState extends State<HomeStayView> {
  List<String> facList = [];
  List<IconData> facIconList = [];
  List<String> imageList = [];

  @override
  void initState() {
    super.initState();
    facList = initializeFacList();
    facIconList = initializeFacIconList();
    imageList = initializeImageList();
  }

  List<String> initializeImageList() {
    return [
      widget.imageOne,
      widget.imageTwo,
      widget.imageThree,
      widget.imageFour,
    ];
  }

  List<String> initializeFacList() {
    return [
      if (widget.fac1 == "true") 'Wifi',
      if (widget.fac2 == "true") 'AC',
      if (widget.fac3 == "true") 'Hot Water',
      if (widget.fac4 == "true") 'Breakfast',
      if (widget.fac5 == "true") 'Parking',
    ];
  }

  List<IconData> initializeFacIconList() {
    return [
      if (widget.fac1 == "true") Icons.wifi,
      if (widget.fac2 == "true") Icons.ac_unit,
      if (widget.fac3 == "true") Icons.water,
      if (widget.fac4 == "true") Icons.food_bank,
      if (widget.fac5 == "true") Icons.local_parking,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
//image
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 690 / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(widget.imageOne),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              widget.name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // locations
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.place,
                  size: 12,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  widget.location,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    //color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ],
            ),
          ),

          // rating
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "5.0",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    //  color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ],
            ),
          ),
//
          Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Divider(
                color: Colors.grey.shade300,
              ),
            ),
          ),

          // extra, images etc..

          // 1. facilities

          Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
            ),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.tray,
                  color: Colors.black,
                  size: 18,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Facilities",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  //  style: Styles eadLineStyle3
                  //       .copyWith(color: Colors.black87),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          // list of facilities

          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              height: 65,
              // color: Colors.amber,
              child: ListView.builder(
                itemCount: facList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: 360 * 0.25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            facIconList[index],
                            color: Colors.red,
                            size: 20,
                          ),
                          Text(
                            facList[index],
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 20),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.photo,
                  size: 18,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "GALLERY",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  //  style: Styles eadLineStyle3
                  //       .copyWith(color: Colors.black87),
                ),
              ],
            ),
          ),
// list of images

          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              height: 150,
              // color: Colors.amber,
              child: ListView.builder(
                itemCount: imageList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(imageList[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 20),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.sportscourt,
                  size: 18,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "EXTRA ACTIVITIES",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  //  style: Styles eadLineStyle3
                  //       .copyWith(color: Colors.black87),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              padding: EdgeInsets.all(10),
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Icon(Icons.arrow_right),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.activityOne,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              padding: EdgeInsets.all(10),
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Icon(Icons.arrow_right),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.activityTwo,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              padding: EdgeInsets.all(10),
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Icon(Icons.arrow_right),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.activityThree,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  Fluttertoast.showToast(
                      msg: "Customer can book from here",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                },
                child: const Text(
                  "SEND BOOKING INQUIRY",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
