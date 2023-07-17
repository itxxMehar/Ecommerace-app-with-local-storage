import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Global/snackBar.dart';
import '../src/models/productregistrationmodel.dart';
import '../src/models/user_model.dart';
class productRepositry extends GetxController {
  static productRepositry get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  var uid ;
  createproduct(ProductRegistration puser,) async {
    final User? user = auth.currentUser;
    uid = user?.uid;
    try {
      var rewf = await _db.collection("ProductRegistration").doc();
      await rewf.set({
        "productname": puser.productname,
        "category": puser.category,
        "serisalnumber": puser.serisalnumber,
        "company": puser.company,
        "price": puser.price,
        "dispription": puser.dispription,
        "imageUral": puser.imageUral,
        "timeStamp": DateTime.now(),
        "uid":uid
      });
      GlobalSnackBar("Successfully Product Added!");
    } catch (error) {
      // Error occurred
      redGlobalSnackBar(
          "Error occurred while Uploading Product: $error");
      print("Error occurred while Uploading Product: $error");
      // Display error message to the user or handle the error as needed
    }
  }

  updated(ProductRegistration puser, products) async {
    try {
      final User? user = auth.currentUser;
      uid = user?.uid;
      await FirebaseFirestore.instance.collection("ProductRegistration").doc(
          products).update({
        "productname": puser.productname,
        "category": puser.category,
        "serisalnumber": puser.serisalnumber,
        "company": puser.company,
        "price": puser.price,
        "dispription": puser.dispription,
        "imageUral": puser.imageUral,
        "timeStamp": DateTime.now(),
        "uid":uid
      });

      GlobalSnackBar("Successfully Product Updated!");
    } catch (error) {
      // Error occurred
      redGlobalSnackBar(
          "Error occurred while Updating Product: $error");
      print("Error occurred while Uploading Product: $error");
    }
    // deleted(ProductRegistration puser,products) async{
    //   await FirebaseFirestore.instance.collection('ProductRegistration').doc(products).delete();
    // }
  }
}