import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/network/NewsClinet.dart';
import 'WebSiteEvents.dart';
import 'WebSiteStates.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';

import 'package:rxdart/rxdart.dart';


class WebSiteBloc extends Bloc<WebSiteEvents , WebSiteStates>{
  final NewsClient newsClient ;

  WebSiteBloc(WebSiteInitialState initialState, this.newsClient) : super(initialState);


  @override
  Stream<Transition<WebSiteEvents, WebSiteStates>> transformEvents(
      Stream<WebSiteEvents> events,
      TransitionFunction<WebSiteEvents, WebSiteStates> transitionFn) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<WebSiteStates> mapEventToState(WebSiteEvents event) async*{
    final currentState = state;
    if (event is Fetch_Popular_WebSite && !_hasReachedMax(currentState)) {
      try {
        if (currentState is WebSiteInitialState) {
          final websiteList = await newsClient.fetch_EveryThing_WebSite(0, 20);
          yield SuccessStateWebSite(webSites: websiteList.articles, hasReachedMax: false);
          return;
        }
        if (currentState is SuccessStateWebSite) {
          final websiteList = await newsClient.fetch_EveryThing_WebSite(currentState.webSites.length, 20);
          yield websiteList.articles.isEmpty ?
          currentState.copyWith(hasReachedMax: true):
          SuccessStateWebSite(webSites:currentState.webSites + websiteList.articles , hasReachedMax: false );

        }
      } catch (e) {
        yield WebSiteErrorState(massage: e.toString());
      }

    }
  }
  bool _hasReachedMax(WebSiteStates currentState) =>
      currentState is SuccessStateWebSite && currentState.hasReachedMax;

}
