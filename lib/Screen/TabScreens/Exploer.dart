import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Bloc/HomeBloc/PopularBloc/PopularBloc.dart';
import 'package:news_app/Bloc/HomeBloc/PopularBloc/PopularEvents.dart';
import 'package:news_app/Bloc/HomeBloc/PopularBloc/PopularStates.dart';
import 'package:news_app/Models/ArticlesModels/ArticelsModel.dart';
import 'package:news_app/Screen/SinglePostPage.dart';
import 'package:news_app/Screen/StateScreen/StateScreen.dart';
import 'package:news_app/utilties/Handle_DateTime.dart';



class Exploer extends StatefulWidget {
  @override
  _ExploerState createState() => _ExploerState();
}
class _ExploerState extends State<Exploer> {
  PopularBloc bloc ;
final _scrollController = ScrollController();
final _scrollThreshold = 200.0;

@override
  void initState() {
  _scrollController.addListener(_onScroll);
  bloc = BlocProvider.of<PopularBloc>(context );
  bloc.add(Fetch_Popular());
    super.initState();
  }
  @override
  void dispose() {
    _scrollController.dispose();
     bloc.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
   return new BlocBuilder<PopularBloc , PopularStates>(
      builder: (context , state){
        if(state is PopularInitialState){
          return InitialStateScreen();
        }
        if(state is PopularErrorState){
          return new Center(child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Text("May be No Internet To Connection Please Check Your Connection and TryAgin" ,
                style: TextStyle(color: Colors.red.shade900 , fontSize: 16), textAlign: TextAlign.center,),
              new Text(state.massage),
            ],));
        }
        if(state is SuccessStatePopular){
          if (state.populars.isEmpty){
           return const Center(child: Text("No data"),);
         }
         return new ListView.builder(
           itemBuilder: (context ,int index){
               return index >= state.populars.length ?
                   BottomLoader() :
                   PostWigdet(post: state.populars[index],);
             },
           itemCount: state.hasReachedMax ?
           state.populars.length :
           state.populars.length +1,
           controller: _scrollController,
             );
        }
          return const Center(child: Text("SomeThing wrong"),);
      });
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      bloc.add(Fetch_Popular());
    }
  }


  }
class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment:  Alignment.center,
      child:new  Center(
        child: new SizedBox(
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
        child: new  Padding(
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
              new Container(
                padding: const EdgeInsets.only(top: 10 , bottom: 10),
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
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    new Icon(Icons.person , color: Colors.black,),
                    new Expanded(
                      child: new Text(post.author !=null ?  post.author : "Loading...",
                        style: TextStyle(color:Colors.white , fontSize: 16 ,fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              new Text(post.title != null ? post.title: "Loading"
                ,style: TextStyle( fontSize: 18 , fontWeight: FontWeight.bold , color: Colors.black),
                textAlign: TextAlign.center,),
             const  SizedBox(height: 10,),
              new Padding(
                padding: const EdgeInsets.only(bottom: 8,top: 8),
                child: new Text(post.content != null ? post.content : "Loading",
                  style: TextStyle( fontSize: 16 ,color: Colors.black54),
                  textAlign: TextAlign.start,),

              ),
              const SizedBox(height: 10,),
              new Padding(
                padding: const EdgeInsets.only(bottom: 8,top: 8),
                child: Text(post.publishedAt != null ? timeAgo(DateTime.parse(post.publishedAt))
                    : "Loading",
                  style: TextStyle( fontSize: 16 ,color: Colors.black , fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,),

              ),
             new  SizedBox(width: double.infinity, height: 1, child: Container(color: Colors.red.shade900,) )
              ,new Padding(
                padding: const EdgeInsets.all(8.0),
                child:new  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      elevation: 3,
                      shadowColor: Colors.grey,
                      color: Colors.white,
                      child:new  FlatButton(onPressed: (){}, child: Text("COMMENT" ,
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
                          child: FlatButton(onPressed: (){}, child: Text("SHARE" ,
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
                          child: new FlatButton(onPressed: (){
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



