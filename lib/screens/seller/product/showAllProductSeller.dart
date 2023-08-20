
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:tapnbuy/screens/seller/drawer/seller_dashboard_drawer.dart';
import 'package:tapnbuy/screens/responsive/text.dart';
import 'package:tapnbuy/screens/seller/product/updateproduct.dart';

import '../../../firebase/authactions.dart';
import '../../../src/addtocardcostomer.dart';
import '../../../src/models/productregistrationmodel.dart';
import '../../buyer/add_to_card.dart';
import '../../buyer/drawer/drawer.dart';
import '../dashboard_screen.dart';
class showAllProductSeller extends StatefulWidget {
  int ?ide;
  List <ProductRegistration>? ProductRegistrations= [];
   showAllProductSeller({super.key, this.ProductRegistrations,this.ide});

  @override
  State<showAllProductSeller> createState() => _showAllProductSellerState();
}

class _showAllProductSellerState extends State<showAllProductSeller> {
  String id='';
  bool progreess=false;
  int ?inde;
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
      ProductRegistrations?.clear();
      changeSearchValue(_textEditingController.text);
      _textEditingController.addListener(_onTextChanged);
    });
  }
  changeSearchValue(text) async {
    print(widget.ProductRegistrations?.length);
    List <ProductRegistration>? ProductRegistrationss= [];
    for(int i=0;i<widget.ProductRegistrations!.length;i++){
       if(widget.ProductRegistrations![i].productname.contains(text)){
         ProductRegistrationss?.add(widget.ProductRegistrations![i]);
       }
    }
    setState(() {
      ProductRegistrations=ProductRegistrationss!=null?ProductRegistrationss:[];
    });
    print(ProductRegistrations?.length);
    print("ProductRegistrations?.length");
  }
  final FocusNode focusNode = FocusNode();
  TextEditingController _textEditingController=TextEditingController();
  bool switchs=false;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  List <ProductRegistration>? ProductRegistrations= [];
  @override
  void initState(){
    // updated();
    _initSpeech();
   setState(() {
     ProductRegistrations=widget.ProductRegistrations!=null?widget.ProductRegistrations:[];
   });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      resizeToAvoidBottomInset: false,
      appBar: switchs==true? AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Flexible(
              child: TextField(
                  focusNode: focusNode,
                  onChanged: (text){
                    // texts=text.toString().trim().toLowerCase();
                    setState(() {
                      // ProductRegistrations?.clear();
                      print(widget.ProductRegistrations?.length);
                      changeSearchValue(text);
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
          widget.ide!=10?
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 16),
            child: InkWell
              (onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => addtocardcustomer()),
              );
            },
                child: Icon(Icons.shopping_bag_outlined,color: Colors.black,)),
          ):SizedBox()
        ],
      ),
      drawer: Drawer(
        child: widget.ide==10?seller_dashboard_drawer():drawer(),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height:MediaQuery.of(context).size.height*0.02,),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('All Products',
                    style: TextStyle(
                      fontSize:50 * MediaQuery.textScaleFactorOf(context),
                      fontWeight: FontWeight.w700,
                    ),
                    textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
              ),
            ),
            SizedBox(height:MediaQuery.of(context).size.height*0.03,),
            Expanded(
              child: Container(
                  // height: MediaQuery.of(context).size.height/1.28,
                  width:MediaQuery.of(context).size.width/1.075,
                  color: Colors.white,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,

                      itemCount: ProductRegistrations?.length,
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
                                     child: Image.network(ProductRegistrations?[index].imageUral!=null?ProductRegistrations![index].imageUral![0]:"",
                                     ),

                                   ),
                                   SizedBox(width:MediaQuery.of(context).size.width*0.01,),

                                   Container(
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Align(
                                           alignment: Alignment.topLeft,
                                           child: Text(ProductRegistrations?[index].productname!=null?ProductRegistrations![index].productname:"",
                                             style: TextStyle(
                                               fontSize:35 * MediaQuery.textScaleFactorOf(context),
                                               fontWeight: FontWeight.w700,
                                             ),

                                             textScaleFactor: SizeConfig.textScaleFactor(context,0.7),

                                           ),

                                         ),
                                         Align(
                                           alignment: Alignment.topLeft,
                                           child: Text(ProductRegistrations?[index].price!=null?ProductRegistrations![index].price:"",
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
                                widget.ide==null?
                               Row(
                                 children: [
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
                                         MaterialPageRoute(builder: (context) => add_to_card(ProductRegistrations: ProductRegistrations![index],ProductRegistrationsNewArrival: widget.ProductRegistrations
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
                               )
                                    :SizedBox()
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

          ],

        ),
      ),
    );
  }
}
