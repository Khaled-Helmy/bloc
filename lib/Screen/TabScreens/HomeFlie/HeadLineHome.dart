import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Bloc/HomeBloc/HeadLineBloc/HeadLineBloc.dart';
import 'package:news_app/Bloc/HomeBloc/HeadLineBloc/HeadLineEvents.dart';
import 'package:news_app/Bloc/HomeBloc/HeadLineBloc/HeadLineStates.dart';
import 'package:news_app/Models/ArticelsModel.dart';
import 'package:news_app/Models/ArticleResponse.dart';
import 'package:news_app/Screen/SinglePostPage.dart';
import 'package:news_app/Screen/StateScreen/StateScreen.dart';
import 'package:news_app/utilties/Handle_DateTime.dart';
class HeadLineHome extends StatefulWidget {
  @override
  _HeadLineHomeState createState() => _HeadLineHomeState();
}

class _HeadLineHomeState extends State<HeadLineHome> {
  HeadLineBloc bloc ;
 var  placeHolder =  AssetImage("assets/images/background.jpg");
  @override
  void initState() {
    bloc = BlocProvider.of<HeadLineBloc>(context);
    bloc.add(Fetch_HeadLine_Home());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HeadLineBloc , HeadLineStates>(
      cubit: bloc ,
      builder: (context , state){
        if(state is HeadLineInitialState){
          return InitialStateScreen();
        }else if (state is HeadLineLoadingState){
          return LoadingStateScreen();
        }else if (state is SuccessState_HeadLine_Home){
          return (state.articles != null)?
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: drawHeadLine(state.articles ,context),
          ): LoadingStateScreen();
        }else if (state is HeadLineErrorState){
          return Center(child: Text(state.massage),);
        }else
          return Container(child: Text("Error"),);
      },

    );
  }
}

Widget drawHeadLine(ArticleResponse articleResponse , context) {
  List<ArticleModel> articles = articleResponse.articles;
  if(articles.length == 0 ){
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Text("no Sources"),
        ],
      ),
    );
  }
  else
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          enlargeCenterPage: false ,
          height: 200 ,
          viewportFraction:0.9 ,
        ),
        items: IteamHeadLine(articles , context),

      ) ,
    );
}
IteamHeadLine(List<ArticleModel> articles , context) {
  return articles.map((article) =>
      GestureDetector(
        onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> SinglePostPage(article))),
        child: Container(
          padding: EdgeInsets.all(12),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: article.urlToImage != null ?
                      NetworkImage(article.urlToImage)
                          : AssetImage("assets/images/background.jpg"),

                    )
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter ,
                      end: Alignment.topCenter,
                      stops: [
                        0.1 ,
                        0.9,
                      ],
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.white.withOpacity(0.0),
                      ]
                  ),

                ),
              ),
              Positioned(
                  bottom: 30.0,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    width: 250,
                    child: Column(
                      children: [
                        Text(article.title != null ? article.title : "Loading",
                          style: TextStyle(fontWeight: FontWeight.bold , fontSize: 16 , color: Colors.white , height: 1),)

                      ],
                    ),
                  )),
              Positioned(bottom: 10.0,
                  left: 10.0,
                  child: Text(article.sourceModel.name != null ?  article.sourceModel.name : "Loading" ,
                    style: TextStyle(fontSize: 14 , color: Colors.red.shade900  , fontWeight: FontWeight.bold),)),
              Positioned(
                  right: 10,
                  bottom: 10,
                  child: Text(article.publishedAt != null ? timeAgo(DateTime.parse(article.publishedAt)) : "Loading" ,
                    style: TextStyle(color: Colors.white),))
            ],
          ),
        ),
      )).toList();
}

