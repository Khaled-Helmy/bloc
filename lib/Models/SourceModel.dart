

class SourceModel{
  String id ;
  String name ;
  String description ;
  String url ;
  String  category ;
  String language ;
  String country ;
  SourceModel({this.id  , this.name , this.description , this.url , this.category , this.language , this.country});

  factory SourceModel.fromJson(Map<String , dynamic> JsonObject) =>
      SourceModel(
        name : JsonObject["name"],
        id: JsonObject["id"],
        url: JsonObject["url"],
        description: JsonObject["description"],
        category: JsonObject["category"],
        language: JsonObject["language"],
        country: JsonObject["country"],

      );
}