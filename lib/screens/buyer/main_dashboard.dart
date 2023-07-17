import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tapnbuy/src/addtocardcostomer.dart';
import 'package:tapnbuy/screens/responsive/text.dart';
import 'package:tapnbuy/screens/seller/product/updateproduct.dart';
import 'add_to_card.dart';
import '../seller/dashboard_screen.dart';
import 'drawer/drawer.dart';
import 'drawer/drawer_backend.dart';
class main_dashboard extends StatefulWidget {
  const main_dashboard({Key? key}) : super(key: key);

  @override
  State<main_dashboard> createState() => _main_dashboardState();
}

class _main_dashboardState extends State<main_dashboard> {
  TextEditingController _textEditingController=TextEditingController();
  bool switchs=false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String id='';
  bool click=true;
  int ?a;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  void inputData() {
    final User? user = auth.currentUser;
    final uid = user?.uid;
  }
  List _product=[];
  List va=[];
  String p='' ;
  var _firestoreInsance=FirebaseFirestore.instance;
  final CollectionReference _products=FirebaseFirestore.instance.collection('ProductRegistration');
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
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: switchs==true?AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
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
        ),
        leading: IconButton(
          onPressed: (){
            switchs==false;
          },
          icon: const Icon(Icons.arrow_back,color: Colors.black,),
        ),
        centerTitle: true,
      ):
      AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,


        leading: IconButton(
          onPressed: (){
            _scaffoldkey.currentState?.openDrawer();
          },
          icon: const Icon(Icons.menu,color: Colors.black,),
        ),
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
                  MaterialPageRoute(builder: (context) => addtocardcustomer()),
                );
              },
                child: Icon(Icons.shopping_bag_outlined,color: Colors.black,)),
          )
        ],
      ),
      drawer: Drawer(
        child: drawer(),
      ),
      body: WillPopScope(
        onWillPop: () async {
          final value=await showDialog<bool>(context: context, builder: (context){
            return AlertDialog(
              title: const Text('Alert'),
              content: const Text('Do you want to Exit'),
              actions: [
                ElevatedButton(onPressed: ()=>Navigator.of(context).pop(false), child: const Text('No')
                ),
                ElevatedButton(onPressed: ()=>SystemNavigator.pop(), child: const Text('Exit')
                ),
              ],
            );
          });
          if(value!=null){
            return Future.value(value);
          }else
          {
            return Future.value(false);
          }
        },
        child: Container(
          child: Column(
            children: [
              SizedBox(height:MediaQuery.of(context).size.height/28.0),
              Container(
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      Container(

                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/hero-image.png',
                          height: MediaQuery.of(context).size.height/2.9,
                          width: MediaQuery.of(context).size.width/1.0,
                          // width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height/2.9,
                        width: MediaQuery.of(context).size.width/1.0,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            height: MediaQuery.of(context).size.height/5.9,
                            width: MediaQuery.of(context).size.width/1.2,
                            alignment: Alignment.bottomLeft,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FittedBox(
                                    child: Text(
                                      'Sales Up',
                                      style: TextStyle(color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize:30),
                                      // textScaleFactor: SizeConfig.textScaleFactor(context,0.7),
                                    ),
                                  ),
                                ),
                                Container(
                                  // color: Colors.red,
                                  child: Text(
                                    'To 70% Off',
                                    style: TextStyle(color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 70 * MediaQuery.textScaleFactorOf(context)),
                                    textScaleFactor: SizeConfig.textScaleFactor(context,0.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/90,),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text('New Arrival',
                              style: TextStyle(
                                fontSize: 40 * MediaQuery.textScaleFactorOf(context),
                                fontWeight: FontWeight.w700,
                              ),
                              textScaleFactor: SizeConfig.textScaleFactor(context,0.7),
                            ),
                          ),
                          SizedBox(width:MediaQuery.of(context).size.width/2.2,),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text('Show all',
                              style: TextStyle(
                                fontSize: 30 * MediaQuery.textScaleFactorOf(context),
                                fontWeight: FontWeight.w700,
                              ),
                              textScaleFactor: SizeConfig.textScaleFactor(context,0.7),
                            ),
                          ),
                          Icon(
                            Icons.navigate_next,
                            size: 23 * MediaQuery.textScaleFactorOf(context),),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/90,),
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
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => dashboard_screen()),
                            // );
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
                            child: Center(
                                    child: Stack(
                                      children: <Widget>[
                                      Container(
                                        // color: click? Colors.white : Color(0xFFFFEBE7),
                                        // color: !click ? Colors.blue : Colors.white,
                                        // height: 10,
                                        // width: 10,
                                        // color: Colors.black,
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
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              // alignment: Alignment.topRight,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.heart_broken_sharp,color: Colors.black,),

                                                ],
                                              ),

                                            ),
                                          ),
                                        ),
                      ],
                                    ),
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
              SizedBox(height:MediaQuery.of(context).size.height*0.01,),


                      SizedBox(height: MediaQuery.of(context).size.height/90,),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text('Best Sallers',
                              style: TextStyle(
                                fontSize: 40 * MediaQuery.textScaleFactorOf(context),
                                fontWeight: FontWeight.w700,
                              ),
                              textScaleFactor: SizeConfig.textScaleFactor(context,0.7),),
                          ),
                          SizedBox(width:MediaQuery.of(context).size.width/2.3,),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text('Show all',
                              style: TextStyle(
                                fontSize: 30 * MediaQuery.textScaleFactorOf(context),
                                fontWeight: FontWeight.w700,
                              ),
                              textScaleFactor: SizeConfig.textScaleFactor(context,0.7),),
                          ),
                          Icon(
                            Icons.navigate_next,
                            size: 22 * MediaQuery.textScaleFactorOf(context),),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                      // Container(
                      //   height: MediaQuery.of(context).size.height/4.2,
                      //   width:MediaQuery.of(context).size.width/1.075,
                      //   color: Colors.white,
                      //   child: ListView.builder(
                      //       scrollDirection: Axis.vertical,
                      //       itemCount: 7,
                      //       itemBuilder: (BuildContext context, int index) {
                      //         return Column(
                      //           children: [
                      //             Row(
                      //               children: [
                      //                 SizedBox(width:MediaQuery.of(context).size.width/20.0,),
                      //                 Container(
                      //
                      //
                      //                     height: MediaQuery.of(context).size.height/8.5,
                      //                     width:MediaQuery.of(context).size.width/5.0,
                      //                     child: Image.asset('assets/images/6.png',fit: BoxFit.fill,)),
                      //                 SizedBox(width:MediaQuery.of(context).size.width/25.0,),
                      //
                      //                 Container(
                      //                   width:MediaQuery.of(context).size.width/3.1,
                      //                   child: Column(
                      //
                      //                     children: [
                      //                       Align(
                      //                         alignment: Alignment.topLeft,
                      //                         child: Text('Showes',
                      //                             style: TextStyle(
                      //                               fontSize: 35* MediaQuery.textScaleFactorOf(context),
                      //                               fontWeight: FontWeight.w700,
                      //                             ),
                      //                             textScaleFactor: SizeConfig.textScaleFactor(context,0.7)
                      //                         ),
                      //
                      //                       ),
                      //                       Align(
                      //                         alignment: Alignment.topLeft,
                      //                         child: Text('1126 items',
                      //                             style: TextStyle(
                      //                               fontSize:20 * MediaQuery.textScaleFactorOf(context),
                      //                               fontWeight: FontWeight.w700,
                      //                               color: Colors.grey,
                      //                             ),
                      //                             textScaleFactor: SizeConfig.textScaleFactor(context,0.7)
                      //                         ),
                      //                       ),
                      //
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 SizedBox(width:MediaQuery.of(context).size.width/12.0,),
                      //                 Container(
                      //
                      //                   decoration: BoxDecoration(
                      //                     color: Colors.black,
                      //                     //borderRadius: BorderRadius.circular(12),
                      //                     //   border: Border.all(color: Colors.blue)
                      //                   ),
                      //                   child: Center(
                      //                       child: Padding(
                      //                         padding: const EdgeInsets.only(left: 10.0,right: 10,top: 5,bottom: 5),
                      //                         child: Text(
                      //                             'Shop',
                      //                             style:
                      //                             TextStyle(color: Colors.white,
                      //                               // fontWeight: FontWeight.bold,
                      //                               fontSize:45 * MediaQuery.textScaleFactorOf(context),),
                      //                             textScaleFactor: SizeConfig.textScaleFactor(context,0.7)
                      //                         ),
                      //                       )),
                      //                 ),
                      //
                      //               ],
                      //             ),
                      //             SizedBox(height:8,),
                      //
                      //             Align(
                      //               alignment: Alignment.centerRight,
                      //               child: Container(
                      //                 width: MediaQuery.of(context).size.width/1.1,
                      //                 child: Divider(
                      //                   thickness: 2,
                      //                 ),
                      //               ),
                      //             ),
                      //
                      //           ],
                      //         );
                      //       }),
                      //
                      // ),
              Container(
                  height: MediaQuery.of(context).size.height/4.3,
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
                                SizedBox(width:MediaQuery.of(context).size.width*0.19,),

                                InkWell(
                                  onTap:() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => add_to_card(product: _product[index])),
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
                                // SizedBox(width:MediaQuery.of(context).size.width*0.01,),
                                //
                                // InkWell(
                                //   onTap:() async {
                                //     //   print(index);
                                //     updated(index,context);
                                //
                                //   },
                                //   child: Container(
                                //     decoration: BoxDecoration(
                                //       color: Colors.black,
                                //       borderRadius: BorderRadius.circular(12),
                                //       //   border: Border.all(color: Colors.blue)
                                //     ),
                                //     child: Center(
                                //       child: Padding(
                                //         padding: const EdgeInsets.all(2.0),
                                //         child: Icon(Icons.add_shopping_cart_rounded,color: Colors.white,),
                                //
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                SizedBox(width:MediaQuery.of(context).size.width*0.01,),

                                InkWell (

                                  onTap:() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => addtocardcustomer()),
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
                                        child: Icon(Icons.add_shopping_cart,color: Colors.white,),

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

                    ],
          )
        ),
      ),
    );
  }
}
