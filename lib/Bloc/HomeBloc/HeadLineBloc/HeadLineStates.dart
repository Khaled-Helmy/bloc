import 'package:equatable/equatable.dart';
import 'package:news_app/Models/ArticlesModels/ArticleResponse.dart';



class HeadLineStates extends Equatable {
  @override
  List<Object> get props => [];

}

class HeadLineInitialState extends HeadLineStates {}

class HeadLineLoadingState extends HeadLineStates {}

class HeadLineErrorState extends HeadLineStates {
  String massage ;
  HeadLineErrorState({this.massage});
}


class SuccessState_HeadLine_Home extends HeadLineStates {
  ArticleResponse articles ;
  SuccessState_HeadLine_Home({this.articles});
}

