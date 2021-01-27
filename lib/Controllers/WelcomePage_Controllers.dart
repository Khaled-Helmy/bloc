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
        "This application gives you the powers to know information about all the news that occurs around you in the world"
            " , so one of its requirements is to be connected to the Internet ",
        Lottie.asset(
            "assets/animation/scoundnews.json",
            fit: BoxFit.fill , height: 300 , width: double.infinity),
      ),
    );
    list_welcomePage.add(
      WelcomePageModel(
        "LETS GO",
        "You will always be fully aware of new news from political people such as Trump, the famous channels such as the BBC, "
            "currency news and trade in some countries such as America and Germany, "
            "and you can also add what you want to your favorite page and search for specific news if you want."
         "We are glad you enjoy our app.",
        Lottie.asset("assets/animation/threednews.json",
            fit: BoxFit.fill , width: 300 , height: 300 ),
      ),
    );
    return list_welcomePage ;

  }
}