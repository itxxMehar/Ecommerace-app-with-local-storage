import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:tapnbuy/screens/seller/drawer/seller_dashboard_drawer.dart';

import '../dashboard_screen.dart';
class dashboard_drawer_backend extends StatefulWidget {
  const dashboard_drawer_backend({Key? key}) : super(key: key);
  @override
  State<dashboard_drawer_backend> createState() => _dashboard_drawer_backendState();
}
class _dashboard_drawer_backendState extends State<dashboard_drawer_backend> {
  final zoomDrawerController=ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: zoomDrawerController,
      menuScreen: const seller_dashboard_drawer(),
      mainScreen:  dashboard_screen(),
      showShadow: true,
    );
  }
}
