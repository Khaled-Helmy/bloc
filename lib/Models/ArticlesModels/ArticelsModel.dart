import 'file:///G:/Flutter%20Projects/news_app/lib/Models/SourceModels/SourceModel.dart';

import '../BaseNews.dart';
class ArticleModel extends BaseNews {
  SourceModel sourceModel ;
  ArticleModel({this.sourceModel , String author, String title, String description,String url , String urlToImage , String publishedAt, String content})
      :super(author: author , title: title , description: description , url: url ,
      urlToImage: urlToImage , publishedAt: publishedAt , content: content);

  factory ArticleModel.fromJson(Map<String , dynamic> JsonObject) =>
      ArticleModel(
         sourceModel: SourceModel.fromJson(JsonObject["source"]),
        author: JsonObject["author"],
        title: JsonObject["title"],
        description: JsonObject["description"],
        url: JsonObject["url"],
        urlToImage: JsonObject["urlToImage"],
        content: JsonObject["content"],
        publishedAt: DateTime.parse(JsonObject["publishedAt"]).toString(),

      );


}