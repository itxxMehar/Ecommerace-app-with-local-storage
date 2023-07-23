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
  TextEditingController _textEditingController=TextEditingController();
  bool switchs=false;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
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
            switchs=false;
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
      body: SafeArea(
        child: Container(
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
