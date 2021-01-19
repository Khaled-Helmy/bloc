import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/network/NewsClinet.dart';
import 'TrumpEvents.dart';
import 'TrumpStates.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';

import 'package:rxdart/rxdart.dart';


class TrumpBloc extends Bloc<TrumpEvents , TrumpStates>{
  final NewsClient newsClient ;

  TrumpBloc(TrumpInitialState initialState, this.newsClient) : super(initialState);


  @override
  Stream<Transition<TrumpEvents, TrumpStates>> transformEvents(
      Stream<TrumpEvents> events,
      TransitionFunction<TrumpEvents, TrumpStates> transitionFn) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<TrumpStates> mapEventToState(TrumpEvents event) async*{
    final currentState = state;
    if (event is Fetch_HeadLine_Trmup && !_hasReachedMax(currentState)) {
      try {
        if (currentState is TrumpInitialState) {
          final trumpList = await newsClient.fetch_HeadLine_Trump(0, 20);
          yield SuccessStateTrump(trumpnews: trumpList.articles, hasReachedMax: false);
          return;
        }
        if (currentState is SuccessStateTrump) {
          final trumpList = await newsClient.fetch_HeadLine_Trump(currentState.trumpnews.length, 20);
          yield trumpList.articles.isEmpty ?
          currentState.copyWith(hasReachedMax: true):
          SuccessStateTrump(trumpnews:currentState.trumpnews + trumpList.articles , hasReachedMax: false );

        }
      } catch (e) {
        yield TrumpErrorState(massage: e.toString());
      }

    }
  }
  bool _hasReachedMax(TrumpStates currentState) =>
      currentState is SuccessStateTrump && currentState.hasReachedMax;

}
