import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:news_app/Models/FavoriteModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'FavoriteEvents.dart';

class FavoriteBloc extends Bloc<FavoriteEvents , List<FavoriteModel>>{
  FavoriteBloc({List<FavoriteModel> initialState = const []}) : super(initialState);

  @override
  Stream<List<FavoriteModel>> mapEventToState(FavoriteEvents event) async*{
  switch(event.eventType){
    case EventType.add:
     if(event.Favorite != null){
       List<FavoriteModel> addState = new List.from(state);
       addState.add(event.Favorite);
    yield addState;
     }
    break ;
    case EventType.remove:
      List<FavoriteModel> removeState =new List.from(state);
      removeState.removeAt(event.Index);

    yield removeState ;
    break;

  }

  }
  
}