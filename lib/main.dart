import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Bloc/BusinessBloc/GermanyBloc/GermanyBloc.dart';
import 'package:news_app/Bloc/BusinessBloc/GermanyBloc/GermanyStates.dart';
import 'package:news_app/Bloc/BusinessBloc/UsBloc/UsBloc.dart';
import 'Bloc/Articles/BitConeBloc/BitConeBloc.dart';
import 'Bloc/Articles/BitConeBloc/BitConeStates.dart';
import 'Bloc/Articles/NewsBloc/NewsBloc.dart';
import 'Bloc/Articles/NewsBloc/NewsStates.dart';
import 'Bloc/Articles/WebSiteBloc/WebSiteBloc.dart';
import 'Bloc/Articles/WebSiteBloc/WebSiteStates.dart';
import 'Bloc/BusinessBloc/UsBloc/UsStates.dart';
import 'Bloc/FavoriteBlocFile/FavoriteBloc.dart';
import 'Bloc/HomeBloc/HeadLineBloc/HeadLineBloc.dart';
import 'Bloc/HomeBloc/HeadLineBloc/HeadLineStates.dart';
import 'Bloc/HomeBloc/PopularBloc/PopularBloc.dart';
import 'Bloc/HomeBloc/PopularBloc/PopularStates.dart';
import 'Bloc/HomeBloc/SourciesBloc/SouriesBloc.dart';
import 'Bloc/HomeBloc/SourciesBloc/SouriesStates.dart';
import 'Bloc/HomeBloc/TopStoriesBloc/TopStoriesBloc.dart';
import 'Bloc/HomeBloc/TopStoriesBloc/TopStoriesStates.dart';
import 'Bloc/HomeBloc/updateRecentBloc/StatesUpdateRecent.dart';
import 'Bloc/HomeBloc/updateRecentBloc/UpdateRecentBloc.dart';
import 'Bloc/Poitical_Figuar/TrumpBloc/TrumpBloc.dart';
import 'Bloc/Poitical_Figuar/TrumpBloc/TrumpStates.dart';
import 'Bloc/blocObserver.dart';
import 'Screen/WelcomePage.dart';
import 'network/NewsClinet.dart';

void main() {
  Bloc.observer = blocObserver();
  runApp(MultiBlocProvider(
     providers: [
       BlocProvider<FavoriteBloc>(create: (context)=> FavoriteBloc(),),
       BlocProvider<UpdateRecentBloc>(create: (context)=> UpdateRecentBloc(InitialStateUpdateRecent(), NewsClient()),),
       BlocProvider<TopStoriesBloc>(create: (context)=> TopStoriesBloc(TopStoriesInitialState(), NewsClient()),),
       BlocProvider<SourciesBloc>(create: (context)=> SourciesBloc(SourciesInitialState(), NewsClient()),),
       BlocProvider<HeadLineBloc>(create: (context)=> HeadLineBloc(HeadLineInitialState(), NewsClient()),),
       BlocProvider<PopularBloc>(create: (context)=> PopularBloc(PopularInitialState(), NewsClient()),),
       BlocProvider<BitConeBloc>(create: (context)=> BitConeBloc(BitConeInitialState(), NewsClient()),),
       BlocProvider<NewsBloc>(create: (context)=> NewsBloc(NewsInitialState(), NewsClient()),),
       BlocProvider<WebSiteBloc>(create: (context)=> WebSiteBloc(WebSiteInitialState(), NewsClient()),),
       BlocProvider<TrumpBloc>(create: (context)=> TrumpBloc(TrumpInitialState(), NewsClient()),),
       BlocProvider<UsBloc>(create: (context)=> UsBloc(UsInitialState(), NewsClient()),),
       BlocProvider<GermanyBloc>(create: (context)=> GermanyBloc(GermanyInitialState(), NewsClient()),),
     ],

      child: MyApp()));
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red
      ),
      home: WelcomePage(),

    );
  }
}
