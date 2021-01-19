
import 'package:news_app/Models/SourceModel.dart';

class SourceResponse {
  final List<SourceModel> sources ;
  SourceResponse({this.sources});

  factory SourceResponse.fromJson(Map<String , dynamic> JsonObject)=>
      SourceResponse(
        sources:  (JsonObject["sources"] as List).map((e) => SourceModel.fromJson(e)).toList(),);

}