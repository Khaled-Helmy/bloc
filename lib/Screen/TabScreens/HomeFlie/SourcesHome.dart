import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Bloc/HomeBloc/SourciesBloc/SouriesBloc.dart';
import 'package:news_app/Bloc/HomeBloc/SourciesBloc/SouriesEvents.dart';
import 'package:news_app/Bloc/HomeBloc/SourciesBloc/SouriesStates.dart';
import 'package:news_app/Models/SourceModel.dart';
import 'package:news_app/Models/SourceResponse.dart';
import 'package:news_app/Screen/StateScreen/StateScreen.dart';

class SourcesHome extends StatefulWidget {
  @override
  _SourcesHomeState createState() => _SourcesHomeState();
}

class _SourcesHomeState extends State<SourcesHome> {
  SourciesBloc bloc ;
  @override
  void initState() {
    bloc = BlocProvider.of<SourciesBloc>(context);
    bloc.add(Fetch_Sources_Home());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  
    return BlocBuilder<SourciesBloc , SourciesStates>(
      cubit: bloc,
        builder: (context ,state){
          if(state is SourciesInitialState){
            return InitialStateScreen();
          }else if (state is SourciesLoadingState){
            return LoadingStateScreen();
          }else if (state is SuccessState_Sources_Home){
            return  drawSourcesList(state.sources);
          }else if (state is SourciesErrorState){
            return Center(child: Text(state.massage),);
          }else
            return Container(child: Text("error"),);

        });
  }

  Widget drawSourcesList(SourceResponse sourceResponse) {
    List<SourceModel> sources = sourceResponse.sources;
    if(sources.length == 0 ){
      return  Center(child: Container(child: Text("No Iteam" ,
        style: TextStyle(fontSize: 24 , fontWeight: FontWeight.bold , color: Colors.red.shade900),),),);
    }else
      return Container(
        height: 140,
        child: ListView.builder(
            itemCount: sources.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: ScrollPhysics(),
            itemBuilder: (context , index){
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)
                    , bottomLeft: Radius.circular(8) , bottomRight: Radius.circular(8)),
                side: BorderSide(color: ColorsRandom() , width: 1.0 , style: BorderStyle.solid)
            ),
            elevation: 4,
            shadowColor: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle ,
                    ),
                    child: ImagesRandom(),
                  ),
                  (sources[index].name != null)?
                  Text(sources[index].name
                    ,style: TextStyle(fontWeight: FontWeight.bold , fontSize: 16), ):
                  Text("Loading.."),
                  (sources[index].country != null)?
                  Text(sources[index].country
                    ,style: TextStyle(fontWeight: FontWeight.w700 , fontSize: 14 , color: Colors.grey), ):
                  Text("Loading.."),
                  (sources[index].category != null)?
                  Text(sources[index].category
                    ,style: TextStyle(fontWeight: FontWeight.bold , fontSize: 12 , color: Colors.red.shade900), ):
                  Text("Loading.."),
                ],
              ),
            ),
          );
        }),
      );
  }

 Widget ImagesRandom (){
    List<String> imges = [
      "assets/images/background.jpg",
      "assets/images/abclogo.jpg",
      "assets/images/ap.jpg",
      "assets/images/bbcnew.jpg",
      "assets/images/aftenposten.png",
      "assets/images/aljaz.png",
      "assets/images/arynews.png",
    ];
    int max = imges.length-1;
    int min = 0 ;
    var random = Random();
    int r = min + random.nextInt(max - min);
    String name_image = imges[r].toString();
    return  Image.asset(name_image , fit: BoxFit.cover,);
}
  Color ColorsRandom (){
    List<Color> colors = [
      Colors.red.shade900,
      Colors.blue.shade900,
      Colors.green.shade900,
      Colors.deepOrange,
      Colors.deepPurpleAccent,
      Colors.cyanAccent,
      Colors.greenAccent,
    ];
    int max = colors.length-1;
    int min = 0 ;
    var random = Random();
    int r = min + random.nextInt(max - min);
    Color name_color = colors[r];
    return  name_color;
  }


}
