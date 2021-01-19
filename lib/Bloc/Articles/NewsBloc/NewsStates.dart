import 'package:equatable/equatable.dart';
import 'package:news_app/Models/ArticelsModel.dart';
import 'package:news_app/Models/ArticleResponse.dart';



abstract class NewsStates extends Equatable {
 const NewsStates();
  @override
  List<Object> get props => [];

}
class SuccessStateNews extends NewsStates {
  final List<ArticleModel> news;

  final bool hasReachedMax;

  SuccessStateNews({this.news, this.hasReachedMax});

  SuccessStateNews copyWith({ArticleResponse popularList, bool hasReachedMax,}) {
    return SuccessStateNews(
      news: popularList ?? this.news,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
  @override
  List<Object> get props => [news, hasReachedMax];

  @override
  String toString() =>
      'PostSuccess { posts: ${news.length}, hasReachedMax: $hasReachedMax }';
}

class NewsInitialState extends NewsStates {}

class NewsLoadingState extends NewsStates {}

class NewsErrorState extends NewsStates {
  String massage ;
  NewsErrorState({this.massage});
}



