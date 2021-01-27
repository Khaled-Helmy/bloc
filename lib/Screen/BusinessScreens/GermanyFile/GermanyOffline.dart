import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'Germany.dart';
import 'file:///G:/Flutter%20Projects/news_app/lib/Screen/ArticlesScreens/BitCone/BitConeScreen.dart';


class GermanyOffline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(backgroundColor: Colors.red.shade900,),
      body:new OfflineBuilder(
        connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
            ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return new Stack(
            fit: StackFit.expand,
            children: [
              connected ?
              GermanyNewsScreen():
              new Center(child: Text("You are Offline please check your Internet Connection" ,
                style:  TextStyle(color:  Colors.red.shade900 , fontSize: 18 , fontWeight: FontWeight.bold ),textAlign: TextAlign.center,),),
              Positioned(
                height: 24.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  color: connected ? null : Colors.red.shade900,
                  child: Center(
                    child: Text("${connected ? null : 'OFFLINE'}"
                      , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            ],
          );
        },
        child: Column(
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
    );
  }




}
