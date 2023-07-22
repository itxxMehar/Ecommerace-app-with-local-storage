import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapnbuy/screens/buyer/main_dashboard.dart';
import 'package:tapnbuy/screens/buyer/sellerdashboared.dart';
import 'package:tapnbuy/screens/seller/dashboard_screen.dart';
import 'package:tapnbuy/slider.dart';

import 'Global/delaytimming.dart';
import 'Global/sharedPrefrences.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> with TickerProviderStateMixin {
  Tween<double>? _tweenSize;
  Animation<double>? _animationSize;
  AnimationController? _animationController;
  // final LocalAuthentication auth = LocalAuthentication();
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: delayTiming.Third));
    _tweenSize = Tween(begin: 20, end: 330);
    _animationSize = _tweenSize?.animate(_animationController!);
    _animationController!.forward();
    checkScreen();
    super.initState();
  }
  checkScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    var loged = await sharedPrefrences().getval("login");
    if(loged=="1"){
      Timer(
        Duration(seconds: 5),
          // sellerDashboared
            () => delayTiming().pushAndReplecemtNewScreen(context, sellerDashboared()),
      );
    }
    else if(loged=="0")
    {
      Timer(
        Duration(seconds: 5),
            () => delayTiming().pushAndReplecemtNewScreen(context, main_dashboard()),
      );
    }
    else{
      // if (_seen == false) {
        Timer(
          Duration(seconds: 5),
              () => delayTiming().pushAndReplecemtNewScreen(context, slider()),
        );

      // } else {
      //   Timer(
      //     Duration(seconds: 5),
      //         () => delayTiming().pushAndReplecemtNewScreen(context, seletctedItem()),
      //   );
      // }
    }
  }
  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        delayTiming().offApplication(context);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Color(0xffDAD7D7),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // decoration: BoxDecoration(
          //   color: global.splashBackGround,
          // ),
          child: Center(
            child: AnimatedBuilder(
                animation: _animationSize!,
                builder: (context, child) {
                  // Put your image here and replace height, width of image with _animationSize.value
                  return Container(
                    // color: Colors.red,
                    height: _animationSize!.value,
                    width: _animationSize!.value,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Image.asset("assets/images/logod.png"),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}