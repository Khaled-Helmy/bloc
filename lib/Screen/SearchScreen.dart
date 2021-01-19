import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/Bloc/SearchBloc.dart';
import 'package:news_app/Models/ArticelsModel.dart';
import 'package:news_app/Models/ArticleResponse.dart';
import 'package:news_app/Screen/SinglePostPage.dart';
import 'package:news_app/Screen/StateScreen/StateScreen.dart';
import 'package:news_app/utilties/Handle_DateTime.dart';
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
 final _sreachController = TextEditingController();

 @override
  void initState() {
    super.initState();
    searchBloc..search("");
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _sreachController,
              style: TextStyle(
                color: Colors.black ,
                fontSize: 16 ,
              ),
             onChanged: (changed){
                if(_sreachController != null){
                  searchBloc..search(_sreachController.text);
                  print("change");
                }
                print("No change");

             },
              decoration: InputDecoration(
                filled: false ,
                floatingLabelBehavior: FloatingLabelBehavior.never ,
                fillColor: Colors.grey[100],
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black54
                    ),
                    borderRadius: BorderRadius.circular(30)
                ),
                suffixIcon: _sreachController.text.length > 0 ? 
                    IconButton(icon: Icon(Icons.send , color: Colors.black,), onPressed: (){
                      setState(() {
                        FocusScope.of(context).requestFocus(FocusNode());
                        _sreachController.clear();
                        searchBloc..search(_sreachController.text);
                      });
                    })

                    : IconButton(icon: Icon(Icons.search_off_outlined ,color: Colors.red.shade900,) ,),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey[100].withOpacity(0.3)
                  ),
                  borderRadius: BorderRadius.circular(30)
                ),
                contentPadding: EdgeInsets.all(8),
                labelText: "Search..",
                hintStyle: TextStyle(
                  color: Colors.red.shade900,
                  fontSize: 14 ,
                  fontWeight: FontWeight.w500
                ),
                labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14 ,
                    fontWeight: FontWeight.w500
                ),
              ),
              autocorrect: false,
              autovalidate: true,
            ),
          ),
          Expanded(
              child: StreamBuilder<ArticleResponse>(
                stream: searchBloc.subject.stream ,
                builder: (context ,AsyncSnapshot<ArticleResponse> snapshot ){
                   if(snapshot.hasData){
                     if(snapshot.data.error != null && snapshot.data.error.length > 0){
                       return Center(child: Text(snapshot.error),);
                     }else
                       return (snapshot.data != null ) ?
                       drawListSearch(snapshot.data):
                       Center(child: Container(child: Text("Try Agin"),)) ;

                   }else if (snapshot.hasError){
                     return Center(child: Text(snapshot.error),);
                   }else
                     return Center(child: Container(child: Text("Enter Name of Company"),));


                },
              )),

        ],
      ),
    );
  }

  Widget drawListSearch(ArticleResponse data) {
   List<ArticleModel> list = data.articles;
   if(list.length == 0 ){
     return  Center(child: Container(child: Text("No Iteam Please check your name" ,
       style: TextStyle(fontSize: 24 , fontWeight: FontWeight.bold , color: Colors.red.shade900),),));
   }
    else
      return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context , index){
            return GestureDetector(
              onTap: ()=> Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> SinglePostPage(list[index]))),
              child: Card(
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: list[index].urlToImage != null ?
                      Image.network(list[index].urlToImage , fit: BoxFit.cover,) :
                      Container(child: LoadingStateScreen() ,),
                    ),
                    SizedBox(width: 4, height: 100, child: Container(color: Colors.red.shade900,),),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (list[index].title != null) ?
                          Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Text(list[index].title ,
                                style: TextStyle(fontWeight: FontWeight.w400
                                    , color: Colors.black , fontSize: 16),)) :
                          Text("Loading"),
                          SizedBox(height: 20,),
                          (list[index].publishedAt != null) ?
                          Text(timeAgo(DateTime.parse(list[index].publishedAt)),
                          style: TextStyle(fontWeight: FontWeight.w800 , color: Colors.red.shade900),) :
                          Text("Loading"),
                        ],
                      ),
                    ),



                  ],
                ),
              ),
            );
          });
  }
}
