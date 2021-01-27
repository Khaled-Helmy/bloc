import 'package:equatable/equatable.dart';
import 'package:news_app/Models/ArticlesModels/ArticleResponse.dart';



class TopStoriesStates extends Equatable {
  @override
  List<Object> get props => [];

}

class TopStoriesInitialState extends TopStoriesStates {}

class TopStoriesLoadingState extends TopStoriesStates {}

class TopStoriesErrorState extends TopStoriesStates {
  String massage ;
  TopStoriesErrorState({this.massage});
}


class TopStories_SuccessState extends TopStoriesStates {
  ArticleResponse articles ;
  TopStories_SuccessState({this.articles});
}

