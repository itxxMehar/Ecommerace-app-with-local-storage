import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tapnbuy/screens/authaction/login_tnb.dart';
import 'package:tapnbuy/src/addtocardcostomer.dart';
import 'package:tapnbuy/screens/responsive/text.dart';
import '../add_to_card.dart';
import '../customernewcollection.dart';
import '../main_dashboard.dart';
class drawer extends StatefulWidget {
  const drawer({Key? key}) : super(key: key);

  @override
  State<drawer> createState() => _drawerState();
}
class _drawerState extends State<drawer> {
  @override
  signUserOut(){
    FirebaseAuth.instance.signOut();
  }
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
             SizedBox(height: MediaQuery.of(context).size.height/90,),
              Row(
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 16),
                      child: Container(
                        //height: 80,
                        child: CircleAvatar(
                            radius: 30,
                            child:
                        Image.asset('assets/images/c.PNG')),
                      ),
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            // color: Colors.red,
                            child: Text('Fazan Anasari',
                              style: TextStyle(
                                fontSize:60 * MediaQuery.textScaleFactorOf(context),
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                              ),
                                textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            child: Text('fazanansari@gmail.com',
                              style: TextStyle(
                                fontSize:30 * MediaQuery.textScaleFactorOf(context),
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
                              ),
                                textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              SizedBox(height: MediaQuery.of(context).size.height*0.06,),
             Row(
               children: [
                 Padding(
                   padding: const EdgeInsets.only(left: 35.0),
                   child: Icon(
            Icons.home,
            size:30 * MediaQuery.textScaleFactorOf(context),
                     color: Colors.grey,),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(16.0),
                   child: InkWell(
                     onTap: (){
                   Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => main_dashboard()),
                   );
                   },
                     child: Text('Home',style: TextStyle(
                         fontSize:40 * MediaQuery.textScaleFactorOf(context),
                       fontWeight: FontWeight.w300
                     ),
                         textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                   ),
                 )
               ],
             ),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0),
                    child: Icon(
                      Icons.ac_unit_outlined,
                      size: 30 * MediaQuery.textScaleFactorOf(context),
                      color: Colors.grey,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => customernewcollection()),
                        );
                      },
                      child: Text('New Collection',style: TextStyle(
                          fontSize:40 * MediaQuery.textScaleFactorOf(context),
                          fontWeight: FontWeight.w300
                      ),
                          textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                    ),
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0),
                    child: Icon(
                      Icons.card_travel,
                      size: 30 * MediaQuery.textScaleFactorOf(context),
                      color: Colors.grey,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => addtocardcustomer()),
                        );
                      },
                      child: Text('Cart',style: TextStyle(
                          fontSize:40 * MediaQuery.textScaleFactorOf(context),
                          fontWeight: FontWeight.w300
                      ),
                          textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                    ),
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.47,),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0),
                    child: Icon(
                      Icons.logout,
                      size: 30 * MediaQuery.textScaleFactorOf(context),
                      color: Colors.grey,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      onTap: () async {
                       await signUserOut();
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => login_tnb()),
                       );
                      },
                      child: Text('Logout',style: TextStyle(
                          fontSize:40 * MediaQuery.textScaleFactorOf(context),
                          fontWeight: FontWeight.w300
                      ),
                          textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
