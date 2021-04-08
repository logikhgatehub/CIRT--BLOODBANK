import 'package:blood_donor/Application/router_constants.dart';
import 'package:blood_donor/Presentation/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ZRouter {
    static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      //for the home page
      case homeRoute:
        return CupertinoPageRoute(builder: (_) => Home());
      default:
        return CupertinoPageRoute(builder: (_) => Container());
    }
  }
}
