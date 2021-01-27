import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Bloc/HomeBloc/TopStoriesBloc/TopStoriesBloc.dart';
import 'package:news_app/Bloc/HomeBloc/TopStoriesBloc/TopStoriesEvents.dart';
import 'package:news_app/Bloc/HomeBloc/TopStoriesBloc/TopStoriesStates.dart';
import 'package:news_app/Models/ArticlesModels/ArticelsModel.dart';
import 'package:news_app/Models/ArticlesModels/ArticleResponse.dart';
import 'package:news_app/Screen/StateScreen/StateScreen.dart';
import 'package:news_app/utilties/Handle_DateTime.dart';
class TopStoriesHome extends StatefulWidget {
  @override
  _TopStoriesHomeState createState() => _TopStoriesHomeState();
}

class _TopStoriesHomeState extends State<TopStoriesHome> {
  TopStoriesBloc bloc ;
  @override
  void initState() {
    bloc = BlocProvider.of<TopStoriesBloc>(context);
    bloc.add(TopStories_Fetch_HeadLine_BBcNews());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new BlocBuilder<TopStoriesBloc , TopStoriesStates>(
        cubit: bloc,
        builder: (context ,state){
          if(state is TopStoriesInitialState){
            return InitialStateScreen();
          }else if (state is TopStoriesLoadingState){
            return LoadingStateScreen();
          }else if (state is TopStories_SuccessState){
           return (state.articles != null) ?
           draw_TopStories(context , state.articles):
           LoadingStateScreen();
          }else if (state is TopStoriesErrorState){
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
           return new Container(child: Text("Error"),);

        });
  }
}
Widget draw_TopStories (BuildContext context , ArticleResponse articleResponse){
  return new  Column(
    children: [
      new Container(
        margin: EdgeInsets.only(left: 10),
        child: new  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Text("Top" ,
              style: TextStyle(color: Colors.black , fontSize: 24 , fontWeight: FontWeight.bold)
              ,textAlign: TextAlign.start,),
            SizedBox(width: 5,),
            Text("Stories" ,
              style: TextStyle(color: Colors.grey , fontSize: 24 , fontWeight: FontWeight.bold)
              ,textAlign: TextAlign.start,),
            SizedBox(width: 10,),
            Text("BBc" ,
              style: TextStyle(color: Colors.red.shade900, fontSize: 24 , fontWeight: FontWeight.bold)
              ,textAlign: TextAlign.start,),
            SizedBox(width: 5,),
            Text("News" ,
              style: TextStyle(color: Colors.grey , fontSize: 24 , fontWeight: FontWeight.bold)
              ,textAlign: TextAlign.start,),
          ],
        ),
      ),
      build_card(articleResponse, context),
    ],
  ) ;
}
Widget build_card(ArticleResponse headLineBBc , context) {
 List<ArticleModel> list = headLineBBc.articles;
 if(list.length == 0 ){
  return Center(child: Container(child: Text("No Iteam" ,
     style: TextStyle(fontSize: 24 , fontWeight: FontWeight.bold , color: Colors.red.shade900),),),);
 }else
 return Container(
   height: 350,
   margin: EdgeInsets.only(top: 10),
   child: ListView.builder(
     scrollDirection: Axis.horizontal,
       shrinkWrap: true,
       itemCount: list.length,
       physics: ScrollPhysics(),
       itemBuilder: (context , index){
         return Card(
           shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)
                   , bottomLeft: Radius.circular(8) , bottomRight: Radius.circular(8)),
               side: BorderSide(color: Colors.black54 , width: 1.0 , style: BorderStyle.solid)
           ),
           elevation: 8.0,
           shadowColor: Colors.grey,
           child: Container(
             width: 350,
             height: 160,

             child: Column(
               children: [
                 ClipRRect(
                     borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                     child:(list[index].urlToImage == null) ?
                     Image.asset("assets/images/background.jpg"):
                         Column(children: [
                           FadeInImage.assetNetwork(placeholder:"assets/images/background.jpg" ,
                               image: list[index].urlToImage),
                           SizedBox(height:8,child: Container(color: Colors.red.shade900,), ),
                         ],),

                 ),

                 Expanded(
                   child: SingleChildScrollView(
                     scrollDirection: Axis.vertical,
                     child: Column(
                       children: [
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text(list[index].title !=null ?
                           list[index].title : "Loading.." , textAlign: TextAlign.center
                             , style: TextStyle(color: Colors.black, fontWeight:FontWeight.w700 , fontSize: 18 ), ),
                         ),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text( list[index].content !=null ? list[index].content : "Loading.." ,
                             style: TextStyle(color: Colors.black54 , fontSize: 14
                                 , fontWeight: FontWeight.w400), textAlign: TextAlign.start,),
                         ),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,

                             children: [
                               Text(list[index].publishedAt !=null ?  timeAgo(DateTime.parse(list[index].publishedAt)): "Loading..." ,
                                 textAlign: TextAlign.start, style: TextStyle(color: Colors.red.shade900
                                     , fontSize: 12 , fontWeight: FontWeight.w500),),
                               Icon(Icons.alarm),
                             ],),
                         ),
                       ],
                     ),
                   ),
                 ),

               ],
             ),
           ),
         );
       }),
 );

}