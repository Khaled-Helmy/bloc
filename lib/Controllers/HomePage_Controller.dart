import 'package:flutter/material.dart';

class HomePageController {
  List<Tab> _myTabs = <Tab>[
    Tab(text: "Home", icon: Icon(Icons.account_balance)),
    Tab(text: "Exploer", icon: Icon(Icons.ac_unit),),
    Tab(text: "Popular", icon: Icon(Icons.list)),];

  List<Tab> listTab (){
    return _myTabs;
  }

}