import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:news_app/Bloc/FavoriteBlocFile/FavoriteBloc.dart';
import 'package:news_app/Bloc/FavoriteBlocFile/FavoriteEvents.dart';
import 'package:news_app/Models/FavoriteModel.dart';
import 'package:news_app/Screen/SinglePostPage.dart';
import 'package:news_app/Screen/Slidable/SlidableFavorite.dart';
import 'package:news_app/Screen/StateScreen/StateScreen.dart';
import 'package:news_app/utilties/Handle_DateTime.dart';



class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}


class _FavoriteState extends State<Favorite> {
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocConsumer<FavoriteBloc ,List<FavoriteModel>>(
        buildWhen: (List<FavoriteModel> prev ,List<FavoriteModel> current){

            return true ;
        },
        listenWhen: (List<FavoriteModel> prev ,List<FavoriteModel> current){
           return true ;
        },
        builder: (context ,List<FavoriteModel> fv_list){
          return (fv_list.isEmpty || fv_list ==null) ?
          Center(child: Container(child: Text("No Favorite Iteam" ,
            style: TextStyle(fontSize: 24 , fontWeight: FontWeight.bold , color: Colors.red.shade900),),),):
          ListView.builder(
              itemCount: fv_list.length,
              shrinkWrap: true,
              itemBuilder: (context , index){
                return Padding(
                  padding: const EdgeInsets.only(top: 12 , bottom: 12),
                  child: Card(
                    elevation: 6.0,
                    shadowColor: Colors.red,
                    child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200,
                        child: (fv_list[index].urlToImage != null) ?
                        Image.network(fv_list[index].urlToImage , fit: BoxFit.cover):
                        Container(child:LoadingIteamScreen(),),
                      ),
                      SizedBox(height:10,),
                      (fv_list[index].author != null)?
                      topCardFavorite(fv_list , index):
                      Text("Loading...."),
                      SizedBox(height:10,),
                      BottomCardFavorite(fv_list , index),
                      SizedBox(height:10,),
                      SizedBox(height:1, width: double.infinity ,
                        child: Container(color: Colors.red.shade900,),),
                      SlidableFavorite(
                        child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
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
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Silde here" ,
                              style: TextStyle(color: Colors.black ,
                                  fontWeight: FontWeight.bold , fontSize: 20),),
                            Icon(Icons.arrow_left ,size: 25, color: Colors.white70,)
                          ],
                        ),
                      ),
                      onDismissed: (action)=>
                          dismssedSlideItem(context , index , action , fv_list),)

                    ],
                  ),),
                );
              });
        },
        listener: (BuildContext context , fv_list){
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Done")));
        },
      ),
    );
  }

  Widget topCardFavorite(fv_list , index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 300,
        padding: EdgeInsets.all(8.0),
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
            Icon(Icons.person , color: Colors.white70,),
            Text(fv_list[index].author ,
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold , color:Colors.white70),),
            Icon(Icons.star , color: Colors.orange,),
          ],
        ),
      ),
    );
  }

  Widget BottomCardFavorite(List<FavoriteModel> fv_list, int index) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (fv_list[index].content != null) ?
        Text(fv_list[index].content , style:
        TextStyle(color: Colors.black , fontWeight: FontWeight.w600 , height: 1.4),) :
        Text("Loading...."),
        SizedBox(height: 10,),
        (fv_list[index].publishedAt != null) ?
        Card(
          elevation: 4,
          shadowColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(timeAgo(DateTime.parse(fv_list[index].publishedAt)) ,
              style:TextStyle(color: Colors.red.shade900 , fontWeight: FontWeight.bold ,fontSize: 14),),
          ),
        )
            :Text("Loading...."),
      ],
    ),
  );
  }



}

void dismssedSlideItem(BuildContext context, int index, SlideeAction action ,List<FavoriteModel> fvlist) {
 switch(action){
   case SlideeAction.Remove:
     if(fvlist.contains(fvlist[index])){
       BlocProvider.of<FavoriteBloc>(context).add(FavoriteEvents.remove(index));
       Scaffold.of(context).showSnackBar(SnackBar(content: Text("Deleted")));

     }else
       Scaffold.of(context).showSnackBar(SnackBar(content: Text("This iteam already not found in your favorite list")));
     break ;
   case SlideeAction.View :
     Scaffold.of(context).showSnackBar(SnackBar(content: Text("Let's Go")));
     Navigator.push(context,MaterialPageRoute(builder: (context)=>SinglePostPage(fvlist[index])));

     break ;
     
 }



}
