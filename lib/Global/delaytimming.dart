import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class delayTiming{
  static var First = 250;
  static var Second = 400;
  static var Third = 450;
  static var Fourth = 500;
  static var Fifth = 550;
  static var Sixth = 600;
  static var Seven = 650;
  static var Eight = 750;
  static var Nine = 800;
  static var Tenth = 850;
  offApplication(context){
    SystemNavigator.pop();
  }
  backPressed(context){
    Navigator.pop(context);
  }
  pushNewScreen(context,newscreen){
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: First),
        pageBuilder: (context, animation, secondaryAnimation) => newscreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }
  pushAndReplecemtNewScreen(context,newscreen){
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: First),
        pageBuilder: (context, animation, secondaryAnimation) => newscreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ).then((value) {
      if (value != null) {
        // Handle the result of the pop operation
      }
    });
  }
  checkandpush(context,screen) {
    // Check if the screen is already in the stack
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: First),
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
          (route) {
        // Check if the screen is already in the stack
        if (route.settings.name == screen) {
          SystemNavigator.pop();
          return true;
        }
        return false;
      },
    );
  }
}