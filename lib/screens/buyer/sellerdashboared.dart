import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:tapnbuy/screens/seller/product/product_registration.dart';
import 'package:tapnbuy/screens/seller/drawer/seller_dashboard_drawer.dart';
import 'package:tapnbuy/screens/responsive/text.dart';
import 'package:tapnbuy/src/models/productregistrationmodel.dart';
import '../seller/product/showAllProductSeller.dart';
class sellerDashboared extends StatefulWidget {
  const sellerDashboared({super.key});

  @override
  State<sellerDashboared> createState() => _sellerDashboaredState();
}

class _sellerDashboaredState extends State<sellerDashboared> {
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
  Stream<QuerySnapshot> _stream = _getInitialStream();
  static Stream<QuerySnapshot> _getInitialStream() {
    DateTime lastWeek = DateTime.now().subtract(Duration(days: 7));
    var data= FirebaseFirestore.instance
        .collection("ProductRegistration");
    var dat2= data.where('timeStamp', isGreaterThanOrEqualTo: lastWeek);
    return dat2.snapshots();
  }
  List<ProductRegistration> _filterData(QuerySnapshot snapshot, String query) {
    print("dfngldf");
    return snapshot.docs
        .where((doc) => doc['productname'].toLowerCase().contains(query.toLowerCase()))
        .where((doc) => doc['uid']==FirebaseAuth.instance.currentUser?.uid)
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
    _stream.drain();
    // _stream = null;
    _textEditingController.dispose();
    super.dispose();
  }
  final FocusNode focusNode = FocusNode();
  String id='';
  int ?a;
  TextEditingController _textEditingController=TextEditingController();
  bool switchs=false;
  List va=[];
  List <ProductRegistration> ProductRegistrations= [];
  List <ProductRegistration> ProductRegistrationsaLL= [];
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
  Stream<QuerySnapshot> _getFilteredStream(String query) {
    DateTime lastWeek = DateTime.now().subtract(Duration(days: 7));
    print(lastWeek);
    final ProductRegistration = FirebaseFirestore.instance.collection("ProductRegistration");
   var data1= ProductRegistration.where('uid',isEqualTo:  FirebaseAuth.instance.currentUser?.uid);
    data1
        .where('productname', isGreaterThanOrEqualTo: query)
        .where('productname', isLessThan: query + 'z');
    data1
        .where('timeStamp', isGreaterThanOrEqualTo: lastWeek);
    // data1.where('uid',isEqualTo:  FirebaseAuth.instance.currentUser?.uid);
    return data1.snapshots();
  }
   initState(){
     _initSpeech();
    // databAse();
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
                  focusNode: focusNode,
                    onChanged: (text){
                       // texts=text.toString().trim().toLowerCase();
                       setState(() {
                         _stream = _getFilteredStream(text);
                       });
                    },
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(15),
                      prefixIcon: Icon(Icons.search,color: Colors.black,),
                    ),
                    autofocus:true
                ),
              ),
         InkWell(
             onTap: (){
               _speechToText.isNotListening ? _startListening (): _stopListening();},
             child: const Icon(Icons.mic,color: Colors.black,)),
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
                    stream: _stream,
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      else if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      else if (snapshot.hasData==null) {
                        return Center(child: Text("NO data Found"));
                      }
                      else{
                        ProductRegistrations = _filterData(snapshot.data!, _textEditingController.text);
                      // List<DocumentSnapshot> documents = snapshot.data!.docs;
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: ProductRegistrations.length,
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
                                // color:a==index? Colors.red[100] : Colors.white,
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
                                                    child: Image.network(ProductRegistrations[index].imageUral!=null?ProductRegistrations[index].imageUral![0]:"",),)
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
                                              child: Text(ProductRegistrations[index].productname!=null?ProductRegistrations[index].productname:"",
                                                  style: TextStyle(
                                                    fontSize:35 * MediaQuery.textScaleFactorOf(context),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(ProductRegistrations[index].price!=null?ProductRegistrations[index].price:"",
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

                          });}
                    },
                  ),
                ),
                SizedBox(height:MediaQuery.of(context).size.height*0.01,),
                Container(
                  width:MediaQuery.of(context).size.width/1.08,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('All Products',
                          style: TextStyle(
                            fontSize:50 * MediaQuery.textScaleFactorOf(context),
                            fontWeight: FontWeight.w700,
                          ),
                          textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => showAllProductSeller(ProductRegistrations:ProductRegistrationsaLL,ide: 10,)),
                          );
                        },
                        child: Row(
                          children: [
                            Text('Show all',
                                style: TextStyle(
                                  fontSize:30 * MediaQuery.textScaleFactorOf(context),
                                  fontWeight: FontWeight.w700,
                                ),
                                textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                            Icon(
                              Icons.navigate_next,
                              size:23 * MediaQuery.textScaleFactorOf(context),),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                        ProductRegistrationsaLL = _filterDataNot(snapshot.data!);
                        // ProductRegistrationsaLL = snapshot.data!.docs as List<ProductRegistration>;
                        return
                          ListView.builder(
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
                                       child: Image.network(ProductRegistrationsaLL[index].imageUral!=null?ProductRegistrationsaLL[index].imageUral![0]:"",),),
                                        SizedBox(width:MediaQuery.of(context).size.width*0.01,),
                                        Container(
                                          width:MediaQuery.of(context).size.width/3.1,
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(ProductRegistrationsaLL[index].productname!=null?ProductRegistrationsaLL[index].productname:"",
                                                  style: TextStyle(
                                                    fontSize:35 * MediaQuery.textScaleFactorOf(context),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  textScaleFactor: SizeConfig.textScaleFactor(context,0.7),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(ProductRegistrationsaLL[index].price!=null?ProductRegistrationsaLL[index].price:"",
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
