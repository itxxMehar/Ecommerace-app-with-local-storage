import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class localStores{
  //for registration
  final String productname;
  final String category;
  final String price;
  final String serisalnumber;
  final String company;
  final String dispription;
  final List<String> imageUral;
  final String? uid;


  const localStores({

    //for registration
    required this.productname,
    required this.company,
    required this.category,
    required this.price,
    required this.serisalnumber,
    required this.dispription,
    required this.imageUral,
    this.uid




  });
  factory localStores.fromRawJson(String str) => localStores.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory localStores.fromJson(Map<String, dynamic> json) => localStores(
    productname: json["productname"],
    company: json["company"],
    category: json["category"],
    serisalnumber: json["serisalnumber"],
    price: json["price"],
    dispription: json["dispription"],
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
      "uid":uid,
      "imageUral": imageUral != null ? List<String>.from(imageUral!) : []
    };
  }
}