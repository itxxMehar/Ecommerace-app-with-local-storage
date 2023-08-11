import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:tapnbuy/firebase/authactions.dart';
import 'package:tapnbuy/src/addtocardcostomer.dart';
import 'package:tapnbuy/screens/responsive/text.dart';
import 'package:tapnbuy/screens/seller/product/updateproduct.dart';
import '../../Global/snackBar.dart';
import '../../src/models/productregistrationmodel.dart';
import '../seller/product/showAllProductSeller.dart';
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
  SpeechToText _speechToText = SpeechToText();
  final FocusNode focusNode = FocusNode();
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
  TextEditingController _textEditingController=TextEditingController();
  bool switchs=false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String id='';
  bool click=true;
  int ?a;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  List _product=[];
  List va=[];
  String p='' ;
  List <ProductRegistration> ProductRegistrationsNewArrival= [];
  List <ProductRegistration> ProductRegistrationsAllSeller= [];
  List<String> PostId=[];
  fetchProduct()async{
    DateTime lastWeek = DateTime.now().subtract(Duration(days: 7));
    var data = await FirebaseFirestore.instance.collection("ProductRegistration").where('timeStamp', isGreaterThanOrEqualTo: lastWeek)
         .get();
    setState(() {
        for(int i=0;i<data.docs.length;i++){
          setState(() {
            ProductRegistrationsNewArrival.add(ProductRegistration.fromJson(data.docs[i].data()));
          });
        }
        for (var snapshot in data.docs) {
          // documentID = snapshot.id;
          PostId.add(snapshot.id);
        }
      });
  }
  bool progreess=false;
  int ?inde;
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
  @override
  void initState(){
    _initSpeech();
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
                  suffixIcon: InkWell(
                      onTap: (){
                        _speechToText.isNotListening ? _startListening (): _stopListening();},
                      child: Icon(Icons.mic,color: Colors.black,)),
                ),
                autofocus:true
            ),
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
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    child: Text(
                                      'Sales Up',
                                      style: TextStyle(color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize:25),
                                      // textScaleFactor: SizeConfig.textScaleFactor(context,0.7),
                                    ),
                                  ),
                                  Container(
                                    // color: Colors.red,
                                    child: Text(
                                      'To 70% Off',
                                      style: TextStyle(color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 55 * MediaQuery.textScaleFactorOf(context)),
                                      textScaleFactor: SizeConfig.textScaleFactor(context,0.7),
                                    ),
                                  ),
                                ],
                              ),
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
                          InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => showAllProductSeller(ProductRegistrations:ProductRegistrationsNewArrival,ide: 0,)),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text('Show all',
                                style: TextStyle(
                                  fontSize: 30 * MediaQuery.textScaleFactorOf(context),
                                  fontWeight: FontWeight.w700,
                                ),
                                textScaleFactor: SizeConfig.textScaleFactor(context,0.7),
                              ),
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
                      itemCount: ProductRegistrationsNewArrival.length,
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
                                                  // height: MediaQuery.of(context).size.height/7,
                                                  width: MediaQuery.of(context).size.width/3.1,
                                                  child: Image.network(ProductRegistrationsNewArrival[index].imageUral[0]),)

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
                                          child: Text('${ProductRegistrationsNewArrival[index].productname}',
                                              style: TextStyle(
                                                fontSize:30 * MediaQuery.textScaleFactorOf(context),
                                                fontWeight: FontWeight.w700,
                                              ),
                                              textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('${ProductRegistrationsNewArrival[index].price.toString()}',
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
                          InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => showAllProductSeller(ProductRegistrations:ProductRegistrationsNewArrival,ide: 0,)),
                                );
                              },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text('Show all',
                                style: TextStyle(
                                  fontSize: 30 * MediaQuery.textScaleFactorOf(context),
                                  fontWeight: FontWeight.w700,
                                ),
                                textScaleFactor: SizeConfig.textScaleFactor(context,0.7),),
                            ),
                          ),
                          Icon(
                            Icons.navigate_next,
                            size: 22 * MediaQuery.textScaleFactorOf(context),),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              Expanded(
                child: Container(
                    // height: MediaQuery.of(context).size.height/4.3,
                    width:MediaQuery.of(context).size.width/1.075,
                    color: Colors.white,
                    child: MediaQuery.removePadding(
                      context: context,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,

                          itemCount: ProductRegistrationsNewArrival.length,
                          itemBuilder: (_,index) {

                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width:MediaQuery.of(context).size.width*0.01,),
                                        Container(


                                          height: MediaQuery.of(context).size.height/9.0,
                                          width: MediaQuery.of(context).size.width/4.5,
                                          child: Image.network(ProductRegistrationsNewArrival[index].imageUral[0]
                                          ),

                                        ),
                                        SizedBox(width:MediaQuery.of(context).size.width*0.01,),

                                        Container(
                                          child: Column(

                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text('${ProductRegistrationsNewArrival[index].productname}',
                                                  style: TextStyle(
                                                    fontSize:35 * MediaQuery.textScaleFactorOf(context),
                                                    fontWeight: FontWeight.w700,
                                                  ),

                                                  textScaleFactor: SizeConfig.textScaleFactor(context,0.7),

                                                ),

                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text('${ProductRegistrationsNewArrival[index].price.toString()}',
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
                                      ],
                                    ),
                                    Row(
                                      children: [
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
                                              MaterialPageRoute(builder: (context) => add_to_card(ProductRegistrations: ProductRegistrationsNewArrival[index],ProductRegistrationsNewArrival: ProductRegistrationsNewArrival
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
                                        progreess==true&&index==inde? Container(
                                          width:12,
                                            height:12,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.0,
                                            )):
                                        InkWell (

                                          onTap:() async {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(builder: (context) => addtocardcustomer()),
                                            // );
                                            setState(() {
                                              progreess=true;
                                              inde=index;
                                            });
                                            DateTime lastWeek = DateTime.now().subtract(Duration(days: 7));
                                            var data = await FirebaseFirestore.instance.collection("ProductRegistration").where('timeStamp', isGreaterThanOrEqualTo: lastWeek)
                                                .get();
                                              for (var snapshot in data.docs) {
                                                // documentID = snapshot.id;
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
                                    )
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
          )
        ),
      ),
    );
  }
}
