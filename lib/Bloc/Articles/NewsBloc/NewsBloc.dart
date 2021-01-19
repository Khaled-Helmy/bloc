import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/network/NewsClinet.dart';
import 'NewsEvents.dart';
import 'NewsStates.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';

import 'package:rxdart/rxdart.dart';


class NewsBloc extends Bloc<NewsEvents , NewsStates>{
  final NewsClient newsClient ;

  NewsBloc(NewsInitialState initialState, this.newsClient) : super(initialState);


  @override
  Stream<Transition<NewsEvents, NewsStates>> transformEvents(
      Stream<NewsEvents> events,
      TransitionFunction<NewsEvents, NewsStates> transitionFn) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<NewsStates> mapEventToState(NewsEvents event) async*{
    final currentState = state;
    if (event is Fetch_Popular_New && !_hasReachedMax(currentState)) {
      try {
        if (currentState is NewsInitialState) {
          final newsList = await newsClient.fetch_EveryThing_yesterday(0, 20);
          yield SuccessStateNews(news: newsList.articles, hasReachedMax: false);
          return;
        }
        if (currentState is SuccessStateNews) {
          final newsList = await newsClient.fetch_EveryThing_yesterday(currentState.news.length, 20);
          yield newsList.articles.isEmpty ?
          currentState.copyWith(hasReachedMax: true):
          SuccessStateNews(news:currentState.news + newsList.articles , hasReachedMax: false );

        }
      } catch (e) {
        yield NewsErrorState(massage: e.toString());
      }

    }
  }
  bool _hasReachedMax(NewsStates currentState) =>
      currentState is SuccessStateNews && currentState.hasReachedMax;

}
