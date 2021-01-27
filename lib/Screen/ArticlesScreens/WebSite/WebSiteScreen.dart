import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:news_app/Bloc/Articles/WebSiteBloc/WebSiteBloc.dart';
import 'package:news_app/Bloc/Articles/WebSiteBloc/WebSiteEvents.dart';
import 'package:news_app/Bloc/Articles/WebSiteBloc/WebSiteStates.dart';
import 'package:news_app/Models/ArticlesModels/ArticelsModel.dart';
import 'package:news_app/Screen/SinglePostPage.dart';
import 'package:news_app/Screen/StateScreen/StateScreen.dart';
import 'package:news_app/utilties/Handle_DateTime.dart';



class WebSiteScreen extends StatefulWidget {
  @override
  _WebSiteScreenState createState() => _WebSiteScreenState();
}
class _WebSiteScreenState extends State<WebSiteScreen> {
WebSiteBloc bloc ;
final _scrollController = ScrollController();
final _scrollThreshold = 200.0;


@override
  void initState() {
  _scrollController.addListener(_onScroll);
  bloc = BlocProvider.of<WebSiteBloc>(context );
  bloc.add(Fetch_Popular_WebSite());
    super.initState();

  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
  return new  BlocBuilder<WebSiteBloc , WebSiteStates>(
      builder: (context , state){
        if(state is WebSiteInitialState){
          return InitialStateScreen();
        }
        if(state is WebSiteErrorState){
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
        if(state is SuccessStateWebSite){
          if (state.webSites.isEmpty){
            return const Center(child: Text("No data"),);
          }
          return ListView.builder(

            itemBuilder: (context ,int index){
              return index >= state.webSites.length ?
              BottomLoader() :
              PostWigdet(post: state.webSites[index],);
            },
            itemCount: state.hasReachedMax ?
            state.webSites.length :
            state.webSites.length +1,
            controller: _scrollController,
          );
        } else
          return Center(child: Text("Error"),);
      });
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      bloc.add(Fetch_Popular_WebSite());
    }
  }


  }
class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
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
              Container(
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
                    Expanded(
                      child: Text(post.author !=null ?  post.author : "Loading...",
                        style: TextStyle(color:Colors.white , fontSize: 16 ,fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,),
                    ),
                  ],
                ),
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
              Text(post.publishedAt != null ?
              timeAgo(DateTime.parse(post.publishedAt))
                  :"LOading.."),
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



