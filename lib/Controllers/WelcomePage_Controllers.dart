import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/Models/WelcomePageModel.dart';

class WelcomePageController {
  List<WelcomePageModel> list_welcomePage;
  List<WelcomePageModel> addIteams_welcomePage() {
    list_welcomePage =  List<WelcomePageModel>();
    list_welcomePage.add(
     WelcomePageModel(
        "WElCOME",
        "this application allow to show the news in world to you can be active in life",
         Lottie.asset("assets/animation/firstnews.json", fit: BoxFit.fill , height: 300 , width: double.infinity),
      ),
    );
    list_welcomePage.add(
      WelcomePageModel(
        "NEWS",
        "this application allow to show the news in world to you can be active in life , if you do not need show more screens push get started ",
        Lottie.asset(
            "assets/animation/scoundnews.json",
            fit: BoxFit.fill , height: 300 , width: double.infinity),
      ),
    );
    list_welcomePage.add(
      WelcomePageModel(
        "LETS GO",
        "you are now a clint in application , this app provided a new news in Live , general news in Poplur  and top stories in Top Stories ",
        Lottie.asset("assets/animation/threednews.json",
            fit: BoxFit.fill , width: 300 , height: 300 ),
      ),
    );
    return list_welcomePage ;

  }
}