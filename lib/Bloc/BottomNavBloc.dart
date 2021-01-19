import 'dart:async';

import 'package:news_app/InterFace/disposable.dart';

enum IteamBottomNav {Home , Exploer , Popular}

class BottomNavBloc implements disposable{
final StreamController<IteamBottomNav> _streamControllerTab = StreamController<IteamBottomNav>.broadcast();
IteamBottomNav defultIteam = IteamBottomNav.Home ;
Stream<IteamBottomNav> get IteamStream => _streamControllerTab.stream;

void chooseIteam (int i ){
 switch(i){
   case 0 :
     _streamControllerTab.sink.add(IteamBottomNav.Home);
     break ;
   case 1 :
     _streamControllerTab.sink.add(IteamBottomNav.Exploer);
     break ;
   case 2 :
     _streamControllerTab.sink.add(IteamBottomNav.Popular);
     break ;

 }

}

  @override
  void dispose() {
   _streamControllerTab.close();
  }

}