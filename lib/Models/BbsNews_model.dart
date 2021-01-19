

import 'package:news_app/Models/BaseNews.dart';

class BbcNewsModel extends BaseNews{


 BbcNewsModel({String author, String title, String description,String url , String urlToImage , String publishedAt, String content})
     :super(author: author , title: title , description: description , url: url ,
     urlToImage: urlToImage , publishedAt: publishedAt , content: content);

   factory BbcNewsModel.fromJson(Map<String , dynamic> JsonObject) =>
    BbcNewsModel(
      author: JsonObject["author"],
      title: JsonObject["title"],
      description: JsonObject["description"],
      url: JsonObject["url"],
      urlToImage: JsonObject["urlToImage"],
      publishedAt: DateTime.parse(JsonObject["publishedAt"]).toString(),
      content: JsonObject["content"],

    );


}
class allBbcNewsModel{
 List<dynamic> allNews ;
 allBbcNewsModel({this.allNews});
 factory allBbcNewsModel.fromJson(Map<String , dynamic> JsonObject)=>
     allBbcNewsModel(allNews:JsonObject["articles"]);
}
