import 'package:equatable/equatable.dart';
import 'package:news_app/Models/SourceModels/SourceResponse.dart';



class SourciesStates extends Equatable {
  @override
  List<Object> get props => [];

}

class SourciesInitialState extends SourciesStates {}

class SourciesLoadingState extends SourciesStates {}

class SourciesErrorState extends SourciesStates {
  String massage ;
  SourciesErrorState({this.massage});
}

class SuccessState_Sources_Home extends SourciesStates {
  SourceResponse sources ;
  SuccessState_Sources_Home({this.sources});
}

