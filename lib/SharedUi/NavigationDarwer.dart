import 'package:flutter/material.dart';
import 'package:news_app/Screen/ArticlesScreens/BitConeScreen.dart';
import 'package:news_app/Screen/ArticlesScreens/NewsScreen.dart';
import 'package:news_app/Screen/ArticlesScreens/WebSiteScreen.dart';
import 'package:news_app/Screen/BusinessScreens/Germany.dart';
import 'package:news_app/Screen/BusinessScreens/US.dart';
import 'package:news_app/Screen/ChannelScreens/BBCNews.dart';
import 'package:news_app/Screen/Favorite.dart';
import 'package:news_app/Screen/HelpPage.dart';
import 'package:news_app/Screen/HomePage.dart';
import 'package:news_app/Screen/PotiticalFiguarScreens/TrumpScreen.dart';
import 'package:news_app/Screen/Setting.dart';
class NavigationDarwer extends StatefulWidget {

  @override
  _NavigationDarwerState createState() => _NavigationDarwerState();
}

class _NavigationDarwerState extends State<NavigationDarwer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
    child: Container(
      color: Colors.white,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/background.jpg"),fit: BoxFit.cover)
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white ,
                    Colors.transparent
                  ] ,
                  stops: [
                    0.1 ,
                    0.9,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 15 , left: 15 , right: 20 ),),
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 16 , right: 16 , top: 14 , bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Home" , style: TextStyle(fontWeight: FontWeight.bold),)
                  ,Icon(Icons.home , color: Colors.red.shade900,)
                ],
              ),
            ),
            onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage())),
          ),
          Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.red.shade900
                , unselectedWidgetColor: Colors.black),
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: <Widget>[
                ExpansionTile(
                  title: Text("Articles" , style: TextStyle(fontWeight: FontWeight.bold),),
                  children: <Widget>[
                    GestureDetector(
                      onTap:()=>  Navigator.push(context, MaterialPageRoute(builder: (context)=> BitConeScreen())),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10 , right: 10 , bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("BitCone" , style: TextStyle(fontWeight: FontWeight.w600),)
                            ,Icon(Icons.money , color: Colors.green,)
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> NewsScreen())),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10 , right: 10 , bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("News" , style: TextStyle(fontWeight: FontWeight.w600),)
                            ,Icon(Icons.new_releases , color: Colors.deepOrange,)
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> WebSiteScreen())),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10 , right: 10 , bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("WebSite" , style: TextStyle(fontWeight: FontWeight.w600),)
                            ,Icon(Icons.web , color: Colors.red.shade900,)
                          ],
                        ),
                      ),
                    ),],
                )
              ],
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.red.shade900
                , unselectedWidgetColor: Colors.black),
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: <Widget>[
                ExpansionTile(
                  title: Text("Channel" , style: TextStyle(fontWeight: FontWeight.bold),),
                  children: <Widget>[
                    GestureDetector(
                      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> BbcNewsScreen())),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10 , right: 10 , bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("BBC NEWS" , style: TextStyle(fontWeight: FontWeight.w600),)
                            ,Icon(Icons.tv_outlined , color: Colors.red.shade900,)
                          ],
                        ),
                      ),
                    ),],
                )
              ],
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.red.shade900
                , unselectedWidgetColor: Colors.black),
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: <Widget>[
                ExpansionTile(
                  title: Text("Potitical Figuar" , style: TextStyle(fontWeight: FontWeight.bold),),
                  children: <Widget>[
                    GestureDetector(
                      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> TrumpScreen())),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10 , right: 10 , bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Trump" , style: TextStyle(fontWeight: FontWeight.w600),)
                            ,Icon(Icons.person , color: Colors.black,)
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.red.shade900
                , unselectedWidgetColor: Colors.black),
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: <Widget>[
                ExpansionTile(
                  title: Text("Business" , style: TextStyle(fontWeight: FontWeight.bold),),
                  children: <Widget>[
                    GestureDetector(
                      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> USNewsScreen())),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10 , right: 10 , bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("US" , style: TextStyle(fontWeight: FontWeight.w600),)
                            ,Icon(Icons.flag , color: Colors.blue,)
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> GermanyNewsScreen())),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10 , right: 10 , bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Germany" , style: TextStyle(fontWeight: FontWeight.w600),)
                            ,Icon(Icons.flag , color: Colors.deepOrange,)
                          ],
                        ),
                      ),
                    ),
                   ],
                )
              ],
            ),
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 16 , right: 16 , top: 14 , bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Setting" , style: TextStyle(fontWeight: FontWeight.bold),)
                  ,Icon(Icons.settings , color: Colors.red.shade900,)
                ],
              ),
            ),
            onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> Setting())),
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 16 , right: 16 , top: 14 , bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Help" , style: TextStyle(fontWeight: FontWeight.bold),)
                  ,Icon(Icons.help , color: Colors.red.shade900,)
                ],
              ),
            ),
            onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> HelpPage())),
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 16 , right: 16 , top: 14 , bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Favorite" , style: TextStyle(fontWeight: FontWeight.bold),)
                  ,Icon(Icons.favorite , color: Colors.red.shade900,)
                ],
              ),
            ),
            onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> Favorite())),
          ),
        ],
      ),
    ),
    );
  }
}
