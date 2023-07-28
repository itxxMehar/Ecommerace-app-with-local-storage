import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tapnbuy/firebase/authactions.dart';
import '../screens/buyer/add_to_card.dart';
import '../screens/buyer/drawer/drawer.dart';
import '../screens/responsive/text.dart';
import '../screens/seller/product/updateproduct.dart';
import 'models/productregistrationmodel.dart';

class addtocardcustomer extends StatefulWidget {

  addtocardcustomer({Key? key}) : super(key: key);

  // final currentUser=FirebaseAuth.instance;
  // _docRef=FirebaseFirestore.instance.collection("ProductRegistration").doc(id);


  @override
  State<addtocardcustomer> createState() => _addtocardcustomerState();
}

class _addtocardcustomerState extends State<addtocardcustomer> {
  TextEditingController _textEditingController = TextEditingController();
  bool switchs = false;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  StreamController<List<ProductRegistration>> _streamController =
  StreamController<List<ProductRegistration>>();
  List<Map<String, dynamic>> _orderModels = [];
  List<ProductRegistration> _productRegistrationsNewArrival = [];
  List<String> _postId = [];
  List<ProductRegistration> _ordersList = [];

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  Future<void> fetchProduct() async {
    try {
      _streamController= StreamController<List<ProductRegistration>>();
      final User? user = _auth.currentUser;
      var uid = user?.uid;
      print(uid);

      // Fetch the "whistList" data where 'uid' is equal to the current user's UID as a stream.
      var orderStream = FirebaseFirestore.instance
          .collection("whistList")
          .where('uid', isEqualTo: uid)
          .snapshots();

      // Listen for changes in the "whistList" data stream.
      orderStream.listen((querySnapshot) {
        _orderModels.clear();
        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data();
          _orderModels.add(data);
        }
        print(_orderModels.length);
        checkOrders();
      });

      // Fetch "ProductRegistration" data as a stream.
      var dataStream =
      FirebaseFirestore.instance.collection("ProductRegistration").snapshots();

      // Listen for changes in the "ProductRegistration" data stream.
      dataStream.listen((querySnapshot) {
        _productRegistrationsNewArrival.clear();
        _postId.clear();
        for (var snapshot in querySnapshot.docs) {
          ProductRegistration product =
          ProductRegistration.fromJson(snapshot.data());
          _productRegistrationsNewArrival.add(product);
          _postId.add(snapshot.id);
        }
        print(_productRegistrationsNewArrival.length);
        checkOrders();
      });
    } catch (e) {
      print('Error fetching data from Firestore: $e');
    }
  }

  void checkOrders() {
    if (_orderModels.isNotEmpty && _productRegistrationsNewArrival.isNotEmpty) {
      _ordersList.clear();
      for (int i = 0; i < _orderModels[0]["whish"].length; i++) {
        for (int j = 0; j < _postId.length; j++) {
          if (_orderModels[0]["whish"][i] == _postId[j]) {
            print(_orderModels[0]["whish"][i]);
            setState(() {
              _ordersList.add(_productRegistrationsNewArrival[j]);
            });
          }
        }
      }
      print(_ordersList.length);

      // Create a new Stream with new instances of the _ordersList
      _streamController.add(List<ProductRegistration>.from(_ordersList));
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
                  child: Text('Add To Cart',
                      style: TextStyle(
                        fontSize: 55 * MediaQuery.textScaleFactorOf(context),
                        fontWeight: FontWeight.w700,
                      ),
                      textScaleFactor: SizeConfig.textScaleFactor(
                          context, 0.7)),
                ),
              ),
              Expanded(
                  child: Container(
                    // height: MediaQuery.of(context).size.height/4.3,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 1.075,
                      child: MediaQuery.removePadding(
                          context: context,
                          child: Container(
                            // height: MediaQuery.of(context).size.height/4.3,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 1.075,
                            child: MediaQuery.removePadding(
                                context: context,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,

                                    itemCount: _ordersList.length,
                                    itemBuilder: (_, index) {
                                      return Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.01,),
                                              Container(


                                                height: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height / 9.0,
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width / 4.5,
                                                child: Image.network(
                                                    _ordersList[index].imageUral[0]
                                                ),

                                              ),
                                              SizedBox(width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.01,),

                                              Container(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width / 3.1,
                                                child: Column(

                                                  children: [
                                                    Align(
                                                      alignment: Alignment
                                                          .topLeft,
                                                      child: Text(
                                                        '${_ordersList[index]
                                                            .productname}',
                                                        style: TextStyle(
                                                          fontSize: 35 *
                                                              MediaQuery
                                                                  .textScaleFactorOf(
                                                                  context),
                                                          fontWeight: FontWeight
                                                              .w700,
                                                        ),

                                                        textScaleFactor: SizeConfig
                                                            .textScaleFactor(
                                                            context, 0.7),

                                                      ),

                                                    ),
                                                    Align(
                                                      alignment: Alignment
                                                          .topLeft,
                                                      child: Text(
                                                          '${_ordersList[index]
                                                              .price
                                                              .toString()}',
                                                          style: TextStyle(
                                                            fontSize: 30 *
                                                                MediaQuery
                                                                    .textScaleFactorOf(
                                                                    context),
                                                            fontWeight: FontWeight
                                                                .w700,
                                                            color: Colors.grey,
                                                          ),
                                                          textScaleFactor: SizeConfig
                                                              .textScaleFactor(
                                                              context, 0.7)),
                                                    ),

                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.19,),
                                              InkWell(
                                                onTap: () async {
                                                  var Postid = [];
                                                  DateTime lastWeek = DateTime
                                                      .now().subtract(
                                                      Duration(days: 7));
                                                  QuerySnapshot<Map<String,
                                                      dynamic>> users =
                                                  await FirebaseFirestore
                                                      .instance.collection(
                                                      "ProductRegistration")
                                                      .where('timeStamp',
                                                      isGreaterThanOrEqualTo: lastWeek)
                                                      .get();
                                                  for (var snapshot in users
                                                      .docs) {
                                                    // documentID = snapshot.id;
                                                    Postid.add(snapshot.id);
                                                  }
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            add_to_card(
                                                              ProductRegistrations: _ordersList[index],
                                                              ProductRegistrationsNewArrival: _ordersList
                                                              ,
                                                              id: Postid[index],)),
                                                  );
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius: BorderRadius
                                                        .circular(12),
                                                    //   border: Border.all(color: Colors.blue)
                                                  ),
                                                  child: Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .all(2.0),
                                                      child: Icon(
                                                        Icons.remove_red_eye,
                                                        color: Colors.white,),

                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.01,),
                                              InkWell(
                                                onTap: () async {
                                                  FirebaseAuth auth = await FirebaseAuth.instance;
                                                  var uid ;
                                                  var Postid = [],
                                                      postId = [];
                                                  final User? user = auth.currentUser;
                                                  uid = user?.uid;
                                                  print(uid);
                                                  List<Map<String,dynamic>>OrderModels=[];
                                                  var order = await FirebaseFirestore.instance.collection("whistList").where('uid', isEqualTo: uid)
                                                      .get();
                                                  for (var doc in order.docs) {
                                                    Map<String, dynamic> data = doc.data();
                                                    OrderModels.add(data);
                                                  }

                                                  authanication()
                                                      .removeFromWhishlist(
                                                      OrderModels[0]["whish"][index]);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius: BorderRadius
                                                        .circular(12),
                                                    //   border: Border.all(color: Colors.blue)
                                                  ),
                                                  child: Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .all(2.0),
                                                      child: Icon(Icons.delete,
                                                        color: Colors.white,),

                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.01,),

                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width / 1.1,
                                              child: Divider(
                                                thickness: 2,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                )
                            ),
                          )
                      )
                  )

              )
            ],

          ),
        ),
      ),
    );
  }
}
