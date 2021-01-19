import 'package:news_app/Models/BaseNews.dart';

class FavoriteModel extends BaseNews{

  FavoriteModel({String author, String title, String description,String url , String urlToImage , String publishedAt, String content})
      :super(author: author , title: title , description: description , url: url ,
      urlToImage: urlToImage , publishedAt: publishedAt , content: content);


}