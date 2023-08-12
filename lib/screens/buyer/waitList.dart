import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Global/snackBar.dart';
import '../../firebase/authactions.dart';
import '../../src/models/orderModel.dart';
import '../../src/models/productregistrationmodel.dart';
import '../responsive/text.dart';
import 'drawer/drawer.dart';

class waitList extends StatefulWidget {
  const waitList({super.key});

  @override
  State<waitList> createState() => _waitListState();
}

class _waitListState extends State<waitList> {
  TextEditingController _textEditingController = TextEditingController();
  bool switchs = false;
  bool progreess = false;
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
  List<dynamic> localStore=[];
  List <ProductRegistration> ProductRegistrations=[];
  Future<void> fetchProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
 setState(() {
   String jsonData = prefs.getString('orderLocxalrealn') ?? '';
   if(jsonData!=""){
     List<dynamic> decodedData = jsonDecode(jsonData);
     OrderModels = decodedData
         .map((item) => OrderModel.fromJson(Map<String, dynamic>.from(item)))
         .toList();
     String jsonDataProductRegistrations = prefs.getString('orderProductRegistrationsrealn') ?? '';
     if(jsonDataProductRegistrations!=null){
       var decodedDataProductRegistrations = jsonDecode(jsonDataProductRegistrations);
       localStore = decodedDataProductRegistrations;
     }
   }
 });
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

                                    itemCount: localStore.length,
                                    itemBuilder: (_, index) {
                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                      height: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height / 9.0,
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width / 4.5,
                                                      child: Image.asset("assets/images/nonet.jpg")
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
                                                            '${localStore[index]
                                                            ["productname"]}',
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
                                                              '${localStore[index]
                                                              ["price"]
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
                                                ],
                                              ),
                                              progreess==true? loaderDesign(context):
                                              InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    progreess=true;
                                                  });
                                                  final User = OrderModel(
                                                      Email: OrderModels[index].Email,
                                                      FirstName: OrderModels[index].FirstName,
                                                      PhoneNo: OrderModels[index].PhoneNo,
                                                      Adress: OrderModels[index].PhoneNo,
                                                      LastName:  OrderModels[index].LastName,
                                                      City:
                                                      OrderModels[index].City,
                                                      posterIdProduct:  OrderModels[index].posterIdProduct,
                                                      Postid:  OrderModels[index].Postid,
                                                  );
                                                  authanication().placeOrder(User, context).whenComplete(() =>
                                                      Future.delayed(Duration(milliseconds: 700), () {
                                                        setState(() {
                                                          progreess=false;
                                                        });// Close the snack bar after 3 seconds
                                                      }));
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
                                                      child: Icon(Icons.post_add,
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
