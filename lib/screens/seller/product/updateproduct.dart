import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tapnbuy/repositry/productregistration_reportry.dart';
import 'package:tapnbuy/src/models/productregistrationmodel.dart';
import 'package:tapnbuy/screens/responsive/text.dart';

import '../dashboard_screen.dart';
class updatepage extends StatefulWidget {
  dynamic products;
  Map<String, dynamic> ?productregistration;
  Map<String,dynamic>?product;
  updatepage({Key? key,this.products,this.product}) : super(key: key);

  @override
  State<updatepage> createState() => _updatepageState();
}



class _updatepageState extends State<updatepage> {
  void initState(){
    print(widget.product?[0]);
    print("widget.product?[0]");
    // TODO: implement initState
    super.initState();
    if( widget.productregistration!=null){
      widget.productregistration?["productname"]=productnameController.text;
      widget.productregistration?["category"]=categoryController.text;
      widget.productregistration?["noofproduct"]=numberOfProductController.text;
      widget.productregistration?["serisalnumber"]=serialNumberController.text;
      widget.productregistration?["company"]=companyController.text;
      widget.productregistration?["dispription"]=discriptionController.text;
      // widget.productregistration!["imageUral"]=imageUrl..text;
    }
    print( widget.products);

  }


  String? categoryCity;
  List<String> categoryList = <String>[
    "Beauty",
    "Personal care",
    "Sports items",
    "Clothing",
    "Electronic accessories",
    "accessories",
    "Kids & Pet items",
    "Women stuff",
    "Man stuff",
    "Video games",
  ];

  final productnameController=TextEditingController();
  final categoryController=TextEditingController();
  final numberOfProductController=TextEditingController();
  final serialNumberController=TextEditingController();
  final companyController=TextEditingController();
  final discriptionController=TextEditingController();
  // CollectionReference _reference=
  // FirebaseFirestore.instance.collection("image");
  String imageUrl='';
  List ids=[];
  final fireStore=FirebaseFirestore.instance.collection("productregistration").snapshots();
  CollectionReference ref=FirebaseFirestore.instance.collection('productregistration');

  createproduct(ProductRegistration puser,context) async{

    await productRepositry().createproduct(puser);
  }
  updated(ProductRegistration puser,context) async{


    await productRepositry().updated(puser,widget.products);

  }


  final int maxlength=150;
  final int maxline=1;
  File ?_image;
  final ImagePicker _pickerImage = ImagePicker();
  final List<File> multiimage=[];
  multiimagepiker() async {
    final List<XFile> pickImage = await _pickerImage.pickMultiImage();
    if(pickImage !=null){
      pickImage.forEach((e){
        multiimage.add(File(e.path));
        print(e.path);
      });
      setState(() {

      });
    }
  }
  final controller = MultiImagePickerController();
  final imagePiker=ImagePicker();
  getImage()async{
    // final image=await imagePiker.getImage(source: ImageSource.gallery);
    final ImagePicker _picker = ImagePicker();

    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    // final List<XFile>? images = await _picker.pickMultiImage();
    setState(() {
      _image= File(image!.path);
    });
    final _firebaseStorage = FirebaseStorage.instance;

    //Check Permissions

    if (_image != null){
      final filename = basename(_image!.path);
      final destination ="user photo/$filename";
      final file=File(_image!.path);
      final refs = FirebaseStorage.instance.ref().child(destination);
      UploadTask uploadTask = refs.putFile(file);
      imageUrl= await (await uploadTask).ref.getDownloadURL();
      //Upload to Firebase
      // var snapshot = await _firebaseStorage.ref()
      //     .child('images/')
      //     .putFile(_image!);
      // var downloadUrl = await snapshot.ref.getDownloadURL();
      // imageUrl= downloadUrl;
    } else {
      print('No Image Path Received');
    }
  }

  uploadImage() async {
    print(imageUrl);
  }

