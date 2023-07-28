import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:tapnbuy/screens/seller/product/showAllProductSeller.dart';
import 'package:tapnbuy/src/addtocardcostomer.dart';
import 'package:tapnbuy/screens/responsive/text.dart';
import 'package:tapnbuy/screens/seller/product/updateproduct.dart';
import '../../firebase/authactions.dart';
import '../../src/models/productregistrationmodel.dart';
import '../seller/product/product_registration.dart';
import 'add_to_card.dart';
import 'drawer/drawer.dart';
class customernewcollection extends StatefulWidget {
  customernewcollection({Key? key}) : super(key: key);
  @override
  State<customernewcollection> createState() => _customernewcollectionState();
}
class _customernewcollectionState extends State<customernewcollection> {

  SpeechToText _speechToText = SpeechToText();
  String texts='';
  bool _speechEnabled = false;
  String _lastWords = '';
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    print(_speechEnabled);
    setState(() {});
  }
  void _startListening() async {
    focusNode.unfocus();
    await _speechToText.listen(onResult: _onSpeechResult);
  }
  void _stopListening() async {
    focusNode.hasFocus;
    await _speechToText.stop();
  }
  void _onTextChanged() {
    String text = _textEditingController.text;
    final newPosition = text.length;
    _textEditingController.selection = TextSelection.fromPosition(
      TextPosition(offset: newPosition),
    );
  }
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      _textEditingController.text=_lastWords;
      _textEditingController.addListener(_onTextChanged);
    });
  }
