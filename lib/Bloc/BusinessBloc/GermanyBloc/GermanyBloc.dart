import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Bloc/BusinessBloc/GermanyBloc/GermanyEvents.dart';
import 'package:news_app/network/NewsClinet.dart';
import 'GermanyStates.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';

import 'package:rxdart/rxdart.dart';


class GermanyBloc extends Bloc<GermanyEvents , GermanyStates>{
  final NewsClient newsClient ;

  GermanyBloc(GermanyInitialState initialState, this.newsClient) : super(initialState);


  @override
  Stream<Transition<GermanyEvents, GermanyStates>> transformEvents(
      Stream<GermanyEvents> events,
      TransitionFunction<GermanyEvents, GermanyStates> transitionFn) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<GermanyStates> mapEventToState(GermanyEvents event) async*{
    final currentState = state;
    if (event is Fetch_HeadLine_Germany && !_hasReachedMax(currentState)) {
      try {
        if (currentState is GermanyInitialState) {
          final germanyList = await newsClient.fetch_HeadLine_Germany(0, 20);
          yield SuccessStateGermany(Germanynews: germanyList.articles, hasReachedMax: false);
          return;
        }
        if (currentState is SuccessStateGermany) {
          final germanyList = await newsClient.fetch_HeadLine_Germany(currentState.Germanynews.length, 20);
          yield germanyList.articles.isEmpty ?
          currentState.copyWith(hasReachedMax: true):
          SuccessStateGermany(Germanynews:currentState.Germanynews + germanyList.articles , hasReachedMax: false );

        }
      } catch (e) {
        yield GermanyErrorState(massage: e.toString());
      }

    }
  }
  bool _hasReachedMax(GermanyStates currentState) =>
      currentState is SuccessStateGermany && currentState.hasReachedMax;

}
