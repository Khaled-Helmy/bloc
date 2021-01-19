import 'package:news_app/Models/FavoriteModel.dart';

enum EventType {add , remove}

class FavoriteEvents {
  FavoriteModel Favorite ;
  int Index ;
  EventType eventType;

  FavoriteEvents.add(FavoriteModel Favorite){
    this.eventType = EventType.add ;
    this.Favorite = Favorite;
  }
  FavoriteEvents.remove(int index){
    this.eventType = EventType.remove;
    this.Index = index ;
  }
}



