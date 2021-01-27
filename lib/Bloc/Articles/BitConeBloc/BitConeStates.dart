import 'package:equatable/equatable.dart';
import 'package:news_app/Models/ArticlesModels/ArticelsModel.dart';
import 'package:news_app/Models/ArticlesModels/ArticleResponse.dart';




abstract class BitConeStates extends Equatable {
 const BitConeStates();
  @override
  List<Object> get props => [];

}
class SuccessStateBitCone extends BitConeStates {
  final List<ArticleModel> bitcones;

  final bool hasReachedMax;

  SuccessStateBitCone({this.bitcones, this.hasReachedMax});

  SuccessStateBitCone copyWith({ArticleResponse popularList, bool hasReachedMax,}) {
    return SuccessStateBitCone(
      bitcones: popularList ?? this.bitcones,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
  @override
  List<Object> get props => [bitcones, hasReachedMax];

  @override
  String toString() =>
      'PostSuccess { posts: ${bitcones.length}, hasReachedMax: $hasReachedMax }';
}

class BitConeInitialState extends BitConeStates {}

class BitConeLoadingState extends BitConeStates {}

class BitConeErrorState extends BitConeStates {
  String massage ;
  BitConeErrorState({this.massage});
}



