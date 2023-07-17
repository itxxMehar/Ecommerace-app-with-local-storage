// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../src/models/user_model.dart';
// class UserRepositry extends GetxController{
//   static UserRepositry get instance => Get.find();
//   final _db=FirebaseFirestore.instance;
//
//   creatUser(UserModel user) async{
//     var rewf=await _db.collection("Users").doc();
//     user.Id==0?
//     rewf.set({
//       "name":user.Email,
//       "Password":user.Password,
//       "PhoneNo":user.PhoneNo,
//       "DateOfBirth":user.DateOfBirth,
//       "Adress":user.Adress,
//       "Id":user.Id,
//     }):
//     rewf.set({
//       "name":user.Email,
//       "Password":user.Password,
//       "PhoneNo":user.PhoneNo,
//       "DateOfBirth":user.DateOfBirth,
//       "Adress":user.Adress,
//       "Company":user.Company,
//       "Compenynumber":user.CompenyNumber,
//       "Id":user.Id,
//     });
//   }
// }