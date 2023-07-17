import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:tapnbuy/screens/authaction/login_tnb.dart';

class authaction{
  forgot(email) async {
    final _auth = FirebaseAuth.instance;

// Send a password reset email to the user's email address
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('An error occurred while sending the password reset email: $e');
    }
  }
  signOut(context) async {
    final _auth = FirebaseAuth.instance;
// Sign out the current user
    try {
      await _auth.signOut().whenComplete(() =>
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => login_tnb()),
                (route) => false,
          ),

        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => login(), (route) => false);
        // Navigator.of(context).popUntil((route) => route.isFirst ||  MaterialPageRoute(builder: (context) => botoomNavigarion());

      );
    } catch (e) {
      print('An error occurred while signing out: $e');
    }
  }
  Future<String> uploadImage(File? front)async{
    final filename = basename(front!.path);
    final destination ="user photo/$filename";
    final file=File(front.path);
    final refs = FirebaseStorage.instance.ref().child(destination);
    UploadTask uploadTask = refs.putFile(file);
    print("success");
    return await (await uploadTask).ref.getDownloadURL();
  }
}