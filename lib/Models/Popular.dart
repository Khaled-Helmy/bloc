import 'package:news_app/Models/BaseNews.dart';

class Popular extends BaseNews{


  Popular({String author, String title, String description,String url , String urlToImage , String publishedAt, String content})
      :super(author: author , title: title , description: description , url: url ,
      urlToImage: urlToImage , publishedAt: publishedAt , content: content);

  factory Popular.fromJson(Map<String , dynamic> JsonObject) =>
      Popular(
        author: JsonObject["author"],
        title: JsonObject["title"],
        description: JsonObject["description"],
        url: JsonObject["url"],
        urlToImage: JsonObject["urlToImage"],
        content: JsonObject["content"],
        publishedAt: DateTime.parse(JsonObject["publishedAt"]).toString(),

      );


}


class AllPopular{
  List<dynamic> allNews ;
  AllPopular({this.allNews});
  factory AllPopular.fromJson(Map<String , dynamic> JsonObject)=>
      AllPopular(allNews:JsonObject["articles"]);
}
