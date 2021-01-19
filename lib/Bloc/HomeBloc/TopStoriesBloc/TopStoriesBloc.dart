import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/network/NewsClinet.dart';
import 'TopStoriesEvents.dart';
import 'TopStoriesStates.dart';

class TopStoriesBloc extends Bloc<TopStoriesEvents , TopStoriesStates>{
  final NewsClient newsClient ;

  TopStoriesBloc(TopStoriesInitialState initialStateTopStories, this.newsClient) : super(initialStateTopStories);


  @override
  Stream<TopStoriesStates> mapEventToState(TopStoriesEvents event) async*{
    if (event is TopStories_Fetch_HeadLine_BBcNews) {
      yield TopStoriesLoadingState();
      try {
        var headLines = await newsClient.fetch_HeadLine("sources", "bbc-news");
        yield TopStories_SuccessState(articles: headLines);
      } catch (e) {
        yield TopStoriesErrorState(massage: e.toString());
      }
    }
  }



}