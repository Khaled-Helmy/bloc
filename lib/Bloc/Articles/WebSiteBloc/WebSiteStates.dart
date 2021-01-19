import 'package:equatable/equatable.dart';
import 'package:news_app/Models/ArticelsModel.dart';
import 'package:news_app/Models/ArticleResponse.dart';



abstract class WebSiteStates extends Equatable {
 const WebSiteStates();
  @override
  List<Object> get props => [];

}
class SuccessStateWebSite extends WebSiteStates {
  final List<ArticleModel> webSites;

  final bool hasReachedMax;

  SuccessStateWebSite({this.webSites, this.hasReachedMax});

  SuccessStateWebSite copyWith({ArticleResponse popularList, bool hasReachedMax,}) {
    return SuccessStateWebSite(
      webSites: popularList ?? this.webSites,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
  @override
  List<Object> get props => [webSites, hasReachedMax];

  @override
  String toString() =>
      'PostSuccess { posts: ${webSites.length}, hasReachedMax: $hasReachedMax }';
}

class WebSiteInitialState extends WebSiteStates {}

class WebSiteLoadingState extends WebSiteStates {}

class WebSiteErrorState extends WebSiteStates {
  String massage ;
  WebSiteErrorState({this.massage});
}



