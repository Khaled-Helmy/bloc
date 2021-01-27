import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:news_app/Controllers/HomePage_Controller.dart';
import 'package:news_app/Models/PopUpMenu_Model.dart';
import 'package:news_app/Screen/SearchScreen.dart';
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
    return new Scaffold(
      appBar: build_appBar(),
      body: new OfflineBuilder(
        connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
            ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return new Stack(
            fit: StackFit.expand,
            children: [
              connected ? new SafeArea(
          child: new TabBarView(
          controller: _tabController,
            children: [
               Home(),
              Exploer(),
              Popular(),
            ],
          ),
          ) :
              new Center(child: Text("You are Offline please check your Internet Connection" ,
                style:  TextStyle(color:  Colors.red.shade900 , fontSize: 18 , fontWeight: FontWeight.bold ),textAlign: TextAlign.center,),),
             new Positioned(
                height: 24.0,
                left: 0.0,
                right: 0.0,
                child: new Container(
                  color: connected ? null : Colors.red.shade900,
                  child: new Center(
                    child: new Text("${connected ? " ": 'OFFLINE'}"
                      , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            ],
          );
        },
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'There are no bottons to push :)',
            ),
            new Text(
              'Just turn off your internet.',
            ),
          ],
        ),
      ),

      drawer: new NavigationDarwer(),
    );
  }
  Widget build_appBar (){
    return new AppBar(
      backgroundColor: Colors.red.shade900,
      title:TitleAppBar() ,
      centerTitle: false,
      actions: [
        new IconButton(icon: Icon(Icons.search), onPressed: (){
          Future.delayed(Duration.zero , (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen()));
          });

        }),
        new PopupMenu(),

      ],
      bottom: new TabBar(
        indicatorColor: Colors.white,
        tabs:_myTabs,
        controller: _tabController,
      ),

    );
  }
Widget TitleAppBar (){
  return new Container(
    child: new Row(
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





