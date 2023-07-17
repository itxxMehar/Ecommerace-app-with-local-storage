import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/buyer/drawer/drawer.dart';
import '../screens/responsive/text.dart';
import '../screens/seller/product/updateproduct.dart';
class addtocardcustomer extends StatefulWidget {

  addtocardcustomer({Key? key}) : super(key: key);
  // final currentUser=FirebaseAuth.instance;
  // _docRef=FirebaseFirestore.instance.collection("ProductRegistration").doc(id);


  @override
  State<addtocardcustomer> createState() => _addtocardcustomerState();
}

class _addtocardcustomerState extends State<addtocardcustomer> {
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
  // String? value;
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
    return SafeArea(
      child: Scaffold(
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
              switchs=false;
            },


            icon: const Icon(Icons.arrow_back,color: Colors.black,),
          ),

          centerTitle: true,

        ):AppBar(
          backgroundColor: Colors.white,


          leading: IconButton(
            onPressed: (){
              _scaffoldkey.currentState?.openDrawer();
              // if (ZoomDrawer.of(context)!.isOpen()){
              //   ZoomDrawer.of(context)!.close();
              // }
              // else{
              //   ZoomDrawer.of(context)!.open();
              // }

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
              child: Icon(Icons.shopping_bag_outlined,color: Colors.black,),
            )
          ],

        ),
        drawer: Drawer(
          child:drawer(),
        ),
        body: Container(
          child: Column(
            children: [
              SizedBox(height:MediaQuery.of(context).size.height*0.01,),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('Add To Cart',
                      style: TextStyle(
                        fontSize:70 * MediaQuery.textScaleFactorOf(context),
                        fontWeight: FontWeight.w700,
                      ),
                      textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                ),
              ),
              SizedBox(height:MediaQuery.of(context).size.height*0.02,),



            ],

          ),
        ),
      ),
    );
  }
}
