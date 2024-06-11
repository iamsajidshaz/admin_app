import 'dart:io';
import 'package:admin_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../providers/app_provider.dart';
import '../services/auth_services.dart';
import '../widgets/account_details_box.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  DatabaseMethods db = DatabaseMethods();
  AuthServices _auth = AuthServices();
  AppProvider appProvider = AppProvider();

  String homestay_limit = "...";
  String hotel_limit = "...";
  String taxi_limit = "...";
  String shop_limit = "...";
  String account_status = ".....";

  showDialogBox() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Cooth The Explorer"),
        content: const Text("Are you sure you want to Logout?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child: const Text("No"),
            ),
          ),
          TextButton(
            onPressed: () async {
              await _auth.signout();
              Navigator.pop(context);
              exit(0);
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child: const Text("Yes"),
            ),
          ),
        ],
      ),
    );
  }

  void getUserLimits() async {
    homestay_limit = await db.getFieldFromDocument(
        "AdminUsers", FirebaseAuth.instance.currentUser!.uid, "homestay_limit");
    hotel_limit = await db.getFieldFromDocument(
        "AdminUsers", FirebaseAuth.instance.currentUser!.uid, "hotel_limit");
    taxi_limit = await db.getFieldFromDocument(
        "AdminUsers", FirebaseAuth.instance.currentUser!.uid, "taxi_limit");
    shop_limit = await db.getFieldFromDocument(
        "AdminUsers", FirebaseAuth.instance.currentUser!.uid, "shop_limit");
    account_status = await db.getFieldFromDocument(
        "AdminUsers", FirebaseAuth.instance.currentUser!.uid, "status");
    //
    if (this.mounted) {
      setState(() {
        // Your state change code goes here
      });
    }
  }

  @override
  void initState() {
    getUserLimits();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = AuthServices();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "MY ACCOUNT",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        leading: const Icon(CupertinoIcons.person_fill),
        actions: [
          IconButton(
            onPressed: showDialogBox,
            icon: Image.asset(
              "assets/images/exit_icon.png",
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // header
            const SizedBox(
              height: 25,
            ),

            //

            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: AccountDetailsBox(
                label: 'Name',
                text: _auth.getName(),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: AccountDetailsBox(
                label: 'Email',
                text: _auth.getEmail(),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: AccountDetailsBox(
                label: 'Email Verified?',
                text: _auth.isEmailVerified(),
              ),
            ),

            //
            const SizedBox(
              height: 25,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(left: 25, top: 10, right: 25),
              padding: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // text
                  const Text(
                    "Account Status",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),

                  // switch
                  Text(
                    account_status,
                    style: TextStyle(
                      color: account_status == "PENDING"
                          ? Colors.red
                          : Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  const Text(
                    "Available Listing limits",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(left: 25, top: 10, right: 25),
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "HOMESTAYS LIMIT:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        homestay_limit,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "HOTELS LIMIT:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        hotel_limit,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "SHOPS LIMIT:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        shop_limit,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "TAXI LIMIT:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        taxi_limit,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () async {
                // delete user
                await AuthServices().deleteUserAccount();
                // show message
                Fluttertoast.showToast(
                    msg: "Your account has been deleted successfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.only(left: 25, top: 10, right: 25),
                padding: const EdgeInsets.all(25),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // text
                    Text(
                      "Delete Account",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // switch
                    Text(
                      ">",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
