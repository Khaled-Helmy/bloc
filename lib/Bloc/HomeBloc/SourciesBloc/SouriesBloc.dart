import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/network/NewsClinet.dart';
import 'SouriesEvents.dart';
import 'SouriesStates.dart';

class SourciesBloc extends Bloc<SouriesEvents , SourciesStates>{
  final NewsClient newsClient ;
   String sourcesId = "sources";

  SourciesBloc(SourciesInitialState initialStateSourcies, this.newsClient) : super(initialStateSourcies);


  @override
  Stream<SourciesStates> mapEventToState(SouriesEvents event) async*{
    if (event is Fetch_Sources_Home){
      yield SourciesLoadingState();
      try {
        var sources = await newsClient.fetch_Sources();
        yield SuccessState_Sources_Home(sources: sources);
      }catch(e){
        yield SourciesErrorState(massage: e.toString());
      }

    }
  }



}