_filterData( String query) async {
  ProductRegistrationslatest.clear();
    DateTime lastWeek = DateTime.now().subtract(Duration(days: 7));
    List <ProductRegistration> ProductRegistrationslatestssss= [];
    var data = await FirebaseFirestore.instance.collection("ProductRegistration").where('timeStamp', isGreaterThanOrEqualTo: lastWeek)
        .get();
    for(int i=0;i<data.docs.length;i++){
      ProductRegistrationslatestssss.add(ProductRegistration.fromJson(data.docs[i].data()));
    }
    print(ProductRegistrationslatestssss.length);
    setState(() {
      for(int i=0;i<ProductRegistrationslatestssss.length;i++) {
        if (ProductRegistrationslatestssss[i].productname.toLowerCase()
            .contains(query.toLowerCase())) {
          setState(() {
            ProductRegistrationslatest.add(ProductRegistrationslatestssss[i]);
          });
        }
      }
    });
    print(ProductRegistrationslatest.length);

  }
  List<ProductRegistration> _filterDataNot(QuerySnapshot snapshot) {
    print("dfngldf");
    return snapshot.docs
        .map((doc) => ProductRegistration(
      productname: doc['productname'].toString(),
      company: doc['company'].toString(),
      category: doc['category'].toString(),
      price: doc['price'] ?? 0.0,
      serisalnumber: doc['serisalnumber'].toString(),
      dispription: doc['dispription'].toString(),
      imageUral: List<String>.from(doc['imageUral'] ?? []),
    ))
        .toList();
  }
  @override
  void dispose() {
    // _stream = null;
    _textEditingController.dispose();
    super.dispose();
  }
  final FocusNode focusNode = FocusNode();
  String id='';
  int ?a;
  TextEditingController _textEditingController=TextEditingController();
  bool switchs=false;
  List <ProductRegistration> ProductRegistrationslatest= [];
  List <ProductRegistration> ProductRegistrationsaLL= [];
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  fetchProduct()async{
    DateTime lastWeek = DateTime.now().subtract(Duration(days: 7));
    var data = await FirebaseFirestore.instance.collection("ProductRegistration").where('timeStamp', isGreaterThanOrEqualTo: lastWeek)
        .get();
    setState(() {
      for(int i=0;i<data.docs.length;i++){
        setState(() {
          ProductRegistrationslatest.add(ProductRegistration.fromJson(data.docs[i].data()));
        });
      }
    });
  }
  fetchProductall()async{
    var data = await FirebaseFirestore.instance.collection("ProductRegistration")
        .get();
    setState(() {
      for(int i=0;i<data.docs.length;i++){
        setState(() {
          ProductRegistrationsaLL.add(ProductRegistration.fromJson(data.docs[i].data()));
        });
      }
    });
  }
  @override
  initState(){
    fetchProduct();
    fetchProductall();
    _initSpeech();
    // databAse();
    super.initState();
  }
  bool progreess=false;
  int ?inde;
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
            onChanged: (text) async {
              _filterData(text);
            },
              controller: _textEditingController,
              focusNode: focusNode,
              decoration: InputDecoration(
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(15),
                prefixIcon: Icon(Icons.search,color: Colors.black,),
                suffixIcon: InkWell(
                    onTap: (){
                      _speechToText.isNotListening ? _startListening (): _stopListening();},
                    child: Icon(Icons.mic,color: Colors.black,))
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
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => addtocardcustomer()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 16),
              child: Icon(Icons.shopping_bag_outlined,color: Colors.black,),
            ),
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
                  child: Text('Latest',
                      style: TextStyle(
                        fontSize:70 * MediaQuery.textScaleFactorOf(context),
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
                      itemCount: ProductRegistrationslatest.length,
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
                                                child: Image.network(ProductRegistrationslatest[index].imageUral[0]),)
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
                                          child: Text('${ProductRegistrationslatest[index].productname}',
                                              style: TextStyle(
                                                fontSize:35 * MediaQuery.textScaleFactorOf(context),
                                                fontWeight: FontWeight.w700,
                                              ),
                                              textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('${ProductRegistrationslatest[index].price.toString()}',
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
                          MaterialPageRoute(builder: (context) => showAllProductSeller(ProductRegistrations:ProductRegistrationsaLL,ide: 0,)),
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
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: ProductRegistrationsaLL.length,
                        itemBuilder: (_,index) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width:MediaQuery.of(context).size.width*0.01,),
                                  Container(
                                    height: MediaQuery.of(context).size.height/9.0,
                                    width: MediaQuery.of(context).size.width/4.5,
                                    child: Image.network(ProductRegistrationsaLL[index].imageUral[0]
                                    ),

                                  ),
                                  SizedBox(width:MediaQuery.of(context).size.width*0.01,),

                                  Container(
                                    width:MediaQuery.of(context).size.width/3.1,
                                    child: Column(

                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text('${ProductRegistrationsaLL[index].productname}',
                                            style: TextStyle(
                                              fontSize:35 * MediaQuery.textScaleFactorOf(context),
                                              fontWeight: FontWeight.w700,
                                            ),

                                            textScaleFactor: SizeConfig.textScaleFactor(context,0.7),

                                          ),

                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text('${ProductRegistrationsaLL[index].price.toString()}',
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
                                      QuerySnapshot<Map<String, dynamic>>  users =
                                      await FirebaseFirestore.instance.collection("ProductRegistration")
                                          .get();
                                      for (var snapshot in users.docs) {
                                        // documentID = snapshot.id;
                                        Postid.add(snapshot.id);
                                      }
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => add_to_card(ProductRegistrations: ProductRegistrationsaLL[index],ProductRegistrationsNewArrival: ProductRegistrationsaLL
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
                                  progreess==true&&index==inde? Container(
                                      width:12,
                                      height:12,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.0,
                                      )):

                                  InkWell (
                                    onTap:() async {
                                      List<String> PostId=[];
                                      setState(() {
                                        progreess=true;
                                        inde=index;
                                      });
                                      var data = await FirebaseFirestore.instance.collection("ProductRegistration")
                                          .get();
                                      for (var snapshot in data.docs) {
                                        PostId.add(snapshot.id);
                                      }
                                      authanication().whishList(PostId[index]);
                                      Future.delayed(Duration(milliseconds: 700), () {
                                        setState(() {
                                          progreess=false;
                                        });// Close the snack bar after 3 seconds
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
                        }),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
