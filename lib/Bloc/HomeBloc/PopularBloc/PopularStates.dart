import 'package:equatable/equatable.dart';
import 'package:news_app/Models/ArticelsModel.dart';
import 'package:news_app/Models/ArticleResponse.dart';



abstract class PopularStates extends Equatable {
 const PopularStates();
  @override
  List<Object> get props => [];

}

class PopularInitialState extends PopularStates {}

class PopularLoadingState extends PopularStates {}

class PopularErrorState extends PopularStates {
  String massage ;
  PopularErrorState({this.massage});
}

class SuccessStatePopular extends PopularStates {
  final List<ArticleModel> populars;

  final bool hasReachedMax;

  const SuccessStatePopular({this.populars, this.hasReachedMax});

  SuccessStatePopular copyWith({ArticleResponse popularList, bool hasReachedMax,}) {
    return SuccessStatePopular(
      populars: popularList ?? this.populars,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
  @override
  List<Object> get props => [populars, hasReachedMax];

  @override
  String toString() =>
      'PostSuccess { posts: ${populars.length}, hasReachedMax: $hasReachedMax }';

}


