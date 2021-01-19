import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/network/NewsClinet.dart';

import 'EventsUpdateRecent.dart';
import 'StatesUpdateRecent.dart';

class UpdateRecentBloc extends Bloc<EventsUpdateRecent , StatesUpdateRecent>{
  final NewsClient newsClient ;
   String sourcesId = "sources";

  UpdateRecentBloc(InitialStateUpdateRecent initialStateUpdateRecent, this.newsClient) : super(initialStateUpdateRecent);


  @override
  Stream<StatesUpdateRecent> mapEventToState(EventsUpdateRecent event) async*{
  if (event is fetch_EveryThingUpdateRecent){
    yield LoadingStateUpdateRecent();
    try{
      var popularList = await newsClient.fetch_EveryThing_UpdateRecent();
      yield SuccessState_EveryThing_UpdateRecent(articles: popularList);
    }catch(e){
      yield ErrorStateUpdateRecent(massage: e.toString());
    }
  }
  }



}