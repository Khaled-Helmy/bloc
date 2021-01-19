import 'package:news_app/Models/ArticelsModel.dart';

class ArticleResponse {
  final List<ArticleModel> articles ;
  final String error ;

  ArticleResponse({this.articles , this.error});

  factory ArticleResponse.fromJson(Map<String , dynamic> JsonObject)=>
      ArticleResponse(
        articles:(JsonObject["articles"] as List ).map((e) => ArticleModel.fromJson(e)).toList() ,
        error: ""
      );

}