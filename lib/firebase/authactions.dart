import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tapnbuy/screens/authaction/login_tnb.dart';
import 'package:tapnbuy/screens/seller/dashboard_screen.dart';

import '../Global/delaytimming.dart';
import '../Global/sharedPrefrences.dart';
import '../Global/snackBar.dart';
import '../screens/buyer/sellerdashboared.dart';
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
      if(signUpModels[0].Email ==email &&signUpModels[0].uid==uid&&signUpModels[0].role==1){
      print("1success");
        delayTiming().pushNewScreen(context, sellerDashboared());
      await sharedPrefrences().storeVal("login", "1");
        GlobalSnackBar("Login Successfully!");
      }else if(signUpModels[0].Email ==email &&signUpModels[0].uid==uid&&signUpModels[0].role==0){
      delayTiming().pushNewScreen(context, dashboard_screen());
      GlobalSnackBar("Login Successfully!");
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
}