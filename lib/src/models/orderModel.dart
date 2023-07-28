import 'dart:convert';

class OrderModel {
  OrderModel({
    this.Email='',
    this.FirstName='',
    this.LastName='',
    this.Adress='',
    this.PhoneNo='',
    this.City='',
    this.Userid='',
    this.Postid='',
    this.posterIdProduct='',
  });
  final String Email;
  final String FirstName;
  final String LastName;
  final String Adress;
  final String PhoneNo;
  final String City;
  final String Userid;
  final String Postid;
  final String posterIdProduct;

  factory OrderModel.fromRawJson(String str) => OrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    Email: json["Email"],
    FirstName: json["FirstName"],
    LastName: json["LastName"],
    Adress: json["Adress"],
    PhoneNo: json["PhoneNo"],
    City: json["City"],
    Userid: json["Userid"],
    Postid: json["Postid"],
    posterIdProduct: json["posterIdProduct"],
  );

  Map<String, dynamic> toJson() => {
    "Email":Email,
    "FirstName":FirstName,
    "LastName":LastName,
    "Adress":Adress,
    "PhoneNo":PhoneNo,
    "City":City,
    "Userid":Userid,
    "Postid":Postid,
    "posterIdProduct":posterIdProduct,
  };
}