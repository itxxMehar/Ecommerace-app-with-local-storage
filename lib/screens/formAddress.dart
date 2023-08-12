import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tapnbuy/screens/responsive/text.dart';
import 'package:tapnbuy/src/models/orderModel.dart';

import '../Global/snackBar.dart';
import '../firebase/authactions.dart';
import '../src/models/productregistrationmodel.dart';
import '../src/models/user_model.dart';

class formAdress extends StatefulWidget {
  String ?postID;
  String ?PosterId;
  ProductRegistration ?ProductRegistrations;
   formAdress({super.key,this.postID,this.PosterId,this.ProductRegistrations});

  @override
  State<formAdress> createState() => _formAdressState();
}

class _formAdressState extends State<formAdress> {
  final emailController = TextEditingController();
  final firstController = TextEditingController();
  final phonNoController = TextEditingController();
  final AdressController = TextEditingController();
  final cityController = TextEditingController();
  final lastController = TextEditingController();
  int _value = 1;
  Timer ?_timer;
  var _connectivityResult = ConnectivityResult.none;
  var regexEmail = RegExp(
      "^[a-zA-Z0-9.!#%&'+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:'.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)");
  bool progreess = false;
  @override
  void initState() {
    // TODO: implement initState
    _timer =
        Timer.periodic(Duration(seconds: 2), (Timer t) => checkConnectivity());
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectivityResult = result;
      });
    });
    super.initState();
  }
  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }
  checkConnectivity() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      _connectivityResult = connectivityResult;
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          child:  Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width / 11.0,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.cancel_outlined,
                      size: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.06,
                  child: Text('Place Order',
                      style: TextStyle(
                        fontSize:
                        55 * MediaQuery.textScaleFactorOf(context),
                        fontWeight: FontWeight.w700,
                      ),
                      textScaleFactor:
                      SizeConfig.textScaleFactor(context, 0.7)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Expanded(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          children: [
                            TextField(
                              controller: firstController,
                              decoration: InputDecoration(
                                hintText: 'First Name',
                                hintStyle: TextStyle(color: Colors.grey),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 1, vertical: 6),
                              ),
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                            SizedBox(
                              height:
                              MediaQuery.of(context).size.height * 0.030,
                            ),
                            TextField(
                              controller: lastController,
                              decoration: InputDecoration(
                                hintText: 'Last Name',
                                hintStyle: TextStyle(color: Colors.grey),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 1, vertical: 6),
                              ),
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                            SizedBox(
                              height:
                              MediaQuery.of(context).size.height * 0.030,
                            ),
                            TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.grey),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 1, vertical: 6),
                              ),
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                            SizedBox(
                              height:
                              MediaQuery.of(context).size.height * 0.030,
                            ),
                            TextField(
                              controller: phonNoController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(11),
                              ],
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: 'Phone',
                                hintStyle: TextStyle(color: Colors.grey),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 1, vertical: 6),
                              ),
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                            SizedBox(
                              height:
                              MediaQuery.of(context).size.height * 0.030,
                            ),
                            TextField(
                              controller: cityController,
                              decoration: InputDecoration(
                                hintText: 'City',
                                hintStyle:
                                TextStyle(color: Colors.grey),
                                isDense: true,
                                contentPadding:
                                EdgeInsets.symmetric(
                                    horizontal: 1, vertical: 6),
                              ),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height:
                              MediaQuery.of(context).size.height * 0.03,
                            ),
                            TextField(
                              controller: AdressController,
                              decoration: InputDecoration(
                                hintText: 'Address',
                                hintStyle: TextStyle(color: Colors.grey),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 1, vertical: 6),
                              ),
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.050,
              ),
              progreess==true? loaderDesign(context):
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: InkWell(
                  onTap: () {
                    if (emailController.text == null ||
                        emailController.text == "null" ||
                        emailController.text == "") {
                      print("object");
                      redGlobalSnackBar(
                          "Empty Email Invalid!");
                    }else if (firstController.text == null ||
                        firstController.text == "null" ||
                        firstController.text == "") {
                      setState(() {
                        redGlobalSnackBar(
                            "Empty First Name Invalid!");
                      });
                    } else if (phonNoController.text == null ||
                        phonNoController.text == "null" ||
                        phonNoController.text == "") {
                      setState(() {
                        redGlobalSnackBar(
                            "Empty Phone number Invalid!");
                      });
                    } else if (phonNoController.text.length < 11) {
                      setState(() {
                        redGlobalSnackBar("Phone Number length too short!");
                      });
                    } else if (AdressController.text == null ||
                        AdressController.text == "null" ||
                        AdressController.text == "") {
                      setState(() {
                        redGlobalSnackBar("Empty Address Invalid!");
                      });
                    } else
                      if (lastController.text == null ||
                          lastController.text == "null" ||
                          lastController.text == "") {
                        setState(() {
                          redGlobalSnackBar("Empty Last Name Invalid!");
                        });
                      } else if (cityController.text == null ||
                          cityController.text == "null" ||
                          cityController.text == "") {
                        setState(() {
                          redGlobalSnackBar("Empty Name Invalid!");
                        });
                      }
                      else if (regexEmail
                          .hasMatch(emailController.text)) {
                        print(emailController.text);
                        setState(() {
                          redGlobalSnackBar("Invalid Email Format");
                        });
                      }
                      else {
                      setState(() {
                        progreess=true;
                      });
                      final User = OrderModel(
                        Email: emailController.text.trim(),
                        FirstName: firstController.text.trim(),
                        PhoneNo: phonNoController.text.trim(),
                        Adress: AdressController.text.trim(),
                        LastName: lastController.text.trim(),
                        City:
                        cityController.text.trim(),
                        posterIdProduct: widget.PosterId.toString(),
                        Postid: widget.postID.toString()
                      );
                      if(
                      _connectivityResult==ConnectivityResult.wifi||_connectivityResult==ConnectivityResult.mobile){
                        print("hello");
                      authanication().placeOrder(User, context);
                      Future.delayed(Duration(milliseconds: 700), () {
                        setState(() {
                          progreess=false;
                        });// Close the snack bar after 3 seconds
                      });}else{
                        print("no net");
                        authanication().noNet(User,widget.ProductRegistrations!);
                        Future.delayed(Duration(milliseconds: 700), () {
                          setState(() {
                            progreess=false;
                          });// Close the snack bar after 3 seconds
                        });
                      }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      //borderRadius: BorderRadius.circular(12),
                      //   border: Border.all(color: Colors.blue)
                    ),
                    child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text('Order',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 35 *
                                    MediaQuery.textScaleFactorOf(context),
                              ),
                              textScaleFactor:
                              SizeConfig.textScaleFactor(context, 0.7)),
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.020,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.010,
              ),
            ],
          ),
        ),
      ),
    );
  }
}