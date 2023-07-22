import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRegistration{
  //for registration
  final String productname;
  final String category;
  final String price;
  final String serisalnumber;
  final String company;
  final String dispription;
  final Timestamp ?timeStamp;
  final List<String> imageUral;
  final String? uid;


  const ProductRegistration({

    //for registration
    required this.productname,
    required this.company,
    required this.category,
    required this.price,
    required this.serisalnumber,
    required this.dispription,
    required this.imageUral,
    this.timeStamp,
    this.uid




  });
  factory ProductRegistration.fromRawJson(String str) => ProductRegistration.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductRegistration.fromJson(Map<String, dynamic> json) => ProductRegistration(
    productname: json["productname"],
    company: json["company"],
    category: json["category"],
    serisalnumber: json["serisalnumber"],
    price: json["price"],
    dispription: json["dispription"],
      timeStamp: json["timeStamp"],
      uid: json["uid"],
      imageUral: json["imageUral"] != null
  ? List<String>.from(json["imageUral"])
      : []
  );

  toJson(){
    return{
      //for registration
      "productname":productname,
      "company":company,
      "category":category,
      "serisalnumber":serisalnumber,
      "price":price,
      "dispription":dispription,
      "timeStamp":timeStamp,
      "uid":uid,
      "imageUral": imageUral != null ? List<String>.from(imageUral!) : []
    };
  }
}