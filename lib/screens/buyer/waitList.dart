import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../firebase/authactions.dart';
import '../../src/models/orderModel.dart';
import '../../src/models/productregistrationmodel.dart';
import '../responsive/text.dart';
import 'add_to_card.dart';
import 'drawer/drawer.dart';

class waitList extends StatefulWidget {
  const waitList({super.key});

  @override
  State<waitList> createState() => _waitListState();
}

class _waitListState extends State<waitList> {
  TextEditingController _textEditingController = TextEditingController();
  bool switchs = false;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  List <OrderModel> OrderModels= [];

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = prefs.getString('orderLocxal') ?? '';
    if(jsonData!=""){
      List<dynamic> decodedData = jsonDecode(jsonData);
      OrderModels = decodedData
          .map((item) => OrderModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      resizeToAvoidBottomInset: false,
      appBar: switchs == true ? AppBar(
        backgroundColor: Colors.white,

        title: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(15),
                prefixIcon: Icon(Icons.search, color: Colors.black,),
                // hintText: 'Search'
              ),
              autofocus: true
          ),
        ),
        leading: IconButton(
          onPressed: () {
            switchs = false;
          },


          icon: const Icon(Icons.arrow_back, color: Colors.black,),
        ),

        centerTitle: true,

      ) :
      AppBar(
        backgroundColor: Colors.white,


        leading: IconButton(
          onPressed: () {
            _scaffoldkey.currentState?.openDrawer();
            // if (ZoomDrawer.of(context)!.isOpen()){
            //   ZoomDrawer.of(context)!.close();
            // }
            // else{
            //   ZoomDrawer.of(context)!.open();
            // }

          },


          icon: const Icon(Icons.menu, color: Colors.black,),
        ),
        centerTitle: true,
        // actions: [
        //   // Navigate to the Search Screen
        //   IconButton(
        //       onPressed: () {
        //         setState(() {
        //           switchs = true;
        //         });
        //       },
        //
        //       icon: Icon(Icons.search, color: Colors.black,)
        //   ),
        // ],

      ),
      drawer: Drawer(
        child: drawer(),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.01,),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('Wait List',
                      style: TextStyle(
                        fontSize: 55 * MediaQuery.textScaleFactorOf(context),
                        fontWeight: FontWeight.w700,
                      ),
                      textScaleFactor: SizeConfig.textScaleFactor(
                          context, 0.7)),
                ),
              ),
              // Expanded(
              //     child: Container(
              //       // height: MediaQuery.of(context).size.height/4.3,
              //         width: MediaQuery
              //             .of(context)
              //             .size
              //             .width / 1.075,
              //         child: MediaQuery.removePadding(
              //             context: context,
              //             child: Container(
              //               // height: MediaQuery.of(context).size.height/4.3,
              //               width: MediaQuery
              //                   .of(context)
              //                   .size
              //                   .width / 1.075,
              //               child: MediaQuery.removePadding(
              //                   context: context,
              //                   child: ListView.builder(
              //                       scrollDirection: Axis.vertical,
              //
              //                       itemCount: _ordersList.length,
              //                       itemBuilder: (_, index) {
              //                         return Column(
              //                           children: [
              //                             Row(
              //                               children: [
              //                                 SizedBox(width: MediaQuery
              //                                     .of(context)
              //                                     .size
              //                                     .width * 0.01,),
              //                                 Container(
              //
              //
              //                                   height: MediaQuery
              //                                       .of(context)
              //                                       .size
              //                                       .height / 9.0,
              //                                   width: MediaQuery
              //                                       .of(context)
              //                                       .size
              //                                       .width / 4.5,
              //                                   child: Image.network(
              //                                       _ordersList[index].imageUral[0]
              //                                   ),
              //
              //                                 ),
              //                                 SizedBox(width: MediaQuery
              //                                     .of(context)
              //                                     .size
              //                                     .width * 0.01,),
              //
              //                                 Container(
              //                                   width: MediaQuery
              //                                       .of(context)
              //                                       .size
              //                                       .width / 3.1,
              //                                   child: Column(
              //
              //                                     children: [
              //                                       Align(
              //                                         alignment: Alignment
              //                                             .topLeft,
              //                                         child: Text(
              //                                           '${_ordersList[index]
              //                                               .productname}',
              //                                           style: TextStyle(
              //                                             fontSize: 35 *
              //                                                 MediaQuery
              //                                                     .textScaleFactorOf(
              //                                                     context),
              //                                             fontWeight: FontWeight
              //                                                 .w700,
              //                                           ),
              //
              //                                           textScaleFactor: SizeConfig
              //                                               .textScaleFactor(
              //                                               context, 0.7),
              //
              //                                         ),
              //
              //                                       ),
              //                                       Align(
              //                                         alignment: Alignment
              //                                             .topLeft,
              //                                         child: Text(
              //                                             '${_ordersList[index]
              //                                                 .price
              //                                                 .toString()}',
              //                                             style: TextStyle(
              //                                               fontSize: 30 *
              //                                                   MediaQuery
              //                                                       .textScaleFactorOf(
              //                                                       context),
              //                                               fontWeight: FontWeight
              //                                                   .w700,
              //                                               color: Colors.grey,
              //                                             ),
              //                                             textScaleFactor: SizeConfig
              //                                                 .textScaleFactor(
              //                                                 context, 0.7)),
              //                                       ),
              //
              //                                     ],
              //                                   ),
              //                                 ),
              //                                 SizedBox(width: MediaQuery
              //                                     .of(context)
              //                                     .size
              //                                     .width * 0.19,),
              //                                 InkWell(
              //                                   onTap: () async {
              //                                     var Postid = [];
              //                                     DateTime lastWeek = DateTime
              //                                         .now().subtract(
              //                                         Duration(days: 7));
              //                                     QuerySnapshot<Map<String,
              //                                         dynamic>> users =
              //                                     await FirebaseFirestore
              //                                         .instance.collection(
              //                                         "ProductRegistration")
              //                                         .where('timeStamp',
              //                                         isGreaterThanOrEqualTo: lastWeek)
              //                                         .get();
              //                                     for (var snapshot in users
              //                                         .docs) {
              //                                       // documentID = snapshot.id;
              //                                       Postid.add(snapshot.id);
              //                                     }
              //                                     Navigator.push(
              //                                       context,
              //                                       MaterialPageRoute(
              //                                           builder: (context) =>
              //                                               add_to_card(
              //                                                 ProductRegistrations: _ordersList[index],
              //                                                 ProductRegistrationsNewArrival: _ordersList
              //                                                 ,
              //                                                 id: Postid[index],)),
              //                                     );
              //                                   },
              //                                   child: Container(
              //                                     decoration: BoxDecoration(
              //                                       color: Colors.black,
              //                                       borderRadius: BorderRadius
              //                                           .circular(12),
              //                                       //   border: Border.all(color: Colors.blue)
              //                                     ),
              //                                     child: Center(
              //                                       child: Padding(
              //                                         padding: const EdgeInsets
              //                                             .all(2.0),
              //                                         child: Icon(
              //                                           Icons.remove_red_eye,
              //                                           color: Colors.white,),
              //
              //                                       ),
              //                                     ),
              //                                   ),
              //                                 ),
              //                                 SizedBox(width: MediaQuery
              //                                     .of(context)
              //                                     .size
              //                                     .width * 0.01,),
              //                                 InkWell(
              //                                   onTap: () async {
              //                                     FirebaseAuth auth = await FirebaseAuth.instance;
              //                                     var uid ;
              //                                     var Postid = [],
              //                                         postId = [];
              //                                     final User? user = auth.currentUser;
              //                                     uid = user?.uid;
              //                                     print(uid);
              //                                     List<Map<String,dynamic>>OrderModels=[];
              //                                     var order = await FirebaseFirestore.instance.collection("whistList").where('uid', isEqualTo: uid)
              //                                         .get();
              //                                     for (var doc in order.docs) {
              //                                       Map<String, dynamic> data = doc.data();
              //                                       OrderModels.add(data);
              //                                     }
              //
              //                                     authanication()
              //                                         .removeFromWhishlist(
              //                                         OrderModels[0]["whish"][index]);
              //                                   },
              //                                   child: Container(
              //                                     decoration: BoxDecoration(
              //                                       color: Colors.black,
              //                                       borderRadius: BorderRadius
              //                                           .circular(12),
              //                                       //   border: Border.all(color: Colors.blue)
              //                                     ),
              //                                     child: Center(
              //                                       child: Padding(
              //                                         padding: const EdgeInsets
              //                                             .all(2.0),
              //                                         child: Icon(Icons.delete,
              //                                           color: Colors.white,),
              //
              //                                       ),
              //                                     ),
              //                                   ),
              //                                 ),
              //                               ],
              //                             ),
              //                             SizedBox(height: MediaQuery
              //                                 .of(context)
              //                                 .size
              //                                 .height * 0.01,),
              //
              //                             Align(
              //                               alignment: Alignment.centerRight,
              //                               child: Container(
              //                                 width: MediaQuery
              //                                     .of(context)
              //                                     .size
              //                                     .width / 1.1,
              //                                 child: Divider(
              //                                   thickness: 2,
              //                                 ),
              //                               ),
              //                             ),
              //                           ],
              //                         );
              //                       }
              //                   )
              //               ),
              //             )
              //         )
              //     )
              //
              // )
            ],

          ),
        ),
      ),
    );
  }
}
