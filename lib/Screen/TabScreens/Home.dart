import 'package:flutter/material.dart';
import 'package:news_app/Screen/TabScreens/HomeFlie/HeadLineHome.dart';
import 'package:news_app/Screen/TabScreens/HomeFlie/SourcesHome.dart';
import 'package:news_app/Screen/TabScreens/HomeFlie/TopStoriesHome.dart';
import 'package:news_app/Screen/TabScreens/HomeFlie/UpdateRecentHome.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              HeadLineHome(),
              Line(),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Text(
                      "T",
                      style: TextStyle(
                        color: Colors.red.shade900,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      "op",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "C",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Text(
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
              SourcesHome(),
              const SizedBox(
                height: 10,
              ),
              Divider(
                height: 20.0,
                color: Colors.red.shade900,
              ),
              const SizedBox(
                height: 10,
              ),
              TopStoriesHome(),
              const SizedBox(
                height: 10,
              ),
              Divider(
                height: 20.0,
                color: Colors.red.shade900,
              ),
              const SizedBox(
                height: 10,
              ),
              UpdateRecentHome(),
            ],
          ),
        ),
      ),
    );
  }

  Widget Line() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 1,
        child: Container(
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
