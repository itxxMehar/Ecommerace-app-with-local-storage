import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapnbuy/screens/authaction/login_tnb.dart';
import 'package:tapnbuy/screens/seller/dashboard_screen.dart';

import '../Global/delaytimming.dart';
import '../Global/sharedPrefrences.dart';
import '../Global/snackBar.dart';
import '../screens/buyer/main_dashboard.dart';
import '../screens/buyer/sellerdashboared.dart';
import '../src/models/orderModel.dart';
import '../src/models/user_model.dart';

class authanication{
  FirebaseAuth auth = FirebaseAuth.instance;
  var uid ;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future signUp(signUpModel sign,context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: sign.Email,
        password: sign.Password,
      );
      User? users = userCredential.user;
      if (users != null) {
        // Send the verification email
        await users.sendEmailVerification();
        GlobalSnackBar("Verification Email Sent Please Verified!");
      }
      final User? user = auth.currentUser;
      uid = user?.uid;
      uploadUserDatajobSeeker(sign,context);
    } catch (e) {
      redGlobalSnackBar(e.toString());
    }
  }
  Future uploadUserDatajobSeeker(signUpModel sign,context) async{
    final User? user = auth.currentUser;
    uid = user?.uid;
    DocumentReference ref =  FirebaseFirestore.instance.collection('Users').doc(uid);
    ref.set
      ({
      'Email':sign.Email,
      'Password':sign.Password,
      "PhoneNo":sign.PhoneNo,
      "Photo":sign.Photo,
      "Adress":sign.Adress,
      "CompenyNumber":sign.CompenyNumber,
      "Company":sign.Company,
      "uid":uid,
      "role":sign.role,
    }).then((value) {
      GlobalSnackBar("User Register Successfully!");
      delayTiming()
          .pushNewScreen(context, login_tnb());
    }
    )
        .catchError((error) =>  redGlobalSnackBar(error.toString()));
  }
  Future placeOrder(OrderModel sign,context) async{
    final User? user = auth.currentUser;
    uid = user?.uid;
    DocumentReference ref =  FirebaseFirestore.instance.collection('Orders').doc();
    ref.set
      ({
      "Email":sign.Email,
      "FirstName":sign.FirstName,
      "LastName":sign.LastName,
      "Adress":sign.Adress,
      "PhoneNo":sign.PhoneNo,
      "City":sign.City,
      "Userid":uid,
      "Postid":sign.Postid,
      "posterIdProduct":sign.posterIdProduct,
    }).then((value) {
      GlobalSnackBar("Order Successfully!");
      delayTiming()
          .backPressed(context);
    }
    )
        .catchError((error) =>  redGlobalSnackBar(error.toString()));
  }
  noNet(newData) async {
    List <OrderModel> OrderModels= [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = prefs.getString('orderLocxal') ?? '';
    if(jsonData!=""){
      List<dynamic> decodedData = jsonDecode(jsonData);
      OrderModels = decodedData
          .map((item) => OrderModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    }
    OrderModels.add(newData);
    for(int i=0;i<OrderModels.length;i++) {
    print(OrderModels[i].LastName);
    }
    print(OrderModels.length);
    List<Map<String, dynamic>> dataListJson =
    OrderModels.map((order) => order.toJson()).toList();
    String jsonDatas = jsonEncode(dataListJson);
    prefs.setString('orderLocxal', jsonDatas);
  }
  google(context,password) async {
    final User? user = auth.currentUser;
    uid = user?.uid;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    var email = googleUser?.email;
    String displayName = (googleUser?.displayName).toString();
    List<String> nameParts = displayName.split(" ");
    String firstName = nameParts[0];
    String lastName = nameParts.length > 1 ? nameParts[1] : "";
    signUpModel sign=signUpModel(
        Email: email.toString(),Password: password.toString());
    signUp(sign,context);
  }
  logins(email,password,context,usertype) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        // if (user.emailVerified) {
          fetchuser(email,password,context,usertype);
          print("1success");
        // } else {
        //   redGlobalSnackBar("Please Verified Email First!");
        // }
      }
    } catch (e) {
      // Handle sign-in errors
      redGlobalSnackBar('Sign in failed: $e');
      print('Sign in failed: $e');
    }
  }
  List <signUpModel> signUpModels= [];
  fetchuser(email,password,context,usertype)async{
    final User? user = auth.currentUser;
    uid = user?.uid;
    QuerySnapshot querySnapshot=await FirebaseFirestore.instance.collection("Users")
        .where("uid",isEqualTo: uid).get();
      print("_Users.length");
      for (int i=0;i<querySnapshot.docs.length;i++){
        signUpModels.add(signUpModel.fromJson(querySnapshot.docs[i].data() as Map<String, dynamic> ));
      }
      if(signUpModels[0].Email ==email &&signUpModels[0].uid==uid&&signUpModels[0].role==1&&usertype==1){
      print("1success");
        delayTiming().pushNewScreen(context, sellerDashboared());
      await sharedPrefrences().storeVal("login", "1");
        GlobalSnackBar("Login Successfully!");
      }else if(signUpModels[0].Email ==email &&signUpModels[0].uid==uid&&signUpModels[0].role==0&&usertype==0){
      delayTiming().pushNewScreen(context, main_dashboard());
      await sharedPrefrences().storeVal("login", "0");
      GlobalSnackBar("Login Successfully Seller!");
    } else if(signUpModels[0].Password.trim==password.trim ){
      GlobalSnackBar("Passord Incorrect!");
    }else{
        redGlobalSnackBar('Error User Not Found!');
      }
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle(context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final User? userss = auth.currentUser;
        uid = userss?.uid;
        List<String> signInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(googleUser.email);

        if (signInMethods.isNotEmpty==true) {
          List<signUpModel> signUpModels=[];
          QuerySnapshot<dynamic> data =await FirebaseFirestore.instance.collection('Users').where("uid",isEqualTo: uid).get();
          for(int i=0;i<data.docs.length;i++){
            signUpModels.add(signUpModel.fromJson(data.docs[i].data()));}
          // logins(signUpModels[0].Email,signUpModels[0].Password,context);
        }else{
          redGlobalSnackBar("Account not Exist");
        }
      }
    } catch (e) {
      // Handle sign-in errors
      print('Google sign-in failed: $e');
    }
  }
  void resetPassword(emails) async {
    String email = emails.trim();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      GlobalSnackBar("Change Password Email Sent!");
    } catch (e) {
      // Handle errors\
      redGlobalSnackBar("Email Provided Not Register!");
      print('Error sending password reset email: $e');
      // Show an error message to the user
    }
  }
  void whishList(data) async {
    final User? user = auth.currentUser;
    uid = user?.uid;
    try {
      // Check if the document exists.
      DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection('whistList').doc(uid).get();

      if (snapshot.exists) {
        // Document already exists, update the entries.
        await FirebaseFirestore.instance.collection('whistList').doc(uid).set(
          {
            'uid': uid,
            'whish':FieldValue.arrayUnion([data]),
          },
          SetOptions(merge: true), // Merge with existing data.
        );
        GlobalSnackBar('Added to Wish List successfully!');
      } else {
        // Document doesn't exist, create a new document with the specified data.
        await FirebaseFirestore.instance.collection('whistList').doc(uid).set(
          {
            'uid': uid,
          'whish':FieldValue.arrayUnion([data]),
          },
        );
        GlobalSnackBar('Added to Wish List successfully!');
      }
    } catch (e) {
      redGlobalSnackBar('Error Added to Wish List: $e');
      print('Error creating/updating document: $e');
    }
  }
  void removeFromWhishlist(data) async {
    print(data);
    print("doc");
    final User? user = auth.currentUser;
    uid = user?.uid;
    try {
      // Get the current wishlist document using its ID.
      DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection('whistList').doc(uid).get();

      if (snapshot.exists) {
        // Document exists, remove the item from the 'items' array using FieldValue.arrayRemove.
        await FirebaseFirestore.instance.collection('whistList').doc(uid).update({
          'whish': FieldValue.arrayRemove([data]),
        });

        print('Item removed from Firestore successfully!');
      }
    }catch (e) {
      print('Error removing item from wishlist: $e');
    }
  }

}