  @override

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Center(
                child: Container(
                  child: FittedBox(
                    child: Text('PRODUCT REGISTRATION',
                        style: TextStyle(
                          fontSize: 45* MediaQuery.textScaleFactorOf(context),
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                        textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                  ),
                ),
              ),
              SizedBox(height:MediaQuery.of(context).size.height*0.010,),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height/1.6,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          InkWell(
                              onTap: (){
                                getImage();
                              },
                              child: Text("upload")),
                          MultiImagePickerView(
                            controller: controller,
                            padding: const EdgeInsets.all(10),
                          ),
                          InkWell(
                              onTap:(){
                                controller;
                                // getImage();
                              },

                              child: Text("uploaded")),

                          SizedBox(height:MediaQuery.of(context).size.height*0.020,),
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
                              child: Row(
                                children: [

                                  Text('Product Name:',
                                      textDirection: TextDirection.ltr,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 33* MediaQuery.textScaleFactorOf(context),
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8,right: 8,),
                            child: Container(
                              height: MediaQuery.of(context).size.height*0.0800,
                              child: TextField(
                                controller: productnameController,

                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),),
                                textInputAction: TextInputAction.newline,
                                autofocus: true,
                                maxLength: maxlength,
                                minLines: maxline,
                                maxLines: 3, // Set this
                                keyboardType: TextInputType.multiline,

                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16,right: 16,bottom: 8),
                              child: Text('Category:',
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 33* MediaQuery.textScaleFactorOf(context),
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                            ),
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width*0.9,
                            child: DropdownButton<String>(
                              hint: const Text(
                                '',
                              ),
                              isExpanded: true,
                              value: categoryCity,
                              items: categoryList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    // controller: productnameController,
                                    value,
                                  ),

                                );
                              }).toList(),
                              onChanged: (_) {
                                FocusScope.of(context).requestFocus(FocusNode());
                                FocusScope.of(context).requestFocus(FocusNode());
                                setState(() {
                                  categoryController.text=categoryCity = _!;
                                });

                              },
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.02,),

                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16,right: 16,bottom: 8),
                              child: Text('Price Of Product:',
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 33* MediaQuery.textScaleFactorOf(context),
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8,right: 8,),
                            child: Container(
                              height: MediaQuery.of(context).size.height*0.0800,
                              child: TextField(
                                controller: numberOfProductController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),),
                                textInputAction: TextInputAction.newline,
                                autofocus: true,
                                maxLength: maxlength,
                                minLines: maxline,
                                maxLines: 3, // Set this
                                keyboardType: TextInputType.multiline,

                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black
                                ),
                              ),
                            ),
                          ),

                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16,right: 16,bottom: 8),
                              child: Text('Serial Number',
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 33* MediaQuery.textScaleFactorOf(context),
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8,right: 8,),
                            child: Container(
                              height: MediaQuery.of(context).size.height*0.0800,
                              child: TextField(
                                controller: serialNumberController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),),
                                textInputAction: TextInputAction.newline,
                                autofocus: true,
                                maxLength: maxlength,
                                minLines: maxline,
                                maxLines: 3, // Set this
                                keyboardType: TextInputType.multiline,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black
                                ),
                              ),
                            ),
                          ),
                          // SizedBox(height: 10),

                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16,right: 16,bottom: 8),
                              child: Text('Company',
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 33* MediaQuery.textScaleFactorOf(context),
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8,right: 8,),
                            child: Container(
                              height: MediaQuery.of(context).size.height*0.0800,
                              child: TextField(
                                controller: companyController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),),
                                textInputAction: TextInputAction.newline,
                                autofocus: true,
                                maxLength: maxlength,
                                minLines: maxline,
                                maxLines: 3, // Set this
                                keyboardType: TextInputType.multiline,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16,right: 16,bottom: 8),
                              child: Text('Description',
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 33* MediaQuery.textScaleFactorOf(context),
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8,right: 8,),
                            child: Container(
                              height: MediaQuery.of(context).size.height*0.0800,
                              child: TextField(
                                controller: discriptionController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),),
                                textInputAction: TextInputAction.newline,
                                autofocus: true,
                                maxLength: maxlength,
                                minLines: maxline,
                                maxLines: 3, // Set this
                                keyboardType: TextInputType.multiline,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height:MediaQuery.of(context).size.height*0.020,),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height:MediaQuery.of(context).size.height*0.040,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: InkWell(
                  onTap:() {

                    ProductRegistration pUser=ProductRegistration(
                      productname:productnameController.text.trim(),
                      category: categoryController.text.trim(),
                      serisalnumber:serialNumberController.text.trim(),
                      company:companyController.text.trim(),
                      price:numberOfProductController.text.trim(),
                      dispription: discriptionController.text.trim(),
                      // imageUrl: imageUrl,
                    );
                    // getImage();
                    // print(widget.products);
                    // var collect = FirebaseFirestore.instance.collection('ProductRegistration');
                    // collect
                    //     .doc('widget.products') // <-- Doc ID where data should be updated.
                    //     .update(pUser as Map<Object, Object?>);
                      updated(pUser,widget.products);

                      // createproduct(pUser,context);




                    //
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context) =>  dashboard_screen()
                    ),

                    );
                    // uploadImage();

                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 15,right: 15),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      //borderRadius: BorderRadius.circular(12),
                      //   border: Border.all(color: Colors.blue)
                    ),
                    child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                              'UpDated',
                              style:
                              TextStyle(color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 38* MediaQuery.textScaleFactorOf(context),
                              ),
                              textScaleFactor: SizeConfig.textScaleFactor(context,0.7)
                          ),
                        )),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
