import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tapnbuy/screens/buyer/drawer/drawer.dart';

import '../../src/models/orderModel.dart';
import '../../src/models/productregistrationmodel.dart';
import '../responsive/text.dart';
import 'add_to_card.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  List <ProductRegistration> ProductRegistrationsNewArrival= [];
  List <ProductRegistration> ordersLi= [];
  List <OrderModel> OrderModels= [];
  var documentIds = [];
  fetchProduct()async{
    FirebaseAuth auth = await FirebaseAuth.instance;
    var uid ;
    final User? user = auth.currentUser;
    uid = user?.uid;
    print(uid);
    var order = await FirebaseFirestore.instance.collection("Orders").where('Userid', isEqualTo: uid)
        .get();
    for(int i=0;i<order.docs.length;i++){
        OrderModels.add(OrderModel.fromJson(order.docs[i].data()));
        documentIds.add(OrderModels[i].Postid);
    }
    print(OrderModels.length);
    DateTime lastWeek = DateTime.now().subtract(Duration(days: 7));
    var data = await FirebaseFirestore.instance.collection("ProductRegistration").where(FieldPath.documentId, whereIn: documentIds)
        .get();
      // for(int i=0;i<data.docs.length;i++){
      //     ProductRegistrationsNewArrival.add(ProductRegistration.fromJson(data.docs[i].data()));
      // }
    print(data);
    print(ProductRegistrationsNewArrival.length);
      List<String> postId=[];
    for(int i=0;i<OrderModels.length;i++) {
      for (var snapshot in data.docs) {
        // documentID = snapshot.id;
        print(snapshot.id);
        postId.add(snapshot.id);
        if ( snapshot.id==OrderModels[i].Postid ) {
          setState(() {
            print(OrderModels[i].Postid);
            print(i);
            ordersLi.add(ProductRegistration.fromJson(data.docs[i].data()));
            print(ordersLi[i].imageUral);
          });
        }
      }
    }
    print(ordersLi.length);
  }
  @override
  void initState() {
    fetchProduct();
    // TODO: implement initState
    super.initState();
  }
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  bool switchs = false;
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      resizeToAvoidBottomInset: false,
      appBar: switchs == true ?
      AppBar(
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
        child:  Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.03,
                child: Text('Orders List',
                    style: TextStyle(
                      fontSize:
                      50 * MediaQuery.textScaleFactorOf(context),
                      fontWeight: FontWeight.w700,
                    ),
                    textScaleFactor:
                    SizeConfig.textScaleFactor(context, 0.7)),
              ),
            ),
            Expanded(
              child: Container(
                // height: MediaQuery.of(context).size.height/4.3,
                  width:MediaQuery.of(context).size.width/1.075,
                  color: Colors.white,
                  child: MediaQuery.removePadding(
                    context: context,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,

                        itemCount: ordersLi.length,
                        itemBuilder: (_,index) {

                          return Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width:MediaQuery.of(context).size.width*0.01,),
                                  Container(


                                    height: MediaQuery.of(context).size.height/9.0,
                                    width: MediaQuery.of(context).size.width/4.5,
                                    child: Image.network(ordersLi[index].imageUral[0]
                                    ),

                                  ),
                                  SizedBox(width:MediaQuery.of(context).size.width*0.01,),

                                  Container(
                                    width:MediaQuery.of(context).size.width/3.1,
                                    child: Column(

                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text('${ordersLi[index].productname}',
                                            style: TextStyle(
                                              fontSize:35 * MediaQuery.textScaleFactorOf(context),
                                              fontWeight: FontWeight.w700,
                                            ),

                                            textScaleFactor: SizeConfig.textScaleFactor(context,0.7),

                                          ),

                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text('${ordersLi[index].price.toString()}',
                                              style: TextStyle(
                                                fontSize:30 * MediaQuery.textScaleFactorOf(context),
                                                fontWeight: FontWeight.w700,
                                                color: Colors.grey,
                                              ),
                                              textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                                        ),

                                      ],
                                    ),
                                  ),
                                  SizedBox(width:MediaQuery.of(context).size.width*0.19,),
                                  InkWell(
                                    onTap:() async {
                                      var Postid=[];
                                      DateTime lastWeek = DateTime.now().subtract(Duration(days: 7));
                                      QuerySnapshot<Map<String, dynamic>>  users =
                                      await FirebaseFirestore.instance.collection("ProductRegistration").where('timeStamp', isGreaterThanOrEqualTo: lastWeek)
                                          .get();
                                      for (var snapshot in users.docs) {
                                        // documentID = snapshot.id;
                                        Postid.add(snapshot.id);
                                      }
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => add_to_card(ProductRegistrations: ordersLi[index],ProductRegistrationsNewArrival: ordersLi
                                          ,id: Postid[index],)),
                                      );

                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(12),
                                        //   border: Border.all(color: Colors.blue)
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Icon(Icons.remove_red_eye,color: Colors.white,),

                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width:MediaQuery.of(context).size.width*0.01,),

                                ],
                              ),
                              SizedBox(height:MediaQuery.of(context).size.height*0.01,),

                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: MediaQuery.of(context).size.width/1.1,
                                  child: Divider(
                                    thickness: 2,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  )

              ),
            ),
          ],
        ),
      ),
    );
  }
}