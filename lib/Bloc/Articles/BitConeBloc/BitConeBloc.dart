import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/network/NewsClinet.dart';
import 'BitConeEvents.dart';
import 'BitConeStates.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';

import 'package:rxdart/rxdart.dart';


class BitConeBloc extends Bloc<BitConeEvents , BitConeStates>{
  final NewsClient newsClient ;

  BitConeBloc(BitConeInitialState initialState, this.newsClient) : super(initialState);

  @override
  Stream<Transition<BitConeEvents, BitConeStates>> transformEvents(
      Stream<BitConeEvents> events,
      TransitionFunction<BitConeEvents, BitConeStates> transitionFn) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<BitConeStates> mapEventToState(BitConeEvents event) async*{
    final currentState = state;
    if (event is Fetch_Popular_BitCons && !_hasReachedMax(currentState)) {
      try {
        if (currentState is BitConeInitialState) {
          final bitconeList = await newsClient.fetch_EveryThing_BitCone(0, 20);
          yield SuccessStateBitCone(bitcones: bitconeList.articles, hasReachedMax: false);
          return;
        }
        if (currentState is SuccessStateBitCone) {
          final bitconeList = await newsClient.fetch_EveryThing_BitCone(currentState.bitcones.length, 20);
          yield bitconeList.articles.isEmpty ?
          currentState.copyWith(hasReachedMax: true):
          SuccessStateBitCone(bitcones:currentState.bitcones + bitconeList.articles , hasReachedMax: false );

        }
      } catch (e) {
        yield BitConeErrorState(massage: e.toString());
      }

    }
  }
  bool _hasReachedMax(BitConeStates currentState) =>
      currentState is SuccessStateBitCone && currentState.hasReachedMax;

}
