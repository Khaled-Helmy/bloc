import 'package:equatable/equatable.dart';
import 'package:news_app/Models/ArticelsModel.dart';
import 'package:news_app/Models/ArticleResponse.dart';
import 'package:news_app/Models/BaseNews.dart';


class StatesUpdateRecent extends Equatable {
  @override
  List<Object> get props => [];

}

class InitialStateUpdateRecent extends StatesUpdateRecent {}

class LoadingStateUpdateRecent extends StatesUpdateRecent {}

class ErrorStateUpdateRecent extends StatesUpdateRecent {
  String massage ;
  ErrorStateUpdateRecent({this.massage});
}
class FavoriteStateUpdateRecent extends StatesUpdateRecent {
  List<BaseNews> fvList ;
  FavoriteStateUpdateRecent({this.fvList});
}

class SuccessState_EveryThing_UpdateRecent extends StatesUpdateRecent {
  ArticleResponse articles ;
  SuccessState_EveryThing_UpdateRecent({this.articles});
}

