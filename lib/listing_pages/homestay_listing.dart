import 'package:admin_app/listing_pages/add_new_homestay.dart';
import 'package:admin_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomestayListing extends StatelessWidget {
  const HomestayListing({super.key});

  @override
  Widget build(BuildContext context) {
    DatabaseMethods databaseMethods = DatabaseMethods();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            const Text(
              "My Homestay Listings",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 24,
              ),
            ),
            const Text(
              "( Click on HomeStay to view )",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          int n = await databaseMethods.countDocuments();

          //
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewHomestay(listNumber: n.toString()),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: Icon(
          CupertinoIcons.add,
          color: Colors.white,
        ),
      ),
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

          print("length is: " + documents.length.toString());

          return documents.length == 0
              ? Center(
                  child: Text("NO HOMESTAY FOUND, CLICK ON + TO ADD"),
                )
              : ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    var document = documents[index];

                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 25.0, right: 25, left: 25),
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
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.edit,
                                        ),
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
