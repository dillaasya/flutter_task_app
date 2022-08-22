import 'package:flutter/material.dart';
import 'package:flutter_task_app/screens/bottom_navbar_screen.dart';
import 'package:flutter_task_app/screens/recycle_bin_screen.dart';


class AppRouter{
  Route? onGenerateRoute(RouteSettings routeSettings){
    switch (routeSettings.name) {
      case RecycleBinScreen.id :
        return MaterialPageRoute(builder: (_)=> const RecycleBinScreen());
      case BottomNavbarScreen.id :
        return MaterialPageRoute(builder: (_)=> const BottomNavbarScreen());
      
    }
    return null;
  }
}