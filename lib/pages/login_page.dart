import 'package:admin_app/providers/app_provider.dart';
import 'package:admin_app/services/auth_services.dart';
import 'package:admin_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _auth = AuthServices();
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_image.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            // text headline
            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                "COORG",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 50,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                "THE EXPLORER",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 50,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                "ADMIN APP",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            // subtitle
            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                "Manage your Homestays, Taxi, Hotels and many more",
                style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Spacer(),

            // bottom container with login button
            Container(
              height: MediaQuery.of(context).size.height * 0.20,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white70,
              ),
              child: appProvider.isGoogleSignInClicked
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // login button
                        GestureDetector(
                          onTap: () async {
                            appProvider.setGoogleSignInClicked(true);
                            // google login
                            await _auth
                                .loginWithGoogle()
                                .then((value) => checkIfNewUser());
                            // add user details to DB if new user

                            appProvider.setGoogleSignInClicked(false);
                            // goto home
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black,
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/icons_google.png",
                                    width: 24,
                                    height: 24,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "Sign In using Google",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w700,
                                      // fontSize: 50,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        // title
                        Text(
                          "Login to Manage your account",
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

checkIfNewUser() async {
  String id = await FirebaseAuth.instance.currentUser!.uid;
//  String isnew = await DatabaseMethods().checkIfNewUser(id).toString();
  print("isnew: " + id);
  String isNew =
      await DatabaseMethods().getFieldFromDocument("AdminUsers", id, "new");
  print("isnew: " + isNew);
  if (isNew == "true") {
    await registerUserDetails(id);
  }
}

registerUserDetails(String id) async {
  Map<String, dynamic> adminUserInfoMap = {
    "ID": id,
    "status": "PENDING",
    "homestay_limit": "3",
    "taxi_limit": "0",
    "shop_limit": "0",
    "hotel_limit": "0",
    "new": "false",
  };
  await DatabaseMethods().addUserToDB(adminUserInfoMap, id);
}
