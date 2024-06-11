import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload user details to db
  Future addUserToDB(Map<String, dynamic> adminUserInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("AdminUsers")
        .doc(id)
        .set(adminUserInfoMap);
  }

  //upload homestay to db
  Future addNewHomeStay(Map<String, dynamic> homestayInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Homestays")
        .doc(id)
        .set(homestayInfoMap);
  }

  // count total lists

  Future<int> countDocuments() async {
    // Replace 'your_collection' with the name of your collection
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('Homestays');
    QuerySnapshot querySnapshot = await collectionRef.get();

    return querySnapshot.size;
  }

  // check if new user
  Future<String> getFieldFromDocument(
      String collection, String documentId, String field) async {
    try {
      // Get the document snapshot
      DocumentSnapshot snapshot =
          await _firestore.collection(collection).doc(documentId).get();

      // Check if the document exists
      if (snapshot.exists) {
        // Get the value of the specified field
        return snapshot[field];
      } else {
        // Document does not exist
        return "true";
      }
    } catch (error) {
      print(error);
      return "error:" + error.toString();
    }
  }

  Future<void> deleteHomeStay(String docID) async {
    await _firestore.collection("Homestays").doc(docID).delete();
  }
}
