import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Bloc/Articles/BitConeBloc/BitConeBloc.dart';
import 'package:news_app/Bloc/Articles/BitConeBloc/BitConeEvents.dart';
import 'package:news_app/Bloc/Articles/BitConeBloc/BitConeStates.dart';

import 'package:news_app/Models/ArticelsModel.dart';
import 'package:news_app/Screen/SinglePostPage.dart';
import 'package:news_app/Screen/StateScreen/StateScreen.dart';
import 'package:news_app/utilties/Handle_DateTime.dart';



class BitConeScreen extends StatefulWidget {
  @override
  BitConeScreenState createState() => BitConeScreenState();
}
class BitConeScreenState extends State<BitConeScreen> {
BitConeBloc bloc ;
final _scrollController = ScrollController();
final _scrollThreshold = 200.0;


@override
  void initState() {
  _scrollController.addListener(_onScroll);
  bloc = BlocProvider.of<BitConeBloc>(context );
  bloc.add(Fetch_Popular_BitCons());
    super.initState();

  }
  @override
  void dispose() {
   bloc.close();
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: BlocBuilder<BitConeBloc , BitConeStates>(
        builder: (context , state){
          if(state is BitConeInitialState){
            return InitialStateScreen();
          }
          if(state is BitConeErrorState){
            return Center(child: Text(state.massage),);
          }
          if(state is SuccessStateBitCone){
           if (state.bitcones.isEmpty){
             return Center(child: Text("No data"),);
           }
           return ListView.builder(

               itemBuilder: (context ,int index){
                 return index >= state.bitcones.length ?
                     BottomLoader() :
                     PostWigdet(post: state.bitcones[index],);
               },
             itemCount: state.hasReachedMax ?
             state.bitcones.length :
             state.bitcones.length +1,
             controller: _scrollController,
               );
          } else
            return Center(child: Text("Error"),);
        }),
  );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      bloc.add(Fetch_Popular_BitCons());
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
    return GestureDetector(
      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (contex)=> SinglePostPage(post))),
      child: Padding(
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
                  child: Padding(
                    padding: const EdgeInsets.only(left:10 , right: 10),
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
                ),
                SizedBox(height: 10,),
                drawBottomCard(),

                SizedBox(height: 10,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget drawBottomCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (post.title != null) ?
          Text(post.title , style:
          TextStyle(color: Colors.black , fontWeight: FontWeight.bold , height: 1.4 , fontSize: 24),) :
          Text("Loading...."),
          SizedBox(height: 10,),
          (post.publishedAt != null) ?
          Card(
            elevation: 4,
            shadowColor: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(timeAgo(DateTime.parse(post.publishedAt)) ,
                style:TextStyle(color: Colors.red.shade900 , fontWeight: FontWeight.bold ,fontSize: 14),),
            ),
          )
              :Text("Loading...."),
        ],
      ),
    );
  }
}



