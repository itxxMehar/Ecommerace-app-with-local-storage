import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tapnbuy/screens/authaction/signUp.dart';
import 'package:tapnbuy/screens/seller/product/product_registration.dart';
import 'package:tapnbuy/screens/authaction/login_tnb.dart';
import 'package:tapnbuy/screens/responsive/text.dart';
import 'package:tapnbuy/src/models/user_model.dart';
import '../../../Global/sharedPrefrences.dart';
import '../../buyer/sellerdashboared.dart';
import '../dashboard_screen.dart';
import '../product/ordersSellers.dart';
class seller_dashboard_drawer extends StatefulWidget {
  const seller_dashboard_drawer({Key? key}) : super(key: key);

  @override
  State<seller_dashboard_drawer> createState() => _seller_dashboard_drawerState();
}

class _seller_dashboard_drawerState extends State<seller_dashboard_drawer> {
  List <signUpModel> signUpModels= [];
  var querySnapshot;
  databAse() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    var uid ;
    final User? user = auth.currentUser;
    uid = user?.uid;
    querySnapshot= await FirebaseFirestore.instance.collection("Users").where("uid",isEqualTo: uid)
        .get();
    for(int i=0;i<querySnapshot.docs.length;i++){
      print(querySnapshot);
      setState(() {
        signUpModels.add(signUpModel.fromJson(querySnapshot.docs[i].data()));
        loading=false;
      });
    }
  }
  @override
   initState(){
    databAse();
    super.initState();
  }
   signUserOut(){

    FirebaseAuth.instance.signOut();

  }
  bool loading =true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height/90,),
              loading==true?
                  Center(child: CircularProgressIndicator(),):
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width/1.4,
                  child: Row(
                    children: [
                      Container(
                        //height: 80,
                        child: CircleAvatar(
                            radius: 30,
                            child:
                            Image.asset("assets/images/bydefault.png")),
                      )
                      ,SizedBox(width: 6,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(signUpModels!=null?signUpModels[0].Company.length>12?signUpModels[0].Company.substring(0,12):signUpModels[0].Company:"",
                              maxLines: 2,
                              style: TextStyle(
                                fontSize:50 * MediaQuery.textScaleFactorOf(context),
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                              ),
                              textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                          Text(signUpModels!=null?signUpModels[0].Email.length>16?signUpModels[0].Email.substring(0,16):signUpModels[0].Email:"",
                              style: TextStyle(
                                fontSize:30 * MediaQuery.textScaleFactorOf(context),
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
                              ),
                              textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),

                        ],
                      ),

                    ],

                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              Divider(thickness: 1,),
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
             Expanded(child: SingleChildScrollView(child: Column(
               children: [
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
                             MaterialPageRoute(builder: (context) => sellerDashboared()),
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
                 // SizedBox(height: MediaQuery.of(context).size.height*0.02,),

                 // Row(
                 //   children: [
                 //     Padding(
                 //       padding: const EdgeInsets.only(left: 35.0),
                 //       child: Icon(
                 //         Icons.ac_unit_outlined,
                 //         size: 30 * MediaQuery.textScaleFactorOf(context),
                 //         color: Colors.grey,),
                 //     ),
                 //     Padding(
                 //       padding: const EdgeInsets.all(16.0),
                 //       child: InkWell(
                 //         onTap: (){
                 //           Navigator.push(
                 //             context,
                 //             MaterialPageRoute(builder: (context) => dashboard_screen()),
                 //           );
                 //         },
                 //
                 //         child: Text('New Collection',style: TextStyle(
                 //             fontSize:40 * MediaQuery.textScaleFactorOf(context),
                 //             fontWeight: FontWeight.w300
                 //         ),
                 //             textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                 //       ),
                 //     )
                 //   ],
                 // ),

                 SizedBox(height: MediaQuery.of(context).size.height*0.01,),

                 Row(
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left: 35.0),
                       child: Icon(
                         Icons.app_registration,
                         size: 30 * MediaQuery.textScaleFactorOf(context),
                         color: Colors.grey,),
                     ),
                     Padding(
                       padding: const EdgeInsets.all(16.0),
                       child: InkWell(
                         onTap: (){
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) => product_page(heading: "Add Product",button: "Add Product",)),
                           );
                         },
                         child: Text('Add Product',style: TextStyle(
                             fontSize:40 * MediaQuery.textScaleFactorOf(context),
                             fontWeight: FontWeight.w300
                         ),
                             textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                       ),
                     )
                   ],
                 ),
                 SizedBox(height: MediaQuery.of(context).size.height*0.01,),

                 Row(
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left: 35.0),
                       child: Icon(
                         Icons.bookmark_border,
                         size: 30 * MediaQuery.textScaleFactorOf(context),
                         color: Colors.grey,),
                     ),
                     Padding(
                       padding: const EdgeInsets.all(16.0),
                       child: InkWell(
                         onTap: (){
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) => ordersSellers()),
                           );
                         },
                         child: Text('Orders',style: TextStyle(
                             fontSize:40 * MediaQuery.textScaleFactorOf(context),
                             fontWeight: FontWeight.w300
                         ),
                             textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                       ),
                     )
                   ],
                 ),
               ],
             ),)),
              Divider(thickness: 1,),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0),
                    child: Icon(
                      Icons.login,
                      size: 30 * MediaQuery.textScaleFactorOf(context),
                      color: Colors.grey,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell (
                      onTap: () async {
                        await signUserOut();
                        await sharedPrefrences().storeVal("login", "3");
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => login_tnb()),
                              (route) => false,
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
