import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tapnbuy/Global/constant.dart';

redGlobalSnackBar(text){
  Get.rawSnackbar(
      message:
      text,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red// Optional: Set the snack position (default: SnackPosition.BOTTOM)
  );
  Future.delayed(Duration(milliseconds: 1200), () {
    print("nsdkfnsd");
    Get.back(); // Close the snack bar after 3 seconds
  });
}
GlobalSnackBar(text){
  Get.rawSnackbar(
    message:
    text,
    snackPosition: SnackPosition.TOP,
    backgroundColor: constant.secondaryButton,// Optional: Set the snack position (default: SnackPosition.BOTTOM)
  );
  Future.delayed(Duration(milliseconds: 1000), () {
    Get.back(); // Close the snack bar after 3 seconds
  });
}
loaderDesign(context){
  return
  SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? constant.secondaryButton :constant.primary,
        ),
      );
    },
  );
}