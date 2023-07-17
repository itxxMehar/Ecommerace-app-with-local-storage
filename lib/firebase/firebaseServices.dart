import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Global/snackBar.dart';

class firebaseServices  {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // getProfile(text) async {
  //   signUpModels.clear();
  //   RxList<signUpModel> signUpModelss = <signUpModel>[].obs;
  //   String input = (text.toLowerCase()).replaceAll(' ', '');
  //   var querySnapshot = await firestore.collection('Users').get();
  //   for (int i = 0; i < querySnapshot.docs.length; i++) {
  //     signUpModelss.add(signUpModel.fromJson(querySnapshot.docs[i].data()));
  //   }
  //   signUpModels.clear();
  //   for (int i = 0; i < signUpModelss.length; i++) {
  //     String firstName =
  //     (signUpModelss[i].firstName.toLowerCase()).replaceAll(' ', '');
  //     if (firstName.startsWith(input)) {
  //       signUpModels.add(signUpModelss[i]);
  //       print(signUpModelss[i].firstName);
  //     }
  //   }
  //   return signUpModels;
  // }

  void findUserUID(String email,context) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Users') // Replace with your collection name
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      print(querySnapshot.docs[0].id);
      postFav(querySnapshot.docs[0].id,context);
      // return querySnapshot.docs[0].id; // Return the UID of the first matching user
    } else {
      return null; // User not found
    }
  }

  postFav(opponentUIDs,context) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    String uid = user!.uid;
    var postsCollection =
    FirebaseFirestore.instance.collection('favUser').doc(uid);
    final documentReference =
    await FirebaseFirestore.instance.collection('favUser').doc(uid).get();
    if (documentReference.exists) {
      List<dynamic> opponentsList = documentReference.get('opponents');
      if (opponentsList.contains(opponentUIDs)) {
        opponentsList.remove(opponentUIDs);
        await postsCollection.update({
          'uid': uid,
          'opponents': opponentsList,
        });
        GlobalSnackBar("Successfully removed from favourite");
      } else {
        // Add the new opponent UID to the list
        opponentsList.add(opponentUIDs);
        await postsCollection.update({
          'uid': uid,
          'opponents': opponentsList,
        });
        GlobalSnackBar("Successfully added to favourite");
      }
    } else {
      await postsCollection.set({
        'uid': uid,
        'opponents': [opponentUIDs],
      });
      GlobalSnackBar("Successfully added to favourite");
      print('Document created successfully');
    }
  }

  // getFav() async {
  //   signUpModels.clear();
  //   List<signUpModel> signUpModelss = [];
  //   final FirebaseAuth _auth = FirebaseAuth.instance;
  //   User? user = _auth.currentUser;
  //   String uid = user!.uid;
  //   final documentReference =
  //   await FirebaseFirestore.instance.collection('favUser').doc(uid).get();
  //   var querySnapshot = await firestore.collection('Users').get();
  //   for (int i = 0; i < querySnapshot.docs.length; i++) {
  //     signUpModelss.add(signUpModel.fromJson(querySnapshot.docs[i].data()));
  //   }
  //   if (documentReference.exists) {
  //     // Document exists, access its data
  //     Map<String, dynamic>? data = documentReference.data();
  //     var uid = data?['opponents'];
  //     signUpModels.clear();
  //     for (int i = 0; i < uid.length; i++) {
  //       for (int j = 0; j < signUpModelss.length; j++) {
  //         if (signUpModelss[j].uid == uid[i]) {
  //           signUpModels.add(signUpModelss[j]);
  //         }
  //       }
  //       print('UID:' + uid[i]);
  //     }
  //     return signUpModels;
  //   } else {
  //     // Document doesn't exist, handle accordingly
  //     print('Document does not exist.');
  //   }
  // }
}