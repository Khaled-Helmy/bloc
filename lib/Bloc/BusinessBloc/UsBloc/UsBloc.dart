import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Bloc/BusinessBloc/UsBloc/UsEvents.dart';
import 'package:news_app/network/NewsClinet.dart';
import 'UsStates.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';

import 'package:rxdart/rxdart.dart';


class UsBloc extends Bloc<UsEvents , UsStates>{
  final NewsClient newsClient ;

  UsBloc(UsInitialState initialState, this.newsClient) : super(initialState);


  @override
  Stream<Transition<UsEvents, UsStates>> transformEvents(
      Stream<UsEvents> events,
      TransitionFunction<UsEvents, UsStates> transitionFn) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<UsStates> mapEventToState(UsEvents event) async*{
    final currentState = state;
    if (event is Fetch_HeadLine_Us && !_hasReachedMax(currentState)) {
      try {
        if (currentState is UsInitialState) {
          final UsList = await newsClient.fetch_HeadLine_Us(0, 20);
          yield SuccessStateUs(Usnews: UsList.articles, hasReachedMax: false);
          return;
        }
        if (currentState is SuccessStateUs) {
          final UsList = await newsClient.fetch_HeadLine_Us(currentState.Usnews.length, 20);
          yield UsList.articles.isEmpty ?
          currentState.copyWith(hasReachedMax: true):
          SuccessStateUs(Usnews:currentState.Usnews + UsList.articles , hasReachedMax: false );

        }
      } catch (e) {
        yield UsErrorState(massage: e.toString());
      }

    }
  }
  bool _hasReachedMax(UsStates currentState) =>
      currentState is SuccessStateUs && currentState.hasReachedMax;

}
