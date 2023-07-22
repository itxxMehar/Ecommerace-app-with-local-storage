import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Global/delaytimming.dart';
import '../../Global/snackBar.dart';
import '../../firebase/authactions.dart';
import '../../src/models/user_model.dart';
import '../responsive/text.dart';
import 'login_tnb.dart';

class signUp extends StatefulWidget {
  const signUp({super.key});

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phonNoController = TextEditingController();
  final AdressController = TextEditingController();
  final CompanyController = TextEditingController();
  final CompanyNumberController = TextEditingController();
  int IdController=1;
  int _value = 1;
  var regexEmail = RegExp(
      "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:'.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*");
  bool progreess = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
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
                        child: Text('Personal details',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: _value,
                              onChanged: (value) {
                                setState(() {
                                  _value = value!;
                                  print(_value);
                                  IdController = _value;
                                   emailController.text="";
                                   passwordController.text="";
                                   phonNoController.text="";
                                   AdressController .text="";
                                   CompanyController.text="";
                                   CompanyNumberController.text="";
                                   print(IdController);
                                });
                              },
                            ),
                            Text('Seller',
                                style: TextStyle(
                                  fontSize: 35 *
                                      MediaQuery.textScaleFactorOf(context),
                                  fontWeight: FontWeight.w700,
                                ),
                                textScaleFactor:
                                    SizeConfig.textScaleFactor(context, 0.7)),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 0,
                              groupValue: _value,
                              onChanged: (value) {
                                setState(() {
                                  _value = value!;
                                  print(_value);
                                  // _value: IdController;
                                  // _value== IdController.text;
                                  IdController = _value;
                                  emailController.text="";
                                  passwordController.text="";
                                  phonNoController.text="";
                                  AdressController .text="";
                                  CompanyController.text="";
                                  CompanyNumberController.text="";
                                });
                              },
                            ),
                            Text('Customer',
                                style: TextStyle(
                                  fontSize: 35 *
                                      MediaQuery.textScaleFactorOf(context),
                                  fontWeight: FontWeight.w700,
                                ),
                                textScaleFactor:
                                    SizeConfig.textScaleFactor(context, 0.7)),
                          ],
                        ),
                      ],
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
                                controller: passwordController,
                                decoration: InputDecoration(
                                  hintText: 'Password',
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
                              _value == 1
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                        ),
                                        TextField(
                                          controller: CompanyController,
                                          decoration: InputDecoration(
                                            hintText: 'Company Name',
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                        ),
                                        TextField(
                                          controller: CompanyNumberController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: ''
                                                'Company Number',
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
                                      ],
                                    )
                                  : SizedBox(),
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
                          } else if(IdController==1){
                           if (CompanyController.text == null ||
                              CompanyController.text == "null" ||
                              CompanyController.text == "") {
                            setState(() {
                              redGlobalSnackBar("Empty Company Name Invalid!");
                            });
                          } else if (CompanyNumberController.text == null ||
                              CompanyNumberController.text == "null" ||
                              CompanyNumberController.text == "") {
                            setState(() {
                              redGlobalSnackBar("Empty Company Number Invalid!");
                            });
                          }
                          } else if (IdController == null ||
                              IdController == "null" ||
                              IdController == "") {
                            setState(() {
                              redGlobalSnackBar("Invalid Status");
                            });
                          }
                          else {
                            setState(() {
                              progreess=true;
                            });
                            final User = signUpModel(
                              Email: emailController.text.trim(),
                              Password: passwordController.text.trim(),
                              PhoneNo: phonNoController.text.trim(),
                              Adress: AdressController.text.trim(),
                              Company: CompanyController.text.trim(),
                              CompenyNumber:
                                  CompanyNumberController.text.trim(),
                              role: IdController,
                            );
                            print(IdController.toString());
                            print("IdController.toString()");
                            authanication().signUp(User, context);
                            Future.delayed(Duration(milliseconds: 400), () {
                              setState(() {
                                progreess=false;
                              });// Close the snack bar after 3 seconds
                            });
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
                            child: Text('SIGN UP',
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
                    Center(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account?',
                                style: TextStyle(
                                  fontSize: 32 *
                                      MediaQuery.textScaleFactorOf(context),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                ),
                                textScaleFactor:
                                    SizeConfig.textScaleFactor(context, 0.7)),
                            InkWell(
                              onTap: () {
                                delayTiming().pushAndReplecemtNewScreen(
                                    context, login_tnb());
                              },
                              child: Text('LogIn',
                                  style: TextStyle(
                                    fontSize: 35 *
                                        MediaQuery.textScaleFactorOf(context),
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textScaleFactor:
                                      SizeConfig.textScaleFactor(context, 0.7)),
                            ),
                          ],
                        ),
                      ),
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
