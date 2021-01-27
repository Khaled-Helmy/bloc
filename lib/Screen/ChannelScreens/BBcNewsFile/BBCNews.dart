import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:news_app/Bloc/HomeBloc/TopStoriesBloc/TopStoriesBloc.dart';
import 'package:news_app/Bloc/HomeBloc/TopStoriesBloc/TopStoriesEvents.dart';
import 'package:news_app/Bloc/HomeBloc/TopStoriesBloc/TopStoriesStates.dart';
import 'package:news_app/Screen/StateScreen/StateScreen.dart';

class BbcNewsScreen extends StatefulWidget {
  @override
  _BbcNewsScreenState createState() => _BbcNewsScreenState();
}

class _BbcNewsScreenState extends State<BbcNewsScreen> {

  TopStoriesBloc bloc ;
  TextStyle headLine = TextStyle(fontSize: 16 , fontWeight: FontWeight.bold , color: Colors.black);
  TextStyle contentText  = TextStyle(fontSize: 14 , fontWeight: FontWeight.w700 , color: Colors.black54);
  Color colorCard = Colors.red.shade900;
  @override
  void initState() {
    bloc = BlocProvider.of<TopStoriesBloc>(context);
    bloc.add(TopStories_Fetch_HeadLine_BBcNews());
    super.initState();
  }
  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  new BlocBuilder< TopStoriesBloc , TopStoriesStates>(
      builder: (context , state){
        if(state is TopStoriesInitialState){
          return InitialStateScreen();
        }else if (state is TopStoriesLoadingState){
          return LoadingStateScreen();
        }else if (state is TopStories_SuccessState){
          return GridView.builder(
            scrollDirection: Axis.vertical,
            itemCount: state.articles.articles.length,
            gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 320 ,
              childAspectRatio: 1/2 ,
              crossAxisSpacing: 5,
              mainAxisSpacing: 2,)
            ,itemBuilder: (_ , postion){
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)
                        , bottomLeft: Radius.circular(20) , bottomRight: Radius.circular(20)),
                    side: BorderSide(color: Colors.black54 , width: 1.0 , style: BorderStyle.solid)
                ),
                elevation: 4,
                shadowColor: Colors.red.shade900,

                child: Column(
                  children: [
                    Container(
                      width: 320,
                      height: 260,
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(40) , topRight: Radius.circular(40)),
                          child: Image.network(state.articles.articles[postion].urlToImage,fit: BoxFit.cover,)),
                    ),
                    SizedBox(height: 10, child: Container(color: Colors.red.shade900),),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20 , right: 8 , left: 8),
                        child: Column(
                          children: [
                            Text(state.articles.articles[postion].title , style: headLine, textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            );
          },
          );
        }else
          return Center(child: Text("Error"),);
      },
    );
  }


}


