import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tapnbuy/screens/seller/product/product_registration.dart';
import 'package:tapnbuy/screens/seller/product/showAllProductSeller.dart';
import 'package:tapnbuy/screens/seller/drawer/seller_dashboard_drawer.dart';
import 'package:tapnbuy/screens/responsive/text.dart';
import 'package:tapnbuy/screens/seller/product/updateproduct.dart';

import '../buyer/add_to_card.dart';
class dashboard_screen extends StatefulWidget {

  dashboard_screen({Key? key}) : super(key: key);
  @override
  State<dashboard_screen> createState() => _dashboard_screenState();
}
class _dashboard_screenState extends State<dashboard_screen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String id='';
  bool click=true;
  int ?a;
  void inputData() {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    // here you write the codes to input the data into firestore
  }
  TextEditingController _textEditingController=TextEditingController();
  bool switchs=false;
  List _product=[];
  List va=[];
   String p='' ;
  var _firestoreInsance=FirebaseFirestore.instance;
  final CollectionReference _products=FirebaseFirestore.instance.collection('ProductRegistration');
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  fetchProduct()async{
    QuerySnapshot qn=await _firestoreInsance.collection("ProductRegistration").get();
    setState(() {
      for (int i=0;i<qn.docs.length;i++){
        _product.add(
          {
            "productname":qn.docs[i]["productname"],
            "category":qn.docs[i]["category"],
            "company":qn.docs[i]["company"],
            "dispription":qn.docs[i]["dispription"],
            "imageUral":qn.docs[i]["imageUral"],
            "noofproduct":qn.docs[i]["noofproduct"],
            "serisalnumber":qn.docs[i]["serisalnumber"],

          }
        );
      }
    });
  }
  //....................To Update Data into inventory system...................
  updated(index,context) async{
    var collection = await FirebaseFirestore.instance.collection('ProductRegistration');
    var querySnapshots = await collection.get();
    print(querySnapshots.docs.length);
    for (var snapshot in querySnapshots.docs) {

        var documentID = snapshot.id; // <-- Document ID
        va.add(documentID);
    }
    for(int i=0;i<=va.length;i++){
      if(i==index){
        // print(va[i]);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => updatepage(products: va[i],)),
        );
         return va[i];
      }
    }
  }
  deleted(index) async{
    var collection = await FirebaseFirestore.instance.collection('ProductRegistration');
    var querySnapshots = await collection.get();
    print(querySnapshots.docs.length);
    for (var snapshot in querySnapshots.docs) {

      var documentID = snapshot.id; // <-- Document ID
      va.add(documentID);
    }
    for(int i=0;i<=va.length;i++){

      if(i==index){
        // print(va[i]);
        id=va[i];
       print(id);

     return await FirebaseFirestore.instance.collection('ProductRegistration').doc(id).delete();
      }
    }
  }
  void initState(){
    // updated();
    fetchProduct();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      resizeToAvoidBottomInset: false,
      appBar: switchs==true?AppBar(
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
              prefixIcon: Icon(Icons.search,color: Colors.black,),
              // hintText: 'Search'
            ),
              autofocus:true
          ),
        ),
        leading: IconButton(
          onPressed: (){
            setState(() {
              switchs=false;
            });
          },
          icon: const Icon(Icons.arrow_back,color: Colors.black,),
        ),
        centerTitle: true,
      ):
      AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            _scaffoldkey.currentState?.openDrawer();
          },
          icon: const Icon(Icons.menu,color: Colors.black,),
        ),
        centerTitle: true,
          actions: [
          // Navigate to the Search Screen
          IconButton(
            onPressed: (){
              setState(() {
                switchs=true;
              });
            },

    icon:  Icon(Icons.search,color: Colors.black,)
          ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 16),
              child: InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => product_page()),
                  );
                },
                  child: Icon(Icons.app_registration,color: Colors.black,)),
            )
          ],
      ),
      drawer: Drawer(
        child:seller_dashboard_drawer(),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  SizedBox(height:MediaQuery.of(context).size.height*0.01,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text('Latest',
                          style: TextStyle(
                            fontSize:50 * MediaQuery.textScaleFactorOf(context),
                            fontWeight: FontWeight.w700,
                          ),
                          textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                    ),
                  ),
                  SizedBox(height:MediaQuery.of(context).size.height*0.02,),
                  Container(
                      height: MediaQuery.of(context).size.height/3.7,
                      width:MediaQuery.of(context).size.width/1.1,
                      // color: Colors.black,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _product.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: (){
                                setState(() {
                                  a=index;
                                });
                              },
                              child: Container(
                                color:a==index? Colors.red[100] : Colors.white,
                                width:MediaQuery.of(context).size.width/2.7,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width:MediaQuery.of(context).size.width*0.01,),
                                        Container(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration:BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    height: MediaQuery.of(context).size.height/4.5,
                                                    width: MediaQuery.of(context).size.width/3.1,
                                                    child: Image.network(_product[index]["imageUral"]),)
                                                ],
                                              ),
                                              // Text('yugkyug')
                                            ],
                                          ),
                                        ),
                                        // SizedBox(width: 16,)
                                      ],
                                    ),
                                    Container(
                                      width:MediaQuery.of(context).size.width/3.8,
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 1.0),
                                              child: Text('${_product[index]["productname"]}',
                                                  style: TextStyle(
                                                    fontSize:35 * MediaQuery.textScaleFactorOf(context),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text('${_product[index]["noofproduct"].toString()}',
                                                style: TextStyle(
                                                    fontSize:30 * MediaQuery.textScaleFactorOf(context),
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.grey
                                                ),
                                                textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                SizedBox(height:MediaQuery.of(context).size.height*0.01,),
                Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('All Products',
                      style: TextStyle(
                        fontSize:50 * MediaQuery.textScaleFactorOf(context),
                        fontWeight: FontWeight.w700,
                      ),
                      textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                ),
                SizedBox(width:MediaQuery.of(context).size.width*0.37,),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => showAllProductSeller()),
                      );
                    },
                    child: Text('Show all',
                        style: TextStyle(
                          fontSize:30 * MediaQuery.textScaleFactorOf(context),
                          fontWeight: FontWeight.w700,
                        ),
                        textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                  ),
                ),
                Icon(
                  Icons.navigate_next,
                  size:23 * MediaQuery.textScaleFactorOf(context),),
              ],
                ),
                SizedBox(height:MediaQuery.of(context).size.height*0.03,),
                Expanded(
                  child: Container(
                  height: MediaQuery.of(context).size.height/2.4,
                  width:MediaQuery.of(context).size.width/1.075,
                  color: Colors.white,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: _product.length,
                      itemBuilder: (_,index) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(width:MediaQuery.of(context).size.width*0.01,),
                                Container(
                                  height: MediaQuery.of(context).size.height/9.0,
                                  width: MediaQuery.of(context).size.width/4.5,
                                  child: Image.network(_product[index]["imageUral"]
                                  ),
                                ),
                                SizedBox(width:MediaQuery.of(context).size.width*0.01,),
                                Container(
                                  width:MediaQuery.of(context).size.width/3.1,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('${_product[index]["productname"]}',
                                          style: TextStyle(
                                            fontSize:35 * MediaQuery.textScaleFactorOf(context),
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textScaleFactor: SizeConfig.textScaleFactor(context,0.7),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('${_product[index]["noofproduct"].toString()}',
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
                                SizedBox(width:MediaQuery.of(context).size.width*0.05,),
                                InkWell(
                                  onTap:() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => add_to_card()),
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
                                InkWell(
                                  onTap:() async {
                                    updated(index,context);
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
                                        child: Icon(Icons.edit,color: Colors.white,),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width:MediaQuery.of(context).size.width*0.01,),
                                InkWell (
                                  onTap:() {
                                    setState(() {
                                      deleted(index);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => dashboard_screen()),
                                      );
                                    });
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
                                        child: Icon(Icons.delete,color: Colors.white,),
                                      ),
                                    ),
                                  ),
                                ),
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
                      })

                  ),
                ),
              ],),
            )
          ],
        ),
      ),
    );
  }
}
