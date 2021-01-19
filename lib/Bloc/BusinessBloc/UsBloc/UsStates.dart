import 'package:equatable/equatable.dart';
import 'package:news_app/Models/ArticelsModel.dart';
import 'package:news_app/Models/ArticleResponse.dart';



abstract class UsStates extends Equatable {
 const UsStates();
  @override
  List<Object> get props => [];

}
class SuccessStateUs extends UsStates {
  final List<ArticleModel> Usnews;

  final bool hasReachedMax;

  SuccessStateUs({this.Usnews, this.hasReachedMax});

  SuccessStateUs copyWith({ArticleResponse popularList, bool hasReachedMax,}) {
    return SuccessStateUs(
      Usnews: popularList ?? this.Usnews,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
  @override
  List<Object> get props => [Usnews, hasReachedMax];

  @override
  String toString() =>
      'PostSuccess { posts: ${Usnews.length}, hasReachedMax: $hasReachedMax }';
}

class UsInitialState extends UsStates {}

class UsLoadingState extends UsStates {}

class UsErrorState extends UsStates {
  String massage ;
  UsErrorState({this.massage});
}



