import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'drawer.dart';
import '../main_dashboard.dart';
class drawer_backend extends StatefulWidget {
  const drawer_backend({Key? key}) : super(key: key);

  @override
  State<drawer_backend> createState() => _drawer_backendState();
}

class _drawer_backendState extends State<drawer_backend> {
  final zoomDrawerController=ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: zoomDrawerController,
      menuScreen: const drawer(),
      mainScreen: const main_dashboard(),
      showShadow: true,
    );
  }
}
