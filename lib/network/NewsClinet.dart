
import 'package:dio/dio.dart';
import 'package:news_app/Models/ArticelsModel.dart';
import 'package:news_app/Models/ArticleResponse.dart';
import 'package:news_app/Models/SourceResponse.dart';

import 'API.dart';

class NewsClient {
  final String url_headline = base_News_api + Headline_api ;
  final String url_sources   = base_News_api + Source_api ;
  final String url_Articles = base_News_api + everything_api ;
  final String apiKey = "6ee60f5da4484e508695a30f407c3df1";
  final Dio _dio = Dio();


  Future<List<ArticleModel>> fetch_EveryThing(int startIndex, int limit) async{
    var param = {
      "apiKey" :apiKey ,
      "q" : "Apple" ,
      "sortBy" : "popularity"};

    try{
      Response response = await _dio.get(url_Articles , queryParameters: param);

      ArticleResponse articleResponse= ArticleResponse.fromJson(response.data);
      return articleResponse.articles;
    }catch(e , stackrace){
      print("Exception occud : $e  stackrace $stackrace");
    }

  }
  Future<ArticleResponse> fetch_EveryThing_UpdateRecent() async{
    var param = {
      "q" : "Apple" ,
    "sortBy" : "popularity",
      "apiKey" :apiKey ,

      };

    try{
      Response response = await _dio.get(url_Articles , queryParameters: param);
      return ArticleResponse.fromJson(response.data);
    }catch(e , stackrace){
      print("Exception occud : $e  stackrace $stackrace");
    }

  }
  Future<ArticleResponse> fetch_EveryThing_BitCone(int startIndex, int limit) async{
    var param = {
      "q" : "bitcoin",
      "apiKey" :apiKey ,};

    try{
      Response response = await _dio.get(url_Articles , queryParameters: param);
      return ArticleResponse.fromJson(response.data);
    }catch(e , stackrace){
      print("Exception occud : $e  stackrace $stackrace");
    }

  }
  Future<ArticleResponse> fetch_EveryThing_yesterday(int startIndex, int limit) async{
   final now = DateTime.now();
    var param = {
      "q" : "Apple",
      "from" : "${now.year}-${now.month}-${now.day-1}" ,
      "to" : "${now.year}-${now.month}-${now.day-1} " ,
      "sortBy" : "popularity",
      "apiKey" :apiKey ,};

    try{
      Response response = await _dio.get(url_Articles , queryParameters: param);
      return ArticleResponse.fromJson(response.data);
    }catch(e , stackrace){
      print("Exception occud : $e  stackrace $stackrace");
    }

  }
  Future<ArticleResponse> fetch_EveryThing_WebSite(int startIndex, int limit) async{
    var param = {
      "domains" : "techcrunch.com,thenextweb.com",
      "apiKey" :apiKey ,};

    try{
      Response response = await _dio.get(url_Articles , queryParameters: param);
      return ArticleResponse.fromJson(response.data);
    }catch(e , stackrace){
      print("Exception occud : $e  stackrace $stackrace");
    }

  }

  Future<ArticleResponse> fetch_HeadLine_Trump(int startIndex, int limit) async{
    var param = {
      "q":"trump",
      "apiKey" :apiKey ,};

    try{
      Response response = await _dio.get(url_headline , queryParameters: param);
      return ArticleResponse.fromJson(response.data);
    }catch(e , stackrace){
      print("Exception occud : $e  stackrace $stackrace");
    }

  }
  Future<ArticleResponse> fetch_HeadLine(String name , String key) async{
    var param = {
      name : key,
      "apiKey" :apiKey ,

    };

    try{
      Response response = await _dio.get(url_headline , queryParameters: param);
      return ArticleResponse.fromJson(response.data);

    }catch(e , stackrace){
      print("Exception occud : $e  stackrace $stackrace");
    }

  }
  Future<ArticleResponse> fetch_HeadLine_Germany(int startIndex, int limit) async{
    var param = {
      "apiKey" :apiKey ,
      "country" : "de",
      "category" :"business"
    };

    try{
      Response response = await _dio.get(url_headline , queryParameters: param);
      return ArticleResponse.fromJson(response.data);

    }catch(e , stackrace){
      print("Exception occud : $e  stackrace $stackrace");
    }

  }
  Future<ArticleResponse> fetch_HeadLine_Us(int startIndex, int limit) async{
    var param = {
      "country" : "us",
      "apiKey" :apiKey ,

    };

    try{
      Response response = await _dio.get(url_headline , queryParameters: param);
      return ArticleResponse.fromJson(response.data);

    }catch(e , stackrace){
      print("Exception occud : $e  stackrace $stackrace");
    }

  }




  Future<SourceResponse> fetch_Sources() async{
    var param = {
      "apiKey" :apiKey ,
    };
    try{
      Response response = await _dio.get(url_sources , queryParameters: param);
      return SourceResponse.fromJson(response.data);

    }catch(e , stackrace){
      print("Exception occud : $e  stackrace $stackrace");
    }

  }




  Future<SourceResponse> fetch_SourceNews({String sourceID}) async{
    var param = {
      "apiKey" :apiKey ,
      "sources" :sourceID };

    try{
      Response response = await _dio.get(url_Articles , queryParameters: param);
      return SourceResponse.fromJson(response.data);
    }catch(e , stackrace){
      print("Exception occud : $e  stackrace $stackrace");
    }

  }

  Future<ArticleResponse> fetch_search( String searchValue ) async{
    var param = {
      "apiKey" :apiKey ,
      "q" : searchValue,
    };

    try{
      Response response = await _dio.get(url_Articles , queryParameters: param);
      return ArticleResponse.fromJson(response.data);
    }catch(e , stackrace){
      print("Exception occud : $e  stackrace $stackrace");
    }

  }



}



