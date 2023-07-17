import 'package:flutter/material.dart';
import 'package:tapnbuy/screens/responsive/text.dart';

import 'screens/buyer/main_dashboard.dart';
class thanku_page extends StatefulWidget {
  const thanku_page({Key? key}) : super(key: key);

  @override
  State<thanku_page> createState() => _thanku_pageState();
}

class _thanku_pageState extends State<thanku_page> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height:MediaQuery.of(context).size.height*0.01,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width/11.0,
                    child: Icon(
                      Icons.cancel_outlined,
                      size: 25,),
                  ),
                ),
                SizedBox(height:MediaQuery.of(context).size.height*0.1,),
                Align(
                  alignment: Alignment.center,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Icon(
                        Icons.check_circle_outlined,
                        size: 200,),
                    ),
                  ),
                ),
                SizedBox(height:MediaQuery.of(context).size.height*0.02,),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: Text('Thank you!',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),),
                  ),
                ),
                SizedBox(height:MediaQuery.of(context).size.height*0.015,),
                Center(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Your order ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),),
                        Container(
                          child: Text('#7896',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),),
                        ),
                        Text('is completed.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Text('Please check the delivery status at',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text('Order Tracking ',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),),
                    ),
                    Container(
                      child: Text('page',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),),
                    ),
                  ],
                ),

                SizedBox(height:MediaQuery.of(context).size.height*0.1,),



                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: InkWell(
                    onTap:() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => main_dashboard()),
                      );

                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 15,right: 15),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        //borderRadius: BorderRadius.circular(12),
                        //   border: Border.all(color: Colors.blue)
                      ),
                      child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text(
                                'Continue Shoping',
                                style:
                                TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 38* MediaQuery.textScaleFactorOf(context),
                                ),
                                textScaleFactor: SizeConfig.textScaleFactor(context,0.7)
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ),
      ),
    );
  }
}
