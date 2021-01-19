import 'package:flutter/material.dart';
import 'package:news_app/Controllers/HomePage_Controller.dart';
import 'package:news_app/Screen/SearchScreen.dart';
import 'file:///G:/Flutter%20Projects/news_app/lib/Models/PopUpMenu_Model.dart';
import 'package:news_app/Screen/TabScreens/Exploer.dart';
import 'package:news_app/Screen/TabScreens/Popular.dart';
import 'package:news_app/Screen/TabScreens/Home.dart';
import 'package:news_app/SharedUi/NavigationDarwer.dart';

class HomePage extends StatefulWidget  {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  TabController _tabController ;
  List<Tab> _myTabs = HomePageController().listTab();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0,length: _myTabs.length, vsync: this);
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: build_appBar(),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            Home(),
            Exploer(),
            Popular(),
          ],
        ),
      ),
      drawer: NavigationDarwer(),
    );
  }
  Widget build_appBar (){
    return AppBar(
      backgroundColor: Colors.red.shade900,
      title:TitleAppBar() ,
      centerTitle: false,
      actions: [
        IconButton(icon: Icon(Icons.search), onPressed: (){
          Future.delayed(Duration.zero , (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen()));
          });

        }),
        PopupMenu(),

      ],
      bottom: TabBar(
        indicatorColor: Colors.white,
        tabs:_myTabs,
        controller: _tabController,
      ),

    );
  }
Widget TitleAppBar (){
  return Container(
    child: Row(
      children: [
        const Text("H" , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 32),),
        const Text("ome" , style: TextStyle(color: Colors.grey , fontWeight: FontWeight.bold , fontSize: 32),),
        const SizedBox(width: 5,),
        const Text("N",style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold , fontSize: 32),),
        const Text("ews",style: TextStyle(color: Colors.grey , fontWeight: FontWeight.bold , fontSize: 32),),

      ],),
  );
}
}



