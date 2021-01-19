import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Bloc/Articles/NewsBloc/NewsBloc.dart';
import 'package:news_app/Bloc/Articles/NewsBloc/NewsEvents.dart';
import 'package:news_app/Bloc/Articles/NewsBloc/NewsStates.dart';
import 'package:news_app/Models/ArticelsModel.dart';
import 'package:news_app/Models/BaseNews.dart';
import 'package:news_app/Screen/SinglePostPage.dart';
import 'package:news_app/Screen/StateScreen/StateScreen.dart';
import 'package:news_app/utilties/Handle_DateTime.dart';



class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}
class _NewsScreenState extends State<NewsScreen> {
NewsBloc bloc ;
final _scrollController = ScrollController();
final _scrollThreshold = 200.0;


@override
  void initState() {
  _scrollController.addListener(_onScroll);
  bloc = BlocProvider.of<NewsBloc>(context );
  bloc.add(Fetch_Popular_New());
    super.initState();

  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: BlocBuilder<NewsBloc , NewsStates>(
        builder: (context , state){
          if(state is NewsInitialState){
            return InitialStateScreen();
          }
          if(state is NewsErrorState){
            return Center(child: Text(state.massage),);
          }
          if(state is SuccessStateNews){
           if (state.news.isEmpty){
             return Center(child: Text("No data"),);
           }
           return ListView.builder(

               itemBuilder: (context ,int index){
                 return index >= state.news.length ?
                     BottomLoader() :
                     PostWigdet(post: state.news[index],);
               },
             itemCount: state.hasReachedMax ?
             state.news.length :
             state.news.length +1,
             controller: _scrollController,
               );
          } else
            print(bloc.state);
              return Center(child: Text("Error"),);
        }),
  );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      bloc.add(Fetch_Popular_New());
    }
  }


  }
class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child:LoadingStateScreen(),
        ),
      ),
    );
  }
}

class PostWigdet extends StatelessWidget {
  final ArticleModel post ;

  const PostWigdet({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        elevation: 6,
        shadowColor: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: (post.urlToImage != null) ?
                Image.network(post.urlToImage, fit: BoxFit.cover,):
                Image.asset("assets/images/background.jpg" , fit: BoxFit.cover,),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8,top: 8 , right: 8),
                    child:Row(
                      children: [
                        Icon(Icons.new_releases , color: Colors.orange, size: 50,),
                        Text("New" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 16),)
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10 , bottom: 10 , left: 10 , right: 10),
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
                        Expanded(
                          child: Text(post.author !=null ?  post.author : "Loading...",
                            style: TextStyle(color:Colors.white , fontSize: 16 ,fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text(post.title != null ? post.title: "Loading"
                ,style: TextStyle( fontSize: 18 , fontWeight: FontWeight.bold , color: Colors.black),
                textAlign: TextAlign.center,),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(bottom: 8,top: 8),
                child: Text(post.content != null ? post.content : "Loading",
                  style: TextStyle( fontSize: 16 ,color: Colors.black54),
                  textAlign: TextAlign.start,),
              ),
              SizedBox(height: 10,),
              Text(post.publishedAt != null ?
              timeAgo(DateTime.parse(post.publishedAt)): "Loading",
                style: TextStyle( fontSize: 16 ,color: Colors.red.shade900 ,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,),
              SizedBox(height: 10,),
              SizedBox(width: double.infinity, height: 1, child: Container(color: Colors.red.shade900,) )
              ,Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      elevation: 3,
                      shadowColor: Colors.grey,
                      color: Colors.white,
                      child: FlatButton(onPressed: (){}, child: Text("COMMENT" ,
                        style: TextStyle(color: Colors.red.shade900 ,fontWeight: FontWeight.w700),)),
                    ),
                    Row(
                      children:[
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          elevation: 3,
                          shadowColor: Colors.grey,
                          color: Colors.white,
                          child: FlatButton(onPressed: (){}, child: Text("SHARE" ,
                            style: TextStyle(color: Colors.red.shade900 ,fontWeight: FontWeight.w700),)),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10) ,
                            gradient: LinearGradient(
                              colors: [
                                Colors.red.shade900 ,
                                Colors.redAccent
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: FlatButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SinglePostPage(post)));
                          },
                              child: Text("OPEN" ,
                                style: TextStyle(color: Colors.white ,fontWeight: FontWeight.w700),)),
                        ),


                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



