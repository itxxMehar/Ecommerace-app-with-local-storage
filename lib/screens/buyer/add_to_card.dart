import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tapnbuy/screens/buyer/shoping%20and%20return%20page.dart';
import 'package:tapnbuy/screens/responsive/text.dart';
import '../../src/models/productregistrationmodel.dart';
import '../formAddress.dart';
import 'customercare.dart';
import '../seller/dashboard_screen.dart';
import 'main_dashboard.dart';
class add_to_card extends StatefulWidget {
  String ?id;
  List <ProductRegistration> ?ProductRegistrationsNewArrival= [];
  ProductRegistration ?ProductRegistrations;
  add_to_card({Key? key,this.id,this.ProductRegistrationsNewArrival,this.ProductRegistrations}) : super(key: key);

  @override
  State<add_to_card> createState() => _add_to_cardState();
}

class _add_to_cardState extends State<add_to_card> {
  @override
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  var data;
  List <ProductRegistration> similar= [];
fetchData() async {
   data=await FirebaseFirestore.instance.collection("ProductRegistration").where('category',isEqualTo: widget.ProductRegistrations!.category)
      .get();
   setState(() {
     for(int i=0;i<data.docs.length;i++){
       setState(() {
         similar.add(ProductRegistration.fromJson(data.docs[i].data()));
       });
     }
   });print(similar.length);
}
@override
  void initState() {
  fetchData();
  // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              children: [
                // SizedBox(height: 55,),
                Container(
                  child: Center(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: Image.network(widget.ProductRegistrations!.imageUral[0],
                            height: MediaQuery.of(context).size.height/2.9,
                            width: MediaQuery.of(context).size.width/1.0,
                           // width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => main_dashboard()),
                                    );
                                  },
                                  child: InkWell(
                                    onTap:() {
                                      Navigator.pop(
                                        context,
                                        MaterialPageRoute(builder: (context) => dashboard_screen()),
                                      );
                                    },

                                    child: Icon(Icons.arrow_back,
                                      size:25 * MediaQuery.textScaleFactorOf(context),
                                      color: Colors.black,),
                                  ),
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width/4.8,),
                                Text(
                                    '${widget.ProductRegistrations?.productname}',
                                  style: TextStyle(color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    fontSize:45 * MediaQuery.textScaleFactorOf(context),),
                                    textScaleFactor: SizeConfig.textScaleFactor(context,0.7)
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width/6.8,),
                                Icon(Icons.drag_indicator_sharp,
                                  size: 25 * MediaQuery.textScaleFactorOf(context),
                                  color: Colors.black,),
                              ],
                            ),

                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/1.2,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text( '${widget.ProductRegistrations?.productname}',
                            style: TextStyle(
                              fontSize:70 * MediaQuery.textScaleFactorOf(context),
                              fontWeight: FontWeight.w700,
                            ),
                              textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                        ),
                      ),
                    ),
                    //SizedBox(width: 10,),
                    Icon(Icons.heart_broken_sharp,color: Colors.black,),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text( '${widget.ProductRegistrations?.price}',
                        style: TextStyle(
                          fontSize:40 * MediaQuery.textScaleFactorOf(context),
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                          textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                    ),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => formAdress(postID: widget.id,PosterId: widget.ProductRegistrations?.uid,ProductRegistrations: widget.ProductRegistrations,)),
                      );
                    },
                    child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text( "Buy Now",
                              style: TextStyle(
                                fontSize:40 * MediaQuery.textScaleFactorOf(context),
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                        ),
                  ),
                    // SizedBox(width:MediaQuery.of(context).size.width*0.14,),
                    // Icon(Icons.star,
                    //   size:20 * MediaQuery.textScaleFactorOf(context),
                    //   color: Colors.yellow.shade700,),
                    // SizedBox(width:MediaQuery.of(context).size.width*0.001,),
                    // Icon(Icons.star,
                    //   size:20 * MediaQuery.textScaleFactorOf(context),
                    //   color: Colors.yellow.shade700,),
                    // SizedBox(width:MediaQuery.of(context).size.width*0.001,),
                    // Icon(Icons.star,
                    //   size:20 * MediaQuery.textScaleFactorOf(context),
                    //   color: Colors.yellow.shade700,),
                    // SizedBox(width:MediaQuery.of(context).size.width*0.001,),
                    // Icon(Icons.star,
                    //   size:20 * MediaQuery.textScaleFactorOf(context),
                    //   color: Colors.yellow.shade700,),
                    // SizedBox(width:MediaQuery.of(context).size.width*0.001,),
                    // Icon(Icons.star,
                    //   size:20 * MediaQuery.textScaleFactorOf(context),
                    //   color: Colors.grey,),
                  ],
                ),
                SizedBox(height:MediaQuery.of(context).size.height*0.01,),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Divider(
                    thickness: 2,
                  ),
                ),
                SizedBox(height:MediaQuery.of(context).size.height*0.01,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text('Description',
                      style: TextStyle(
                        fontSize:60 * MediaQuery.textScaleFactorOf(context),
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                        textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                  ),
                ),
                SizedBox(height:MediaQuery.of(context).size.height*0.01,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text( '${widget.ProductRegistrations?.dispription}',
                      style: TextStyle(
                        fontSize:35 * MediaQuery.textScaleFactorOf(context),
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                        textScaleFactor: SizeConfig.textScaleFactor(context,0.7)
                    ),
                  ),
                ),
                SizedBox(height:MediaQuery.of(context).size.height*0.02,),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text('Sku',
                          style: TextStyle(
                            fontSize:40 * MediaQuery.textScaleFactorOf(context),
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                            textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width/3.3,),
                    Container(
                      child: Text( '${widget.ProductRegistrations?.serisalnumber}',
                        style: TextStyle(
                          fontSize:40 * MediaQuery.textScaleFactorOf(context),
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                          textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                    ),

                  ],
                ),

                SizedBox(height:MediaQuery.of(context).size.height*0.01,),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text('Categories',
                          style: TextStyle(
                            fontSize:40 * MediaQuery.textScaleFactorOf(context),
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                            textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                      ),
                    ),
                   SizedBox(width: MediaQuery.of(context).size.width/6.3,),
                    Container(
                      child: Text( '${widget.ProductRegistrations?.category}',
                        style: TextStyle(
                          fontSize:40 * MediaQuery.textScaleFactorOf(context),
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                          textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                    ),

                  ],
                ),
                SizedBox(height:MediaQuery.of(context).size.height*0.01,),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text('Company',
                          style: TextStyle(
                            fontSize:40 * MediaQuery.textScaleFactorOf(context),
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                            textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width/5.5,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        child: Text( '${widget.ProductRegistrations?.company}',
                          style: TextStyle(
                            fontSize:40 * MediaQuery.textScaleFactorOf(context),
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                            textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                      ),
                    ),

                  ],
                ),
                SizedBox(height:MediaQuery.of(context).size.height*0.03,),
                Row(

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Icon(
                        Icons.navigate_next,
                        size: 23 * MediaQuery.textScaleFactorOf(context)),
                    ),
                    //SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: InkWell(
                        onTap:() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => customercare()),
                          );
                        },

                        child: Text('COMPUSITION AND CARE',
                          style: TextStyle(
                            fontSize:40 * MediaQuery.textScaleFactorOf(context),
                            fontWeight: FontWeight.w700,
                          ),
                            textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height:MediaQuery.of(context).size.height*0.02,),
                Row(

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Icon(
                        Icons.navigate_next,
                        size:23 * MediaQuery.textScaleFactorOf(context),),
                    ),
                    //SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: InkWell(
                        onTap:() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => shopingreturn()),
                          );
                        },
                        child: Text('SHOPING AND RETURN',
                          style: TextStyle(
                            fontSize:40 * MediaQuery.textScaleFactorOf(context),
                            fontWeight: FontWeight.w700,
                          ),
                            textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                      ),
                    ),

                  ],
                ),
                // SizedBox(height:MediaQuery.of(context).size.height*0.01,),
                // Padding(
                //   padding: const EdgeInsets.only(left: 10.0),
                //   child: Divider(
                //     thickness: 2,
                //   ),
                // ),
                // SizedBox(height:MediaQuery.of(context).size.height*0.01,),
                // // Row(
                // //   children: [
                // //     Padding(
                // //       padding: const EdgeInsets.only(left: 20),
                // //       child: Text('Reviews',
                // //         style: TextStyle(
                // //           fontSize:50 * MediaQuery.textScaleFactorOf(context),
                // //           fontWeight: FontWeight.w700,
                // //         ),
                // //           textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                // //     ),
                // //     SizedBox(width: MediaQuery.of(context).size.width/2.3,),
                // //     Padding(
                // //       padding: const EdgeInsets.only(left: 20),
                // //       child: InkWell(
                // //         child: Text('Show all',
                // //           style: TextStyle(
                // //             fontSize:35 * MediaQuery.textScaleFactorOf(context),
                // //             fontWeight: FontWeight.w700,
                // //           ),
                // //             textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                // //       ),
                // //     ),
                // //     Icon(
                // //       Icons.navigate_next,
                // //       size:23 * MediaQuery.textScaleFactorOf(context),),
                // //   ],
                // // ),
                // SizedBox(height:MediaQuery.of(context).size.height*0.01,),
                // Row(
                //   children: [
                //     Column(
                //       children: [
                //         Container(
                //           child: Stack(
                //             children: <Widget>[
                //               Padding(
                //                 padding: const EdgeInsets.only(left: 20.0,right: 16,bottom: 16),
                //                 child: Container(
                //                   decoration: BoxDecoration(
                //                     color: Colors.blue,
                //                     borderRadius: BorderRadius.circular(10)
                //                   ),
                //                   alignment: Alignment.topLeft,
                //
                //                     height: MediaQuery.of(context).size.height/9.9,
                //                     width: MediaQuery.of(context).size.width/4.5,
                //                     // width: double.infinity,
                //                     // fit: BoxFit.cover,
                //                   ),
                //               ),
                //
                //               Padding(
                //                 padding: const EdgeInsets.all(20.0),
                //                 child: Container(
                //                   alignment: Alignment.topLeft,
                //                   child: Column(
                //                     children: [
                //
                //                       SizedBox(width:MediaQuery.of(context).size.width*0.22,),
                //                       Text(
                //                         '4.1',
                //                         style: TextStyle(color: Colors.white,
                //                             fontWeight: FontWeight.bold,
                //                           fontSize:45 * MediaQuery.textScaleFactorOf(context),
                //                         ),
                //                           textScaleFactor: SizeConfig.textScaleFactor(context,0.7)
                //                       ),
                //                       SizedBox(height:MediaQuery.of(context).size.height*0.01,),
                //                       Text('Out of 5',
                //                         style: TextStyle(color: Colors.white,
                //                           fontSize:30 * MediaQuery.textScaleFactorOf(context),
                //                         ),
                //                           textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                //                     ],
                //                   ),
                //                 ),
                //
                //               ),
                //
                //             ],
                //           ),
                //         ),
                //         Row(
                //           children: [
                //
                //             SizedBox(width: 7,),
                //             Icon(Icons.star,color: Colors.yellow.shade700,size: 15,),
                //             SizedBox(width: 2,),
                //             Icon(Icons.star,color: Colors.yellow.shade700,size: 15,),
                //             SizedBox(width: 2,),
                //             Icon(Icons.star,color: Colors.yellow.shade700,size: 15,),
                //             SizedBox(width: 2,),
                //             Icon(Icons.star,color: Colors.yellow.shade700,size: 15,),
                //             SizedBox(width: 2,),
                //             Icon(Icons.star,color: Colors.grey,size: 15,),
                //           ],
                //         ),
                //       ],
                //     ),
                //     Container(
                //       height: MediaQuery.of(context).size.height/5.9,
                //       width: MediaQuery.of(context).size.width/1.7,
                //       // color: Colors.teal,
                //       child: Column(
                //         children: [
                //
                //           Container(
                //             //alignment: Alignment.topLeft,
                //
                //             height: MediaQuery.of(context).size.height/25.9,
                //             width: MediaQuery.of(context).size.width/1.5,
                //
                //             child: Row(
                //               children: [
                //                 //SizedBox(width: 10,),
                //                 Text(
                //
                //                   'Excellent',
                //                   style: TextStyle(color: Colors.grey,
                //                       // fontWeight: FontWeight.bold,
                //                     fontSize:25 * MediaQuery.textScaleFactorOf(context),
                //                   ),
                //                     textScaleFactor: SizeConfig.textScaleFactor(context,0.7)
                //                 ),
                //                 SizedBox(height:MediaQuery.of(context).size.height*0.01,),
                //                 Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Container(
                //                     height: MediaQuery.of(context).size.height/30.9,
                //                     width: MediaQuery.of(context).size.width/2.9,
                //                     child: Divider(
                //                       thickness: 5,
                //                     ),
                //
                //                   ),
                //                 ),
                //
                //
                //
                //               ],
                //             ),
                //
                //
                //           ),
                //
                //           Container(
                //             //alignment: Alignment.topLeft,
                //
                //             height: MediaQuery.of(context).size.height/30.9,
                //             width: MediaQuery.of(context).size.width/1.5,
                //
                //             child: Row(
                //               children: [
                //                 //SizedBox(width: 10,),
                //                 Text(
                //
                //                   'Excellent',
                //                   style: TextStyle(color: Colors.grey,
                //                       // fontWeight: FontWeight.bold,
                //                     fontSize:25 * MediaQuery.textScaleFactorOf(context),),
                //                     textScaleFactor: SizeConfig.textScaleFactor(context,0.7)
                //                 ),
                //                 SizedBox(height:MediaQuery.of(context).size.height*0.01,),
                //                 Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Container(
                //                     height: MediaQuery.of(context).size.height/30.9,
                //                     width: MediaQuery.of(context).size.width/2.9,
                //                     child: Divider(
                //                       thickness: 5,
                //                     ),
                //
                //                   ),
                //                 ),
                //
                //
                //
                //               ],
                //             ),
                //
                //           ),
                //           Container(
                //             //alignment: Alignment.topLeft,
                //
                //             height: MediaQuery.of(context).size.height/30.9,
                //             width: MediaQuery.of(context).size.width/1.5,
                //
                //             child: Row(
                //               children: [
                //                 //SizedBox(width: 10,),
                //                 Text(
                //
                //                   'Excellent',
                //                   style: TextStyle(color: Colors.grey,
                //                       // fontWeight: FontWeight.bold,
                //                     fontSize:25 * MediaQuery.textScaleFactorOf(context),),
                //                     textScaleFactor: SizeConfig.textScaleFactor(context,0.7)
                //                 ),
                //                 SizedBox(height:MediaQuery.of(context).size.height*0.01,),
                //                 Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Container(
                //                     height: MediaQuery.of(context).size.height/30.9,
                //                     width: MediaQuery.of(context).size.width/2.9,
                //                     child: Divider(
                //                       thickness: 5,
                //                     ),
                //
                //                   ),
                //                 ),
                //
                //
                //
                //               ],
                //             ),
                //
                //           ),
                //           Container(
                //             //alignment: Alignment.topLeft,
                //
                //             height: MediaQuery.of(context).size.height/20.9,
                //             width: MediaQuery.of(context).size.width/1.5,
                //
                //             child: Row(
                //               children: [
                //                 //SizedBox(width: 10,),
                //                 Text(
                //
                //                   'Excellent',
                //                   style: TextStyle(color: Colors.grey,
                //                       // fontWeight: FontWeight.bold,
                //                     fontSize:25 * MediaQuery.textScaleFactorOf(context),),
                //                     textScaleFactor: SizeConfig.textScaleFactor(context,0.7)
                //                 ),
                //                 SizedBox(height:MediaQuery.of(context).size.height*0.01,),
                //                 Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Container(
                //                     height: MediaQuery.of(context).size.height/20.9,
                //                     width: MediaQuery.of(context).size.width/2.9,
                //                     child: Divider(
                //                       thickness: 5,
                //                     ),
                //
                //                   ),
                //                 ),
                //
                //
                //
                //               ],
                //             ),
                //
                //
                //           ),
                //
                //         ],
                //       ),
                //     )
                //   ],
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 20.0),
                //   child: Align(
                //     alignment: Alignment.topLeft,
                //     child: Container(
                //       child: Column(
                //         children: [
                //           Text('Add a comment',style: TextStyle(
                //             color: Colors.blue,
                //             fontWeight: FontWeight.w400,
                //             fontSize:35 * MediaQuery.textScaleFactorOf(context),
                //             decoration: TextDecoration.underline,
                //           ),
                //               textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height:MediaQuery.of(context).size.height*0.01,),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Divider(
                    thickness: 2,
                  ),
                ),
                SizedBox(height:MediaQuery.of(context).size.height*0.01,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text('Similar items',
                      style: TextStyle(
                        fontSize:50 * MediaQuery.textScaleFactorOf(context),
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
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
              itemCount: similar.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width:MediaQuery.of(context).size.width/2.7,
                  child: InkWell(
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
                        MaterialPageRoute(builder: (context) => add_to_card(ProductRegistrations: similar[index],ProductRegistrationsNewArrival: similar
                          ,id: Postid[index],)),
                      );

                    },
                    child: Column(

                      children: [
                        Row(
                          children: [
                            SizedBox(width:MediaQuery.of(context).size.width*0.01,),
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
                                        child: Image.network(similar[index].imageUral[0])
                                      )
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
                                  child: Text(similar[index].productname,
                                      style: TextStyle(
                                        fontSize:35 * MediaQuery.textScaleFactorOf(context),
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(similar[index].price,
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
                SizedBox(height:MediaQuery.of(context).size.height*0.04,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
