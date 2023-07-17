import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tapnbuy/screens/seller/product/product_registration.dart';
import 'package:tapnbuy/screens/seller/drawer/seller_dashboard_drawer.dart';
import 'package:tapnbuy/screens/responsive/text.dart';
import 'package:tapnbuy/src/models/productregistrationmodel.dart';
import '../seller/product/showAllProductSeller.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
class sellerDashboared extends StatefulWidget {
  const sellerDashboared({super.key});

  @override
  State<sellerDashboared> createState() => _sellerDashboaredState();
}

class _sellerDashboaredState extends State<sellerDashboared> {
  stt.SpeechToText speech = stt.SpeechToText();
  void startListening() {
    speech.listen(
      onResult: (result) {
        setState(() {
          // Process the recognized speech result
          String recognizedText = result.recognizedWords;
          _textEditingController.text=recognizedText;
          // Do something with the recognized text
        });
      },
    );
    speech.stop();
  }
  void stopListening() {
    speech.stop();
  }
  String id='';
  int ?a;
  TextEditingController _textEditingController=TextEditingController();
  bool switchs=false;
  List va=[];
  List <ProductRegistration> ProductRegistrations= [];
  databAse() async {
    ProductRegistrations.clear();
    var querySnapshot= await FirebaseFirestore.instance.collection("ProductRegistration").where('uid',isEqualTo:  FirebaseAuth.instance.currentUser?.uid)
        .get();
    for(int i=0;i<querySnapshot.docs.length;i++){
      print(querySnapshot);
      setState(() {
        ProductRegistrations.add(ProductRegistration.fromJson(querySnapshot.docs[i].data()));
      });
    }
  }
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  idDocument(index,context,data) async{
    var collection = await FirebaseFirestore.instance.collection('ProductRegistration').where('uid',isEqualTo:  FirebaseAuth.instance.currentUser?.uid);
    var querySnapshots = await collection.get();
    print(querySnapshots.docs.length);
    for (var snapshot in querySnapshots.docs) {
      var documentID = snapshot.id; // <-- Document ID
      va.add(documentID);
    }
    for(int i=0;i<=va.length;i++){

      if(i==index){
       // return va[i];
       Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => product_page(idDocument: va[i],productregistration: data,heading:"Edit Product",button: "Update",)),
       );
      }
    }
  }
  deleted(index) async{
    var collection = await FirebaseFirestore.instance.collection('ProductRegistration').where('uid',isEqualTo:  FirebaseAuth.instance.currentUser?.uid);
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

        await FirebaseFirestore.instance.collection('ProductRegistration').doc(id).delete();
      }
    }
  }
   initState(){
    // updated();
    databAse();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
      child: Scaffold(
        key: _scaffoldkey,
        resizeToAvoidBottomInset: false,
        appBar: switchs==true?
        AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Flexible(
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
         InkWell(
             onLongPress: startListening,
             child: Icon(Icons.mic,color: Colors.black,)),
            ],
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
              child: InkWell
                (onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => product_page(heading:"Add Product",button: "Add Product",)),
                );
              },
                  child: Icon(Icons.app_registration,color: Colors.black,)),
            )
          ],
        ),
        drawer: Drawer(
          child:seller_dashboard_drawer(),
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                SizedBox(height:MediaQuery.of(context).size.height*0.01,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text('Latest',
                        style: TextStyle(
                          fontSize:55 * MediaQuery.textScaleFactorOf(context),
                          fontWeight: FontWeight.w700,
                        ),
                        textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                  ),
                ),
                SizedBox(height:MediaQuery.of(context).size.height*0.02,),
                Container(
                  height: MediaQuery.of(context).size.height/3.7,
                  width:MediaQuery.of(context).size.width/1.1,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("ProductRegistration").where('timeStamp', isGreaterThanOrEqualTo: DateTime.now().subtract(Duration(days: 7))).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      List<DocumentSnapshot> documents = snapshot.data!.docs;
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: documents.length,
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
                                                    child: Image.network(documents[index]["imageUral"]!=null?documents[index]["imageUral"]![0]:"",),)
                                                ],
                                              ),
                                              // Text('yugkyug')
                                            ],
                                          ),
                                        ),
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
                                              child: Text(documents[index]["productname"]!=null?documents[index]["productname"]:"",
                                                  style: TextStyle(
                                                    fontSize:35 * MediaQuery.textScaleFactorOf(context),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(documents[index]["price"]!=null?documents[index]["price"]:"",
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

                          });
                    },
                  ),
                ),
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
                            MaterialPageRoute(builder: (context) => showAllProductSeller(ProductRegistrations:ProductRegistrations,)),
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
                    width:MediaQuery.of(context).size.width/1.075,
                    color: Colors.white,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection("ProductRegistration").where('uid',isEqualTo:  FirebaseAuth.instance.currentUser?.uid).snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        List<DocumentSnapshot> documents = snapshot.data!.docs;
                        return
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: documents.length,
                              itemBuilder: (_,index) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width:MediaQuery.of(context).size.width*0.01,),
                                        Container(
                                          height: MediaQuery.of(context).size.height/9.0,
                                          width: MediaQuery.of(context).size.width/4.5,
                                       child: Image.network(documents[index]["imageUral"]!=null?documents[index]["imageUral"]![0]:"",),),
                                        SizedBox(width:MediaQuery.of(context).size.width*0.01,),
                                        Container(
                                          width:MediaQuery.of(context).size.width/3.1,
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(documents[index]["productname"]!=null?documents[index]["productname"]:"",
                                                  style: TextStyle(
                                                    fontSize:35 * MediaQuery.textScaleFactorOf(context),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  textScaleFactor: SizeConfig.textScaleFactor(context,0.7),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(documents[index]["price"]!=null?documents[index]["price"]:"",
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
                                          onTap:() async {
                                            var collection = await FirebaseFirestore.instance.collection('ProductRegistration').where('uid',isEqualTo:  FirebaseAuth.instance.currentUser?.uid);
                                            var querySnapshots = await collection.get();
                                            print(querySnapshots.docs.length);
                                            for (var snapshot in querySnapshots.docs) {
                                              var documentID = snapshot.id; // <-- Document ID
                                              va.add(documentID);
                                            }
                                            for(int i=0;i<=va.length;i++){

                                              if(i==index){
                                                // return va[i];
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => product_page(idDocument: va[i],productregistration: ProductRegistrations[index],heading:"View Product",button: "",)),
                                                );
                                              }
                                            }
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
                                            List <ProductRegistration> ProductRegistrations= [];
                                            snapshot.data!.docs.forEach((DocumentSnapshot document) {
                                              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                                              ProductRegistration productRegistration = ProductRegistration.fromJson(data);
                                              ProductRegistrations.add(productRegistration);
                                            });
                                            await idDocument(index,context,ProductRegistrations[index]);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.circular(12),
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
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.circular(12),
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
                              });
                      },
                    ),
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
