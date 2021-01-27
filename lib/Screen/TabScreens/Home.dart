import 'package:flutter/material.dart';
import 'package:news_app/Screen/TabScreens/HomeFlie/HeadLineHome.dart';
import 'package:news_app/Screen/TabScreens/HomeFlie/SourcesHome.dart';
import 'package:news_app/Screen/TabScreens/HomeFlie/TopStoriesHome.dart';
import 'package:news_app/Screen/TabScreens/HomeFlie/UpdateRecentHome.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new Scaffold(
        body: new SingleChildScrollView(
          physics: ScrollPhysics(),
          child: new Column(
            children: [
              new HeadLineHome(),
              Line(),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child:new  Row(
                  children: [
                    new Text(
                      "T",
                      style: TextStyle(
                        color: Colors.red.shade900,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    new Text(
                      "op",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    new Text(
                      "C",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    new Text(
                      "hannel",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              new SourcesHome(),
              const SizedBox(
                height: 10,
              ),
              new Divider(
                height: 20.0,
                color: Colors.red.shade900,
              ),
              const SizedBox(
                height: 10,
              ),
              new TopStoriesHome(),
              const SizedBox(
                height: 10,
              ),
              new Divider(
                height: 20.0,
                color: Colors.red.shade900,
              ),
              const SizedBox(
                height: 10,
              ),
              new UpdateRecentHome(),
            ],
          ),
        ),
      ),
    );
  }

  Widget Line() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:new SizedBox(
        width: double.infinity,
        height: 1,
        child: new Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red.shade900,
                Colors.redAccent,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
    );
  }
}
