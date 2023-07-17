import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:tapnbuy/screens/authaction/login_tnb.dart';
import 'package:tapnbuy/screens/authaction/signUp.dart';

import 'Global/delaytimming.dart';
class slider extends StatefulWidget {
  const slider({Key? key}) : super(key: key);

  @override
  State<slider> createState() => _sliderState();
}

class _sliderState extends State<slider> {
  @override
  void initState() {

    // TODO: implement initState
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
              ElevatedButton(onPressed: ()=>delayTiming().offApplication(context), child: const Text('Exit')
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
      child: CupertinoApp(
        debugShowCheckedModeBanner: false,
        home: OnBoardingSlider(
          headerBackgroundColor: Colors.white,

          finishButtonText: 'Register',
          onFinish: () {
            delayTiming()
                .pushNewScreen(context, signUp());
          },
          skipTextButton: Text('Skip',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black
          ),),
          trailing: InkWell(
            onTap: (){
              delayTiming()
                  .pushAndReplecemtNewScreen(context, login_tnb());
            },
              child: Text('Login',
              style: TextStyle(
                  fontSize: 16,
                color: Colors.black
              ),)),
          background: [
             Container(
              // color: Colors.red,
               height: MediaQuery.of(context).size.height,
                 width: MediaQuery.of(context).size.width,
                 child: Image.asset('assets/images/download (2).jpg',
                   scale: 0.1,
                   height: MediaQuery.of(context).size.height,
                   width: MediaQuery.of(context).size.width,
                 )
             ),
            Container(
              // color: Colors.grey,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.asset('assets/images/logoa.png',
                  scale: 0.1,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,)),
          ],
          totalPage: 2,
          speed: 1.8,
          pageBodies: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 1),
              child: Column(
                children: <Widget>[
                  // SizedBox(
                  //   //height: 480,
                  // ),
                 // Text('Description Text 1'),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: <Widget>[
                  // SizedBox(
                  //   height: 480,
                  // ),
                 // Text('Description Text 2'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
