abstract class BaseNews {
  List<String> source ;
  String author;
  String title ;
  String description;
  String url ;
  String  urlToImage;
  String publishedAt;
  String content ;

  BaseNews({this.author, this.title, this.description,this.url ,
    this.urlToImage,this.publishedAt, this.content  });

}