import 'package:flutter/material.dart';


  Widget InitialStateScreen (){
    return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red.shade900),),);
  }

  Widget LoadingStateScreen (){
    return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red.shade900),),);
  }

Widget LoadingIteamScreen (){
  return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red.shade900),),);
}




