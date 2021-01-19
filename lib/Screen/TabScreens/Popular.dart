import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Bloc/HomeBloc/PopularBloc/PopularBloc.dart';
import 'package:news_app/Bloc/HomeBloc/PopularBloc/PopularEvents.dart';
import 'package:news_app/Bloc/HomeBloc/PopularBloc/PopularStates.dart';
import 'package:news_app/Models/ArticelsModel.dart';
import 'package:news_app/Screen/StateScreen/StateScreen.dart';
import 'package:news_app/utilties/Handle_DateTime.dart';

import '../SinglePostPage.dart';

class Popular extends StatefulWidget {
  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  PopularBloc bloc ;
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  @override
  void initState() {
   _scrollController.addListener(_onScroll);
    bloc = BlocProvider.of<PopularBloc>(context);
    bloc.add(Fetch_Popular());
    super.initState();
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularBloc , PopularStates>(
        builder: (context , state){
          if(state is PopularInitialState){
            return InitialStateScreen();
          }
          if(state is PopularErrorState){
            return Center(child: Text(state.massage),);
          }
          if(state is SuccessStatePopular){
            if (state.populars.isEmpty){
              return Center(child: Text("No data"),);
            }
            return ListView.builder(
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
          return Center(child: Text("SomeThing wrong"),);
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
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(bottom: 8,top: 8),
                child: Text(post.publishedAt != null ? timeAgo(DateTime.parse(post.publishedAt))
                    : "Loading",
                  style: TextStyle( fontSize: 16 ,color: Colors.black , fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,),

              ),
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
