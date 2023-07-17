import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tapnbuy/screens/seller/drawer/seller_dashboard_drawer.dart';
import 'package:tapnbuy/screens/responsive/text.dart';

import 'add_to_card.dart';
class customercare extends StatefulWidget {

  customercare({Key? key}) : super(key: key);
  // final currentUser=FirebaseAuth.instance;
  // _docRef=FirebaseFirestore.instance.collection("ProductRegistration").doc(id);


  @override
  State<customercare> createState() => _customercareState();
}

class _customercareState extends State<customercare> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String id='';


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
          child:seller_dashboard_drawer(),
        ),
        body: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height:MediaQuery.of(context).size.height*0.01,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap:() {
                            Navigator.pop(
                              context,
                              MaterialPageRoute(builder: (context) => add_to_card()),
                            );
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size:23 * MediaQuery.textScaleFactorOf(context),),
                        ),
                        Text('Compusition And Care',
                            style: TextStyle(
                              fontSize:70 * MediaQuery.textScaleFactorOf(context),
                              fontWeight: FontWeight.w700,
                            ),
                            textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                        Text('',
                            style: TextStyle(
                              fontSize:70 * MediaQuery.textScaleFactorOf(context),
                              fontWeight: FontWeight.w700,
                            ),
                            textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                      ],
                    ),
                  ),
                ),


                SizedBox(height:MediaQuery.of(context).size.height*0.03,),
                Container(
                  height: MediaQuery.of(context).size.height/1.28,
                  width:MediaQuery.of(context).size.width/1.075,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text('Respond promptly to customer inquiries: Make sure you respond to customer inquiries as quickly as possible, ideally within 24 hours. This will show your customers that you value their time and are committed to providing excellent service.'

                               ' Use a customer relationship management (CRM) system: Implementing a CRM system can help you keep track of customer inquiries, orders, and interactions. This will help you provide more personalized service and ensure that nothing falls through the cracks.'

                         ' Monitor social media for customer feedback: Keep an eye on your social media accounts and respond to customer comments and reviews. This will show your customers that you are listening and care about their opinions.'

                          'Offer proactive customer service: Don''t wait for customers to contact you with a problem – reach out to them proactively to offer assistance. For example, you could send a follow-up email after a purchase to make sure everything went smoothly, or provide helpful tips and resources related to your products.'

                          'Continuously improve your customer service: Collect feedback from your customers and use it to improve your customer service processes. This could include making changes to your website, training your customer service team, or updating your policies based on customer suggestions.'
                                ,style: TextStyle(
                                  fontSize:40 * MediaQuery.textScaleFactorOf(context),
                                  fontWeight: FontWeight.w400,
                                ),
                                textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],

            ),
          ),
        ),
      ),
    );
  }
}
