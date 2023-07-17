import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tapnbuy/firebase/authactions.dart';

import '../../Global/snackBar.dart';
import '../responsive/text.dart';
class forget_password_tnb extends StatefulWidget {
  const forget_password_tnb({Key? key}) : super(key: key);
  @override
  State<forget_password_tnb> createState() => _forget_password_tnbState();
}
class _forget_password_tnbState extends State<forget_password_tnb> {
  final emailController=TextEditingController();
  bool loader=false;
  var regexEmail = RegExp(
      "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:'.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.cancel_outlined,
                      size: 23 * MediaQuery.textScaleFactorOf(context),),
                  ),
                ),
              ),
              SizedBox(height:MediaQuery.of(context).size.height*0.02,),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text('Forgot Password',
                    style: TextStyle(
                      fontSize:55 * MediaQuery.textScaleFactorOf(context),
                      fontWeight: FontWeight.w700,
                    ),
                      textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                ),
              ),
              SizedBox(height:MediaQuery.of(context).size.height*0.02,),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 25,right: 16),
                  child: Text('Please enter your email address.You will resive'
                      ' a link to create a new pasword via email.',
                    style: TextStyle(
                      fontSize:32 * MediaQuery.textScaleFactorOf(context),
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                      textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                ),
              ),
              SizedBox(height:MediaQuery.of(context).size.height*0.06,),
              Container(
                width: MediaQuery.of(context).size.width*0.9,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.grey),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 1, vertical: 6),),
                  style: TextStyle(
                      fontSize:18 * MediaQuery.textScaleFactorOf(context),
                      color: Colors.black
                  ),
                ),
              ),
              SizedBox(height:MediaQuery.of(context).size.height*0.07,),
              loader==true? loaderDesign(context):
              InkWell(
                onTap: (){
                  if (emailController.text == null ||
                      emailController.text == "null" ||
                      emailController.text == "") {
                    redGlobalSnackBar(
                        "Empty Email Invalid!");
                  }else if (!regexEmail
                      .hasMatch(emailController.text)) {
                    setState(() {
                      redGlobalSnackBar("Invalid Email Format");
                    });
                  }
                  else{
                    setState(() {
                      loader=true;
                    });
                    authanication().resetPassword(emailController.text);
                    Future.delayed(Duration(milliseconds: 400), () {
                      setState(() {
                        loader=false;
                      });// Close the snack bar after 3 seconds
                    });
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  padding: EdgeInsets.only(left: 15,right: 15),
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Text(
                            'SEND',
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
            ],
          ),
        ),
      ),
    );
  }
}
