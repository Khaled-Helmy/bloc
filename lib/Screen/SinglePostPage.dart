import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Bloc/FavoriteBlocFile/FavoriteBloc.dart';
import 'package:news_app/Bloc/FavoriteBlocFile/FavoriteEvents.dart';

import 'package:news_app/Models/BaseNews.dart';
import 'package:news_app/Models/FavoriteModel.dart';
import 'package:news_app/utilties/Handle_DateTime.dart';
import 'package:url_launcher/url_launcher.dart';

class SinglePostPage extends StatefulWidget {
  final BaseNews news ;
  SinglePostPage(this.news);

  @override
  _SinglePostPageState createState() => _SinglePostPageState();
}

class _SinglePostPageState extends State<SinglePostPage> {
  FavoriteBloc bloc;
  bool fv_bool = false ;
  @override
  void initState() {
   bloc = BlocProvider.of<FavoriteBloc>(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (context)=>
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  floating: true,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(widget.news.urlToImage),fit: BoxFit.cover)
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white ,
                              Colors.transparent
                            ] ,
                            stops: [
                              0.1 ,
                              0.9,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.only(bottom: 15 , left: 15 , right: 20 ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(widget.news.author ,
                              style: TextStyle(color: Colors.red.shade900 , fontWeight: FontWeight.bold , fontSize: 28),),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(icon: Icon((fv_bool == true)?
                                    Icons.star:
                                Icons.star_border),
                                    color: Colors.deepOrange.shade600, iconSize: 35,
                                    onPressed: (){
                                      var fvIteam =  bloc.state.map((e) => e.title) ;
                                      if(bloc.state.isNotEmpty && bloc.state.length > 0 ){
                                        if( fv_bool == true){
                                          return Scaffold.of(context).showSnackBar(SnackBar(content: Text("Is already added")));
                                        }else
                                          setState(() {
                                            if(fv_bool== false){
                                              fv_bool = true ;
                                            }
                                            fv_bool = false ;
                                          });
                                          bloc.add(FavoriteEvents.add
                                            (FavoriteModel(title: widget.news.title , content: widget.news.content,
                                              urlToImage: widget.news.urlToImage  , publishedAt: widget.news.publishedAt ,
                                              author: widget.news.author , description: widget.news.description ,
                                              url: widget.news.url )),);
                                        return Scaffold.of(context).showSnackBar(SnackBar(content: Text("added Favorite Agin")));
                                      }else
                                        setState(() {
                                          if(fv_bool == true){
                                            fv_bool = false ;
                                          }
                                          fv_bool = true ;
                                        });
                                        bloc.add(FavoriteEvents.add
                                          (FavoriteModel(title: widget.news.title , content: widget.news.content,
                                            urlToImage: widget.news.urlToImage  , publishedAt: widget.news.publishedAt ,
                                            author: widget.news.author , description: widget.news.description ,
                                            url: widget.news.url )),);
                                      return Scaffold.of(context).showSnackBar(SnackBar(content: Text("Added To Favorite")));

                                    }),
                                Text("Add Favorite" ,
                                  style: TextStyle(color: Colors.black54,
                                      fontWeight: FontWeight.w600 , fontSize: 16),),
                              ],
                            ),
                          ],
                        ),),
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate((context,postion){
                      if(postion == 0){
                        return darwTitle();
                      }
                      else if(postion == 1) {
                        return darwPostDescription();
                      }
                      else if(postion == 2) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: double.infinity, height: 1, child: Container(color: Colors.grey,),),
                              Padding(
                                padding: const EdgeInsets.only(top: 14 , bottom: 14),
                                child: Container(
                                  child: Text("Content" ,
                                    style: TextStyle(fontWeight: FontWeight.bold , color: Colors.red.shade900 , fontSize: 18),
                                    textAlign: TextAlign.start,),
                                ),
                              ),
                              SizedBox(width: double.infinity, height: 1, child: Container(color: Colors.grey,),),
                            ],
                          ),
                        );

                      }
                      else if(postion == 3) {
                        return  darwPostContent();
                      }else if (postion == 4){
                        return darwPostDate();
                      }
                      else
                        return darwPostUrl();
                    } , childCount: 6
                    )
                ),

              ],

            ),
      ),
    );
  }
  FavoriteIteam (BuildContext context){
    var fvIteam =  bloc.state.map((e) => e.title) ;
    if(bloc.state.isNotEmpty && bloc.state.length > 0 ){
      if( fvIteam == widget.news.title){
        return Scaffold.of(context).showSnackBar(SnackBar(content: Text("Is already added")));
      }else
        bloc.add(FavoriteEvents.add
          (FavoriteModel(title: widget.news.title , content: widget.news.content,
            urlToImage: widget.news.urlToImage  , publishedAt: widget.news.publishedAt ,
            author: widget.news.author , description: widget.news.description ,
            url: widget.news.url )),);
      return Scaffold.of(context).showSnackBar(SnackBar(content: Text("added first")));
    }else
      bloc.add(FavoriteEvents.add
        (FavoriteModel(title: widget.news.title , content: widget.news.content,
          urlToImage: widget.news.urlToImage  , publishedAt: widget.news.publishedAt ,
          author: widget.news.author , description: widget.news.description ,
          url: widget.news.url )),);
    return Scaffold.of(context).showSnackBar(SnackBar(content: Text("added secound")));
  }
  Widget darwTitle() {
    return Container(
      margin: EdgeInsets.only(left: 10 , right: 10 ,top: 12),
      width: double.infinity,
      child:(widget.news.title != null)? Text(widget.news.title ,
        style: TextStyle(fontSize: 22 , fontWeight: FontWeight.w900
            , color: Colors.black),):
      Text("Loading..."),
    );
  }

  Widget darwPostDescription() {
   return Container(
     padding: const EdgeInsets.all(10.0),
      child: (widget.news.description != null) ?
      Text(widget.news.description ,
        style: TextStyle(wordSpacing: 1.2 , letterSpacing: 1.2 ,height: 1.5 ,
            fontSize: 16 , fontWeight: FontWeight.w500),): Text("Loading..."),
    );
  }
  Widget darwPostContent() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child:(widget.news.content != null) ?
      Text(widget.news.content ,
        style: TextStyle(wordSpacing: 1.2 , letterSpacing: 1.2 ,height: 1.5 ,
            fontSize: 16 , fontWeight: FontWeight.w500),):Text("Loading..."),
    );
  }
  Widget darwPostUrl() {
    return    GestureDetector(
      onTap: ()=> launch(widget.news.url),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(8.0),
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
                colors: [
                  Colors.red.shade900 ,
                  Colors.redAccent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
            ),
          ),
          child: Text("READ MORE" ,style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 18), textAlign: TextAlign.center,),
        ),
      ),
    );
  }
  Widget darwPostDate() {
    return Container(
      padding: const EdgeInsets.only(left: 8 , top: 8 , bottom: 8 ),
      width: 100,
      height: 60,
      child: Card(
        elevation: 5,
        shadowColor: Colors.black54,
        child: (widget.news.publishedAt != null) ?
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(timeAgo(DateTime.parse(widget.news.publishedAt)) ,
            style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w700 , color: Colors.red.shade900),
           textAlign: TextAlign.start,),
        )
            :Text("Loading....."),
      ),
    );
  }

}
