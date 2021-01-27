import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Bloc/HomeBloc/updateRecentBloc/EventsUpdateRecent.dart';
import 'package:news_app/Bloc/HomeBloc/updateRecentBloc/StatesUpdateRecent.dart';
import 'package:news_app/Bloc/HomeBloc/updateRecentBloc/UpdateRecentBloc.dart';
import 'package:news_app/Models/ArticlesModels/ArticelsModel.dart';
import 'package:news_app/Models/ArticlesModels/ArticleResponse.dart';

import 'package:news_app/Screen/StateScreen/StateScreen.dart';
import 'package:news_app/utilties/Handle_DateTime.dart';
class UpdateRecentHome extends StatefulWidget {
  @override
  _UpdateRecentHomeState createState() => _UpdateRecentHomeState();
}

class _UpdateRecentHomeState extends State<UpdateRecentHome> {
  UpdateRecentBloc bloc ;
  @override
  void initState() {
    bloc = BlocProvider.of<UpdateRecentBloc>(context);
    bloc.add(fetch_EveryThingUpdateRecent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return BlocBuilder<UpdateRecentBloc , StatesUpdateRecent>(
      builder: (context , state){
        if(state is InitialStateUpdateRecent){
          return InitialStateScreen();
        }else if (state is LoadingStateUpdateRecent){
          return LoadingStateScreen();
        }else if (state is SuccessState_EveryThing_UpdateRecent){
          return (state.articles != null) ?
          SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8 , left: 8 , top: 8),
                  child:Row(
                    children: [
                      Text("U" ,
                        style: TextStyle(color: Colors.red.shade900 , fontSize: 24 , fontWeight: FontWeight.bold ,)
                        ,textAlign: TextAlign.start,),
                      Text("pdate" ,
                        style: TextStyle(color: Colors.grey , fontSize: 24 , fontWeight: FontWeight.bold ,)
                        ,textAlign: TextAlign.start,),
                      SizedBox(width: 5,),
                      Text("R" ,
                        style: TextStyle(color: Colors.black , fontSize: 24 , fontWeight: FontWeight.bold ,)
                        ,textAlign: TextAlign.start,),
                      Text("ecent" ,
                        style: TextStyle(color: Colors.grey , fontSize: 24 , fontWeight: FontWeight.bold ,)
                        ,textAlign: TextAlign.start,),
                    ],
                  ),
                ),
                bulid_card1_UpdateRecent(state.articles , context) ,
                SizedBox(height: 5,),
                bulid_card2_UpdateRecent(state.articles , context),
              ],
            ),
          ):
          LoadingStateScreen();
        }else if (state is ErrorStateUpdateRecent){
          return new Center(child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Text("May be No Internet To Connection Please Check Your Connection and TryAgin" ,
                style: TextStyle(color: Colors.red.shade900 , fontSize: 16), textAlign: TextAlign.center,),
              new Text(state.massage),
            ],));
        }else
          return Center(child: Text("Error"),);

      },

    );
  }
}

Widget bulid_card1_UpdateRecent(ArticleResponse articleResponse , BuildContext context){
  List<ArticleModel> articles = articleResponse.articles;
  ArticleModel article = articles[0];
  return Container(
    padding: EdgeInsets.all(8.0),
    child: Card(
      elevation: 10.0,
      shadowColor: Colors.red.shade900,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Image.network(article.urlToImage != null ?
              article.urlToImage : "NoData" , fit: BoxFit.cover,) ,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16 , bottom: 10),
              child: Container(
                padding: EdgeInsets.only(top: 10 , bottom: 10),
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25) ,
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.shade900 ,
                      Colors.redAccent
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.person , color: Colors.black,),
                    Text( article.author !=null ?  article.author : "NoData",
                      style: TextStyle(color:Colors.white , fontSize: 16 ,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(article.title !=null ? article.title : "NoData",
                style: TextStyle(color: Colors.black ,fontSize: 20,
                    fontWeight: FontWeight.bold), textAlign: TextAlign.start,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.alarm , color: Colors.red.shade900),
                  SizedBox(width: 20,),
                  Text(article.publishedAt != null ?
                  timeAgo(DateTime.parse(article.publishedAt)): "Nodata"
                    , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500) , )
                ],
              ),
            ),

          ],
        ),
      ),
    ),
  );
}
Widget bulid_card2_UpdateRecent(ArticleResponse articleResponse , BuildContext context){
  List<ArticleModel> articles = articleResponse.articles;
  ArticleModel article = articles[1];
  return Container(
    padding: EdgeInsets.all(8.0),
    child: Card(
      elevation: 10.0,
      shadowColor: Colors.red.shade900,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Image.network(article.urlToImage != null ?article.urlToImage : "NoData" , fit: BoxFit.cover,) ,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16 , bottom: 10),
              child: Container(
                padding: EdgeInsets.only(top: 10 , bottom: 10),
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25) ,
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.shade900 ,
                      Colors.redAccent
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.person , color: Colors.black,),
                    Text( article.author !=null ?  article.author : "NoData",
                      style: TextStyle(color:Colors.white , fontSize: 16 ,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(article.title !=null ? article.title : "NoData",
                style: TextStyle(color: Colors.black ,fontSize: 20,
                    fontWeight: FontWeight.bold), textAlign: TextAlign.start,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.alarm , color: Colors.red.shade900),
                  SizedBox(width: 20,),
                  Text(article.publishedAt != null ?
                  timeAgo(DateTime.parse(article.publishedAt)): "Nodata"
                    , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500) , )
                ],
              ),
            ),

          ],
        ),
      ),
    ),
  );
}