import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/network/NewsClinet.dart';
import 'HeadLineEvents.dart';
import 'HeadLineStates.dart';

class HeadLineBloc extends Bloc<HeadLineEvents , HeadLineStates>{
  final NewsClient newsClient ;

  HeadLineBloc(HeadLineInitialState initialState, this.newsClient) : super(initialState);


  @override
  Stream<HeadLineStates> mapEventToState(HeadLineEvents event) async*{
    if (event is Fetch_HeadLine_Home) {
      yield HeadLineInitialState();
      try {
        var headLines = await newsClient.fetch_HeadLine("country" , "us");
        yield SuccessState_HeadLine_Home(articles: headLines);
      } catch (e) {
        yield HeadLineErrorState(massage: e.toString());
      }
    }
  }



}