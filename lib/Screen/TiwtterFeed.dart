import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/Bloc/BottomNavBloc.dart';
import 'package:news_app/Models/ArticlesModels/ArticelsModel.dart';
import 'package:news_app/Models/ArticlesModels/ArticleResponse.dart';
import 'package:news_app/Screen/SearchScreen.dart';
import 'package:news_app/Screen/SinglePostPage.dart';

import 'package:news_app/SharedUi/NavigationDarwer.dart';
import 'package:news_app/utilties/Handle_DateTime.dart';
class TiwtterFeed extends StatefulWidget {
  @override
  _TiwtterFeedState createState() => _TiwtterFeedState();
}

class _TiwtterFeedState extends State<TiwtterFeed> {
  BottomNavBloc _bottomNavBloc ;
  @override
  void initState() {
    _bottomNavBloc = BottomNavBloc();

    super.initState();
  }
  @override
  void dispose() {
    _bottomNavBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar :AppBar(
        title: Text("Tiwtter Feed"),
        centerTitle: false,
      ),
      drawer: NavigationDarwer(),
      body:SafeArea(
        child: StreamBuilder<IteamBottomNav>(
          stream: _bottomNavBloc.IteamStream,
          initialData: _bottomNavBloc.defultIteam,
          builder: (cotext , AsyncSnapshot<IteamBottomNav> snapshot){
            switch(snapshot.data){
              case IteamBottomNav.Home :
                return SearchScreen();
               break;
              case IteamBottomNav.Exploer :
              return  ListView.builder(
                  itemBuilder: (context , postion){
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Title_Card(),
                            Body_card(),
                            Container(
                              margin:EdgeInsets.only(top: 24 ),
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey,
                            ),
                            Bottom_Card(),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: 20,
                );
              break ;
              case IteamBottomNav.Popular :
              return  ListView(
                children: [
                ],
              );
              break;
            }
        },

        ),
      ),
      bottomNavigationBar: StreamBuilder(
        stream: _bottomNavBloc.IteamStream,
        initialData: _bottomNavBloc.defultIteam,
        builder: (BuildContext context , AsyncSnapshot<IteamBottomNav> snapshot){
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(30) , topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(color: Colors.red[100] ,spreadRadius: 2 , blurRadius: 10.0)
              ]
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.red.shade900,
                iconSize: 20,
                unselectedItemColor: Colors.white,
                unselectedFontSize: 10,
                selectedFontSize: 22,
                selectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                currentIndex: snapshot.data.index,
                onTap: _bottomNavBloc.chooseIteam,
                items: [
                  BottomNavigationBarItem(
                      icon:Icon(Icons.home_filled) ,
                   activeIcon: Icon(Icons.home_outlined),
                   title: Padding(
                     padding: EdgeInsets.only(top: 5),
                     child: Text("Home"),
                   )),
                  BottomNavigationBarItem(
                      icon:Icon(Icons.explicit_rounded) ,
                      activeIcon: Icon(Icons.explicit_outlined),
                      title: Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text("Explore"),
                      )),
                  BottomNavigationBarItem(
                      icon:Icon(Icons.account_balance_wallet_rounded) ,
                      activeIcon: Icon(Icons.account_balance_wallet_outlined),
                      title: Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text("Popular"),
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );

  }

  Widget drawHeadLine(ArticleResponse articleResponse) {
    List<ArticleModel> articles = articleResponse.articles;
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          enlargeCenterPage: false ,
          height: 200 ,
          viewportFraction:0.9 ,
        ),
        items: IteamHeadLine(articles),

      ) ,
    );
  }

  IteamHeadLine(List<ArticleModel> articles) {
    return articles.map((article) =>
        GestureDetector(
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> SinglePostPage(article))),
          child: Container(
            padding: EdgeInsets.all(12),
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: article.urlToImage != null ?
                        NetworkImage(article.urlToImage)
                            : AssetImage("assets/images/background.jpg"),

                      )
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter ,
                      end: Alignment.topCenter,
                    stops: [
                      0.1 ,
                      0.9,
                    ],
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.white.withOpacity(0.0),
                      ]
                    ),

                  ),
                ),
                Positioned(
                    bottom: 30.0,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      width: 250,
                      child: Column(
                        children: [
                        Text(article.title ,
                          style: TextStyle(fontWeight: FontWeight.bold , fontSize: 16 , color: Colors.white , height: 1),)

                        ],
                      ),
                    )),
                Positioned(bottom: 10.0,
                    left: 10.0,
                    child: Text(article.sourceModel.name  ,
                      style: TextStyle(fontSize: 14 , color: Colors.red.shade900  , fontWeight: FontWeight.bold),)),
               Positioned(
                 right: 10,
                  bottom: 10,
                   child: Text(timeAgo(DateTime.parse(article.publishedAt)) , style: TextStyle(color: Colors.white),))
              ],
            ),
          ),
        )).toList();
  }



}
Widget Title_Card() {
  return Row(
    children: [

     CircleAvatar(
       backgroundImage: ExactAssetImage('assets/images/young.png'),
       radius: 24,
     ),
      SizedBox(width: 12,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Khaled Helmy" , style: TextStyle(color: Colors.grey.shade700 ,fontSize: 18 , fontWeight: FontWeight.w700 ),)
              ,Text("@khaled_19997" , style: TextStyle(color: Colors.grey ,fontSize: 16 ),)

            ],
          )
          ,Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text("feb , 12 May 2017 . 14:30 " , style: TextStyle(color:Colors.grey),),
          )
        ],
      )
    ],
  );
}
Widget Body_card() {
  return Padding(
    padding: const EdgeInsets.only(left:62 , right: 8),
    child: Container(
      child: Text("we are work in the same company and make our projects to sulotion a problem in world" , maxLines: 2 , style: TextStyle(fontWeight: FontWeight.w500 , height: 1.6),),
    ),
  );
}
Widget Bottom_Card() {
  var counter_repeat = 25 ;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
   children: [
     Row(
       children: [
         IconButton(icon: Icon(Icons.repeat), color:Colors.orange,onPressed: (){ counter_repeat +=1; }),
         Text("$counter_repeat")
       ],
     ),
     Row(
       children: [
         FlatButton(onPressed: (){}, child: Text("SHARE" , style: TextStyle(color: Colors.orange),)),
         FlatButton(onPressed: (){}, child: Text("OPEN" , style: TextStyle(color: Colors.orange),)),
       ],
     )

   ],
  );
}




