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
import 'package:tapnbuy/screens/global/function.dart';
import 'package:tapnbuy/src/models/productregistrationmodel.dart';
import 'package:tapnbuy/screens/responsive/text.dart';
import '../../../Global/snackBar.dart';
import '../../../firebase/authaction.dart';
import '../dashboard_screen.dart';
class product_page extends StatefulWidget {
  dynamic idDocument;
  dynamic productregistration;
  dynamic heading;
  dynamic button;
  product_page({Key? key,this.idDocument,this.productregistration,this.heading,this.button}) : super(key: key);

  @override
  State<product_page> createState() => _product_pageState();
}


class _product_pageState extends State<product_page> {
  List<String> imagePaths = [];
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
  List<String> imageUrls=[];
  final productnameController=TextEditingController();
  final categoryController=TextEditingController();
  final numberOfProductController=TextEditingController();
  final serialNumberController=TextEditingController();
  final companyController=TextEditingController();
  final discriptionController=TextEditingController();
  updated(ProductRegistration puser,context) async{
    await productRepositry().updated(puser,widget.idDocument);
  }
  final int maxlength=150;
  final int maxline=1;
  final controller = MultiImagePickerController();
  bool loading=false;
  bool ?view;
  @override
  void initState() {
    widget.heading=="View Product"?
    view=false:true;
      if( widget.productregistration!=null){
    productnameController.text= widget.productregistration!.productname;
    categoryController.text= widget.productregistration!.category;
    categoryCity=widget.productregistration!.category;
    numberOfProductController.text=widget.productregistration!.price;
    serialNumberController.text=widget.productregistration!.serisalnumber;
    companyController.text= widget.productregistration!.company;
    discriptionController.text=  widget.productregistration!.dispription;
    int legth=widget.productregistration!.imageUral!.length;
    print("objecdsfljsd;lfjt");
    print(legth);
    for (String imagePath in widget.productregistration!.imageUral!) {
      ImageFile imageFile = ImageFile(imagePath, name: '', extension: '');
      imageUrls?.add(imagePath);
    }
      print(controller);
      }
    // TODO: implement initState
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Center(
                child: Container(
                  child: FittedBox(
                    child: Text(widget.heading,
                      style: TextStyle(
                        fontSize: 45* MediaQuery.textScaleFactorOf(context),
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                        textScaleFactor: SizeConfig.textScaleFactor(context,0.7)),
                  ),
                ),
              ),
              SizedBox(height:MediaQuery.of(context).size.height*0.01,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
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
                                readOnly: widget.button==""?true:false,
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
                         widget.button!=""?
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.93,
                              child: DropdownButton<String>(
                                underline: SizedBox(),
                                hint: const Text(
                                  '',
                                ),
                                isExpanded: true,
                                value: categoryCity,
                                items: categoryList.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                      child: Text(
                                        value,
                                      ),
                                  );
                                }).toList(),
                                onChanged: (_) {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  setState(() {
                                    categoryController.text=categoryCity = _!;
                                  });

                                },
                              ),
                            ),
                          ):SizedBox(),
                          Container(
                              width: MediaQuery.of(context).size.width*0.9,
                              child: Divider(thickness: 1.2,)),
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
                                readOnly: widget.button==""?true:false,
                                controller: numberOfProductController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),),
                                textInputAction: TextInputAction.newline,
                                autofocus: true,
                                maxLength: maxlength,
                                minLines: maxline,
                                maxLines: 3, // Set this
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
                                readOnly: widget.button==""?true:false,
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
                                readOnly: widget.button==""?true:false,
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
                                readOnly: widget.button==""?true:false,
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
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Wrap(
                              spacing: 8.0, // Adjust the spacing between images
                              runSpacing: 8.0, // Adjust the spacing between rows of images
                              children: imageUrls.map((imageUrl) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      imageUrls!.remove(imageUrl);
                                    });
                                  },
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        imageUrl,
                                        width: 80,
                                        height: 70,
                                      ),
                                      Positioned(
                                        top: 4,
                                        right: 4,
                                        child: Icon(
                                          Icons.cancel_outlined,
                                          color: Colors.black,
                                          size: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          MultiImagePickerView(
                            controller: controller,
                            padding: const EdgeInsets.all(10),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height:MediaQuery.of(context).size.height*0.040,),
             widget.button!=""? loading==true? loaderDesign(context):
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: InkWell(
                  onTap:() async {
                    if(productnameController.text==null||productnameController.text=="null"||productnameController.text==""){
                      redGlobalSnackBar(
                          "Empty Product Name Invalid!");
                    }
                    else if(categoryController.text==null||categoryController.text=="null"||categoryController.text==""){
                      redGlobalSnackBar(
                          "Empty Category Invalid!");
                    }
                    else if(numberOfProductController.text==null||numberOfProductController.text=="null"||numberOfProductController.text==""){
                      redGlobalSnackBar(
                          "Empty Price Of Product Invalid!");
                    }
                    else if(serialNumberController.text==null||serialNumberController.text=="null"||serialNumberController.text==""){
                      redGlobalSnackBar(
                          "Empty Serial Number Invalid!");
                    }
                    else if(companyController.text==null||companyController.text=="null"||companyController.text==""){
                      redGlobalSnackBar(
                          "Empty Company Invalid!");
                    }
                    else if(discriptionController.text==null||discriptionController.text=="null"||discriptionController.text==""){
                      redGlobalSnackBar(
                          "Empty Discription Invalid!");
                    }  else if(controller.images.length<1&&imageUrls.length<1){
                      redGlobalSnackBar(
                          "Empty Images not Valid!");
                    }
                    else{
                    setState(() {
                      loading=true;
                    });
                    imagePaths.clear();
                    for (ImageFile imageFile in controller.images) {
                      String? path = imageFile.path;
                      imagePaths.add(path!);
                    }
                    List<String> downloadPath = [];
                    print(imagePaths.length);
                    for(int i=0;i<imagePaths.length;i++){
                      downloadPath.add(await authaction().uploadImage(File(imagePaths[i])));
                    }
                    for(int i=0;i<imageUrls.length;i++){
                      downloadPath.add(imageUrls[i]);
                    }
                    print("fsghjsghd");
                    print(downloadPath.length);
                    ProductRegistration pUser=ProductRegistration(
                      productname:productnameController.text.trim(),
                      category: categoryController.text.trim(),
                      serisalnumber:serialNumberController.text.trim(),
                      company:companyController.text.trim(),
                      price:numberOfProductController.text.trim(),
                      dispription: discriptionController.text.trim(),
                      imageUral: downloadPath,
                    );
                    widget.heading=="Edit Product"?
                    await productRepositry().updated(pUser,widget.idDocument):
                    await productRepositry().createproduct(pUser);
                    Future.delayed(Duration(milliseconds: 400), () {
                      setState(() {
                        loading=false;
                      });// Close the snack bar after 3 seconds
                    });
                    Navigator.pop(context);
                    }
                      // createproduct(pUser,context);
                    //   Navigator.push(
                    // context, MaterialPageRoute(builder: (context) =>  dashboard_screen()
                    // ),
                    // );
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
                              widget.button,
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
              ):SizedBox(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
