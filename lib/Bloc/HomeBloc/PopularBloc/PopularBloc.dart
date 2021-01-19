import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/network/NewsClinet.dart';
import 'PopularEvents.dart';
import 'PopularStates.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';

import 'package:rxdart/rxdart.dart';


class PopularBloc extends Bloc<PopularEvents , PopularStates>{
  final NewsClient newsClient ;

  PopularBloc(PopularInitialState initialState, this.newsClient) : super(initialState);


  @override
  Stream<Transition<PopularEvents, PopularStates>> transformEvents(
      Stream<PopularEvents> events,
      TransitionFunction<PopularEvents, PopularStates> transitionFn) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );

  }
  @override
  Stream<PopularStates> mapEventToState(PopularEvents event) async*{
    final currentState = state;
    if (event is Fetch_Popular && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PopularInitialState) {
          final popularList = await newsClient.fetch_EveryThing(0, 20);
          yield SuccessStatePopular(populars: popularList, hasReachedMax: false);
          return;
        }
        if (currentState is SuccessStatePopular) {
          final popularList = await newsClient.fetch_EveryThing(currentState.populars.length, 20);
          yield popularList.isEmpty ?
          currentState.copyWith(hasReachedMax: true):
          SuccessStatePopular(populars:currentState.populars + popularList , hasReachedMax: false );

        }
      } catch (e) {
        yield PopularErrorState(massage: e.toString());
      }

    }
  }
  bool _hasReachedMax(PopularStates currentState) =>
      currentState is SuccessStatePopular && currentState.hasReachedMax;

}
