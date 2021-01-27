import 'package:equatable/equatable.dart';
import 'package:news_app/Models/ArticlesModels/ArticelsModel.dart';
import 'package:news_app/Models/ArticlesModels/ArticleResponse.dart';



abstract class GermanyStates extends Equatable {
 const GermanyStates();
  @override
  List<Object> get props => [];

}
class SuccessStateGermany extends GermanyStates {
  final List<ArticleModel> Germanynews;

  final bool hasReachedMax;

  SuccessStateGermany({this.Germanynews, this.hasReachedMax});

  SuccessStateGermany copyWith({ArticleResponse popularList, bool hasReachedMax,}) {
    return SuccessStateGermany(
      Germanynews: popularList ?? this.Germanynews,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
  @override
  List<Object> get props => [Germanynews, hasReachedMax];

  @override
  String toString() =>
      'PostSuccess { posts: ${Germanynews.length}, hasReachedMax: $hasReachedMax }';
}

class GermanyInitialState extends GermanyStates {}

class GermanyLoadingState extends GermanyStates {}

class GermanyErrorState extends GermanyStates {
  String massage ;
  GermanyErrorState({this.massage});
}



