import 'dart:convert';

class signUpModel {
  signUpModel({
    this.Email='',
    this.Password='',
    this.Adress='',
    this.Photo='',
    this.PhoneNo='',
    this.Company='',
    this.CompenyNumber='',
    this.uid='',
    this.role,
  });
  final String Email;
  final String Password;
  final String PhoneNo;
  final String Photo;
  final String Adress;
  final String Company;
  final String CompenyNumber;
  final String uid;
  int ?role;

  factory signUpModel.fromRawJson(String str) => signUpModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory signUpModel.fromJson(Map<String, dynamic> json) => signUpModel(
    Email: json["Email"],
    Password: json["Password"],
    PhoneNo: json["PhoneNo"],
    Photo: json["Photo"],
    Adress: json["Adress"],
    Company: json["Company"],
    CompenyNumber: json["CompenyNumber"],
    uid: json["uid"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "Email":Email,
    "Password":Password,
    "PhoneNo":PhoneNo,
    "Photo":Photo,
    "Adress":Adress,
    "CompenyNumber":CompenyNumber,
    "Company":Company,
    "uid":uid,
    "role":role,
  };
}