import 'package:admin_app/listing_pages/homestay/add_new_homestay.dart';
import 'package:admin_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'edit_homestay.dart';
import 'view_homestay.dart';

class HomestayListing extends StatefulWidget {
  const HomestayListing({super.key});

  @override
  State<HomestayListing> createState() => _HomestayListingState();
}

class _HomestayListingState extends State<HomestayListing> {
  @override
  Widget build(BuildContext context) {
    DatabaseMethods databaseMethods = DatabaseMethods();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "My Homestay Listings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              autofocus: true,
              onPressed: () async {
                int n = await databaseMethods.countFilteredDocuments(
                    FirebaseAuth.instance.currentUser!.uid);
                String lmt = await databaseMethods.getFieldFromDocument(
                  "AdminUsers",
                  FirebaseAuth.instance.currentUser!.uid,
                  "homestay_limit",
                );
                // print("total homestays for this user" + n.toString());
                //   print("total homestays for this user" + lmt.toString());

                if (n.toString() == lmt) {
                  Fluttertoast.showToast(
                      msg: "Homestay Listing Limit exceeded",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddNewHomestay(listNumber: n.toString()),
                    ),
                  );
                }

                //
              },
              icon: FaIcon(
                FontAwesomeIcons.squarePlus,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     int n = await databaseMethods
      //         .countFilteredDocuments(FirebaseAuth.instance.currentUser!.uid);
      //     String lmt = await databaseMethods.getFieldFromDocument(
      //       "AdminUsers",
      //       FirebaseAuth.instance.currentUser!.uid,
      //       "homestay_limit",
      //     );
      //     // print("total homestays for this user" + n.toString());
      //     //   print("total homestays for this user" + lmt.toString());

      //     if (n.toString() == lmt) {
      //       Fluttertoast.showToast(
      //           msg: "Homestay Listing Limit exceeded",
      //           toastLength: Toast.LENGTH_SHORT,
      //           gravity: ToastGravity.CENTER,
      //           timeInSecForIosWeb: 1,
      //           backgroundColor: Colors.red,
      //           textColor: Colors.white,
      //           fontSize: 16.0);
      //     } else {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => AddNewHomestay(listNumber: n.toString()),
      //         ),
      //       );
      //     }

      //     //
      //   },
      //   backgroundColor: Colors.green,
      //   child: Icon(
      //     CupertinoIcons.add,
      //     color: Colors.white,
      //   ),
      // ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Homestays')
            .where("ID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var documents = snapshot.data!.docs;

          return documents.length == 0
              ? Center(
                  child: Text("NO HOMESTAY FOUND, CLICK ON + TO ADD"),
                )
              : ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    var document = documents[index];

                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 25.0,
                        right: 25,
                        left: 25,
                        bottom: 25,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 180,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              color: Colors.blue,
                              image: DecorationImage(
                                image: NetworkImage(
                                  document['image_one'],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.home,
                                        size: 12,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        document['Name'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
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
                                        document['Location'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditHomestay(
                                                listNumber: document["sn"],
                                                name: document["Name"],
                                                location: document["Location"],
                                                maplink: document["maplink"],
                                                imageOneUrl:
                                                    document["image_one"],
                                                imageTwoUrl:
                                                    document["image_two"],
                                                imageThreeUrl:
                                                    document["image_three"],
                                                imageFourUrl:
                                                    document["image_four"],
                                                isWifi: document["fac1"],
                                                isAc: document["fac2"],
                                                isHeater: document["fac3"],
                                                isFood: document["fac4"],
                                                isParking: document["fac5"],
                                                activityOne:
                                                    document["activityOne"],
                                                activityTwo:
                                                    document["activityTwo"],
                                                activityThree:
                                                    document["activityThree"],
                                              ),
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.black,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeStayView(
                                                // listNumber: document["sn"],
                                                // name: document["Name"],
                                                // location: document["Location"],
                                                // maplink: document["maplink"],
                                                imageOne: document["image_one"],
                                                imageTwo: document["image_two"],
                                                imageThree:
                                                    document["image_three"],
                                                // imageFourUrl:
                                                //     document["image_four"],
                                                fac1: document["fac1"],
                                                fac2: document["fac2"],
                                                fac3: document["fac3"],
                                                fac4: document["fac4"],
                                                fac5: document["fac5"],
                                                // activityOne:
                                                //     document["activityOne"],
                                                // activityTwo:
                                                //     document["activityTwo"],
                                                // activityThree:
                                                //     document["activityThree"],
                                              ),
                                            ),
                                          );
                                        },
                                        icon: FaIcon(FontAwesomeIcons.eye),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title:
                                                      Text('DELETE HOMESTAY'),
                                                  content: Text(
                                                      'Are you sure you want to delete?'),
                                                  actions: <Widget>[
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .pop();

                                                        await databaseMethods
                                                            .deleteHomeStay(
                                                          document['sn'] +
                                                              "_" +
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid,
                                                        );
                                                      },
                                                      child: Text('YES'),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text(
                                                        'CLOSE',
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );

                    // return ListTile(
                    //   title: Text(document['Name']),
                    //   subtitle: Text(document['Location']),
                    //   // Add more fields here if necessary
                    // );
                  },
                );
        },
      ),
    );
  }
}
