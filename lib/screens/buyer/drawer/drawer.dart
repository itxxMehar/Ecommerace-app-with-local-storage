import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tapnbuy/screens/authaction/login_tnb.dart';
import 'package:tapnbuy/src/addtocardcostomer.dart';
import 'package:tapnbuy/screens/responsive/text.dart';
import '../../../src/models/user_model.dart';
import '../add_to_card.dart';
import '../customernewcollection.dart';
import '../main_dashboard.dart';
import '../orders.dart';
import '../waitList.dart';
class drawer extends StatefulWidget {
  const drawer({Key? key}) : super(key: key);

  @override
  State<drawer> createState() => _drawerState();
}
class _drawerState extends State<drawer> {
  List <signUpModel> signUpModels= [];
  var querySnapshot;
  bool loading =true;
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
  @override
  signUserOut(){
    FirebaseAuth.instance.signOut();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height/90,),
              loading==true?
              Center(child: CircularProgressIndicator(),):
              Row(
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 16),
                      child: Container(
                        //height: 80,
                        child: CircleAvatar(
                            radius: 30,
                            child:
                            Image.asset("assets/images/bydefault.png")),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            // color: Colors.red,
                            child: Text(signUpModels[0].Email!=null?signUpModels[0].Email.substring(0,4):"",
                              style: TextStyle(
                                fontSize:40 * MediaQuery.textScaleFactorOf(context),
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                              ),
                                textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            child: Text(signUpModels[0].Email!=null?signUpModels[0].Email:"",
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
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
             Divider(thickness: 2,),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => main_dashboard()),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.65,
                        child: Center(
                          child: Row(
                            children: [
                              Icon(
                                Icons.home,
                                size:25 * MediaQuery.textScaleFactorOf(context),
                                color: Colors.grey,),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: InkWell(
                                  child: Text('Home',style: TextStyle(
                                      fontSize:35 * MediaQuery.textScaleFactorOf(context),
                                      fontWeight: FontWeight.w300
                                  ),
                                      textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => customernewcollection()),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.65,
                        child: Row(
                          children: [
                            Icon(
                              Icons.ac_unit_outlined,
                              size: 25 * MediaQuery.textScaleFactorOf(context),
                              color: Colors.grey,),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: InkWell(
                                child: Text('New Collection',style: TextStyle(
                                    fontSize:35 * MediaQuery.textScaleFactorOf(context),
                                    fontWeight: FontWeight.w300
                                ),
                                    textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => addtocardcustomer()),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.65,
                        child: Row(
                          children: [
                            Icon(
                              Icons.card_travel,
                              size: 25 * MediaQuery.textScaleFactorOf(context),
                              color: Colors.grey,),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: InkWell(
                                child: Text('Wish List',style: TextStyle(
                                    fontSize:35 * MediaQuery.textScaleFactorOf(context),
                                    fontWeight: FontWeight.w300
                                ),
                                    textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OrderList()),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.65,
                        child: Row(
                          children: [
                            Icon(
                              Icons.bookmark_border,
                              size: 25 * MediaQuery.textScaleFactorOf(context),
                              color: Colors.grey,),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: InkWell(
                                child: Text('Orders',style: TextStyle(
                                    fontSize:35 * MediaQuery.textScaleFactorOf(context),
                                    fontWeight: FontWeight.w300
                                ),
                                    textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => waitList()),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.65,
                        child: Row(
                          children: [
                            Icon(
                              Icons.waving_hand_outlined,
                              size: 25 * MediaQuery.textScaleFactorOf(context),
                              color: Colors.grey,),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: InkWell(
                                child: Text('Wait List',style: TextStyle(
                                    fontSize:35 * MediaQuery.textScaleFactorOf(context),
                                    fontWeight: FontWeight.w300
                                ),
                                    textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
              Divider(thickness: 2,),
              Container(
                width: MediaQuery.of(context).size.width*0.65,
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      size: 25 * MediaQuery.textScaleFactorOf(context),
                      color: Colors.grey,),
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
                            fontSize:35 * MediaQuery.textScaleFactorOf(context),
                            fontWeight: FontWeight.w300
                        ),
                            textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
