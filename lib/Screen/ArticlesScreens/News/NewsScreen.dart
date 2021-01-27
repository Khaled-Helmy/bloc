import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:news_app/Bloc/Articles/NewsBloc/NewsBloc.dart';
import 'package:news_app/Bloc/Articles/NewsBloc/NewsEvents.dart';
import 'package:news_app/Bloc/Articles/NewsBloc/NewsStates.dart';
import 'package:news_app/Models/ArticlesModels/ArticelsModel.dart';
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
  return  new BlocBuilder<NewsBloc , NewsStates>(
      builder: (context , state){
        if(state is NewsInitialState){
          return InitialStateScreen();
        }
        if(state is NewsErrorState){
          return new Center(child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("May be No Internet To Connection Please Check Your Connection and TryAgin" ,
                style: TextStyle(color: Colors.red.shade900 , fontSize: 16), textAlign: TextAlign.center,),
              Text(state.massage),
            ],));
        }
        if(state is SuccessStateNews){
          if (state.news.isEmpty){
            return const Center(child: Text("No data"),);
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
      });
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
    return new Padding(
      padding: const EdgeInsets.all(12.0),
      child: new Card(
        elevation: 6,
        shadowColor: Colors.grey,
        child: new Padding(
          padding: const EdgeInsets.all(12.0),
          child: new Column(
            children: [
              new Container(
                width: double.infinity,
                child: (post.urlToImage != null) ?
                new Image.network(post.urlToImage, fit: BoxFit.cover,):
                new Image.asset("assets/images/background.jpg" , fit: BoxFit.cover,),
              ),
              const SizedBox(height: 10,),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Padding(
                    padding: const EdgeInsets.only(bottom: 8,top: 8 , right: 8),
                    child:new Row(
                      children: [
                       const  Icon(Icons.new_releases , color: Colors.orange, size: 50,),
                        const Text("New" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 16),)
                      ],
                    ),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(top: 10 , bottom: 10 , left: 10 , right: 10),
                    width: 200,
                    decoration:new  BoxDecoration(
                      borderRadius:new BorderRadius.circular(25) ,
                      gradient: new LinearGradient(
                        colors: [
                          Colors.red.shade900 ,
                          Colors.redAccent
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(Icons.person , color: Colors.black,),
                        new Expanded(
                          child:new  Text(post.author !=null ?  post.author : "Loading...",
                            style: const TextStyle(color:Colors.white , fontSize: 16 ,fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              new Text(post.title != null ? post.title: "Loading"
                ,style: const TextStyle( fontSize: 18 , fontWeight: FontWeight.bold , color: Colors.black),
                textAlign: TextAlign.center,),
              const  SizedBox(height: 10,),
              new Padding(
                padding: const EdgeInsets.only(bottom: 8,top: 8),
                child:new  Text(post.content != null ? post.content : "Loading",
                  style: const TextStyle( fontSize: 16 ,color: Colors.black54),
                  textAlign: TextAlign.start,),
              ),
              const SizedBox(height: 10,),
              new Text(post.publishedAt != null ?
              timeAgo(DateTime.parse(post.publishedAt)): "Loading",
                style:  TextStyle( fontSize: 16 ,color: Colors.red.shade900 ,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,),
              const SizedBox(height: 10,),
              SizedBox(width: double.infinity, height: 1, child: Container(color: Colors.red.shade900,) )
              ,new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  new  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      elevation: 3,
                      shadowColor: Colors.grey,
                      color: Colors.white,
                      child: new FlatButton(onPressed: (){}, child: Text("COMMENT" ,
                        style: TextStyle(color: Colors.red.shade900 ,fontWeight: FontWeight.w700),)),
                    ),
                    new Row(
                      children:[
                        new Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          elevation: 3,
                          shadowColor: Colors.grey,
                          color: Colors.white,
                          child: new FlatButton(onPressed: (){}, child: Text("SHARE" ,
                            style: TextStyle(color: Colors.red.shade900 ,fontWeight: FontWeight.w700),)),
                        ),

                        new Container(
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
                          child:new  FlatButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SinglePostPage(post)));
                          },
                              child:new  Text("OPEN" ,
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



