import 'package:equatable/equatable.dart';
import 'package:news_app/Models/ArticelsModel.dart';
import 'package:news_app/Models/ArticleResponse.dart';



abstract class TrumpStates extends Equatable {
 const TrumpStates();
  @override
  List<Object> get props => [];

}
class SuccessStateTrump extends TrumpStates {
  final List<ArticleModel> trumpnews;

  final bool hasReachedMax;

  SuccessStateTrump({this.trumpnews, this.hasReachedMax});

  SuccessStateTrump copyWith({ArticleResponse popularList, bool hasReachedMax,}) {
    return SuccessStateTrump(
      trumpnews: popularList ?? this.trumpnews,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
  @override
  List<Object> get props => [trumpnews, hasReachedMax];

  @override
  String toString() =>
      'PostSuccess { posts: ${trumpnews.length}, hasReachedMax: $hasReachedMax }';
}

class TrumpInitialState extends TrumpStates {}

class TrumpLoadingState extends TrumpStates {}

class TrumpErrorState extends TrumpStates {
  String massage ;
  TrumpErrorState({this.massage});
}



