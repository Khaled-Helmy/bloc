import 'package:news_app/InterFace/disposable.dart';
import 'package:news_app/Models/ArticleResponse.dart';
import 'package:news_app/network/NewsClinet.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc implements disposable{
 final NewsClient _newsClient = NewsClient();
 final BehaviorSubject<ArticleResponse> _subject = BehaviorSubject<ArticleResponse>();

 search (String value)async {
   ArticleResponse response = await _newsClient.fetch_search(value);
   if (!_subject.isClosed){
    _subject.sink.add(response);
   }else
    print("IS Closed");

 }
 @override
  void dispose() {
   _subject.close();
  }
  BehaviorSubject<ArticleResponse> get subject => _subject ;

}

final searchBloc = SearchBloc();