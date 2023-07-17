import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tapnbuy/firebase/authactions.dart';
import 'package:tapnbuy/screens/authaction/signUp.dart';
import '../../Global/delaytimming.dart';
import '../../Global/snackBar.dart';
import '../buyer/main_dashboard.dart';
import '../responsive/text.dart';
import '../buyer/sellerdashboared.dart';
import 'forget_password_tnb.dart';
class login_tnb extends StatefulWidget {
  final VoidCallback ?showpersonaldetails;
   const login_tnb({Key? key, this.showpersonaldetails,}) : super(key: key);
  @override
  State<login_tnb> createState() => _login_tnbState();
}
class _login_tnbState extends State<login_tnb> {
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  int IdController=1;
  bool loading=false;
  int _value=1;
  var regexEmail = RegExp(
      "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:'.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*");
  @override

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
       final value=await showDialog<bool>(context: context, builder: (context){
         return AlertDialog(
           title: const Text('Alert'),
           content: const Text('Do you want to Exit'),
           actions: [
             ElevatedButton(onPressed: ()=>Navigator.of(context).pop(false), child: const Text('No')
             ),
             ElevatedButton(onPressed: ()=>SystemNavigator.pop(), child: const Text('Exit')
             ),
           ],
         );
       });
       if(value!=null){
         return Future.value(value);
       }else
         {
           return Future.value(false);
         }
  },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 11.0,
                    child: InkWell(
                      onTap: () {
                        SystemNavigator.pop();
                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(height:MediaQuery.of(context).size.height*0.02,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text('Login',
                    style: TextStyle(
                      fontSize: 55* MediaQuery.textScaleFactorOf(context),
                      fontWeight: FontWeight.w700,
                    ),
                        textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                  ),
                ),
                SizedBox(height:MediaQuery.of(context).size.height*0.020,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Radio(value: 1, groupValue: _value, onChanged: (value){
                          setState(() {
                            _value=value!;
                            IdController=_value;
                          });
                        },
                        ),
                        Text('Seller',
                            style: TextStyle(
                              fontSize: 35* MediaQuery.textScaleFactorOf(context),
                              fontWeight: FontWeight.w700,
                            ),
                            textScaleFactor: SizeConfig.textScaleFactor(context,0.7)
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(value: 0, groupValue: _value, onChanged: (value){
                          setState(() {
                            _value=value!;
                            IdController=_value;
                          });
                        },
                        ),
                        Text('Customer',
                            style: TextStyle(
                              fontSize: 35* MediaQuery.textScaleFactorOf(context),
                              fontWeight: FontWeight.w700,
                            ),
                            textScaleFactor: SizeConfig.textScaleFactor(context,0.7)
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height:MediaQuery.of(context).size.height*0.020,),
                Expanded(child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                     Column(children: [
                       SizedBox(height:MediaQuery.of(context).size.height*0.02,),
                       Container(
                         child: TextField(
                           controller: emailController,
                           keyboardType: TextInputType.emailAddress,
                           decoration: InputDecoration(
                             hintText: 'Email',
                             hintStyle: TextStyle(color: Colors.grey),
                             isDense: true,
                             contentPadding: EdgeInsets.symmetric(horizontal: 1, vertical: 6),),

                           style: TextStyle(
                               fontSize: 18,
                               color: Colors.black
                           ),
                         ),
                       ),
                       SizedBox(height:MediaQuery.of(context).size.height*0.02,),
                       Container(
                         child: TextField(
                           obscureText: true,
                           controller: passwordController,
                           decoration: InputDecoration(
                             suffixIcon: Icon(Icons.remove_red_eye),
                             hintText: 'Password',
                             hintStyle: TextStyle(color: Colors.grey),
                             isDense: true,
                             contentPadding: EdgeInsets.symmetric(horizontal:1, vertical: 6),),
                           style: TextStyle(
                               fontSize: 18,
                               color: Colors.black
                           ),
                         ),
                       ),
                       SizedBox(height:MediaQuery.of(context).size.height*0.08,),
                     ],),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          loading==true?
                          loaderDesign(context):
                          InkWell(
                            onTap:() async {
                              if (emailController.text == null ||
                                  emailController.text == "null" ||
                                  emailController.text == "") {
                                print("object");
                                redGlobalSnackBar(
                                    "Empty Email Invalid!");
                              } else if (!regexEmail
                                  .hasMatch(emailController.text)) {
                                setState(() {
                                  redGlobalSnackBar("Invalid Email Format");
                                });
                              }  else if (passwordController.text == null ||
                                  passwordController.text == "null" ||
                                  passwordController.text == "") {
                                setState(() {
                                  redGlobalSnackBar(
                                      "Empty Password Invalid!");
                                });
                              }else{
                                setState(() {
                                  loading=true;
                                });
                            await authanication().logins(emailController.text,passwordController.text,context,IdController);
                                Future.delayed(Duration(milliseconds: 800), () {
                                  setState(() {
                                    loading=false;
                                  });// loading the snack bar after 3 seconds
                                });
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 15,right: 15),
                              decoration: BoxDecoration(
                                color: Colors.black,
                              ),
                              child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Text(
                                        'LOGIN',
                                        style:
                                        TextStyle(color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 35* MediaQuery.textScaleFactorOf(context),
                                        ),
                                        textScaleFactor: SizeConfig.textScaleFactor(context,0.7)
                                    ),
                                  )),
                            ),
                          ),
                          SizedBox(height:MediaQuery.of(context).size.height*0.02,),
                          Center(
                            child: InkWell(
                              onTap: () {
                                delayTiming().pushNewScreen(
                                    context, forget_password_tnb());
                              },
                              child: Text('Forgot your password?',
                                  style: TextStyle(
                                    fontSize: 38* MediaQuery.textScaleFactorOf(context),
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textScaleFactor: SizeConfig.textScaleFactor(context,0.7)
                              ),
                            ),
                          ),
                        ],
                      )
                    ],),
                  ),
                )),
                SizedBox(height:MediaQuery.of(context).size.height*0.02,),
                Align(
                  alignment: Alignment.center,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\' have an account?',
                            style: TextStyle(
                              fontSize: 32* MediaQuery.textScaleFactorOf(context),
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                            textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => signUp()),
                            );
                          },
                          child: Text(' Sign Up',
                              style: TextStyle(
                                fontSize: 37* MediaQuery.textScaleFactorOf(context),
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                              textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height:MediaQuery.of(context).size.height*0.01,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
