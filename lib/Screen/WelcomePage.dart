import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Controllers/WelcomePage_Controllers.dart';
import 'package:news_app/Models/WelcomePageModel.dart';
import 'package:news_app/Screen/HomePage.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with TickerProviderStateMixin {

  AnimationController _controller;
  List<WelcomePageModel> _list_welcomePage;
  WelcomePageController _welcomePageController = new WelcomePageController();
  ValueNotifier<int> _valueNotifier = new  ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   _list_welcomePage = _welcomePageController.addIteams_welcomePage();
    return new Scaffold(
      backgroundColor: Colors.red.shade900,
      body: new PageView.builder(
        itemBuilder: (context, index) {
          return new Stack(
            children: [
               new Padding(
                 padding: const EdgeInsets.only(top: 180),
                 child: new  ClipPath(
                   clipper:  ClipperController(),
                   child: new Container(
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: const BorderRadius.only(topLeft: Radius.circular(80)),
                     ),
                   ),
                 ),
               ),
              new Align(
                alignment: Alignment.topCenter,
                child: Transform.translate(
                  offset: const Offset(0,40),
                  child: new  Container(
                      child: _list_welcomePage[index].lottie),
                ),
              ),

              new Center(
                child: new Transform.translate(
                  offset: const Offset(0,90),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Text(
                        _list_welcomePage[index].Title,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                        textAlign: TextAlign.center,
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 8 , right: 4 , left: 4 , bottom: 4),
                        child: new Text(
                          _list_welcomePage[index].description,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              wordSpacing: 1.2),
                          textAlign: TextAlign.center,
                        ),
                      ),


                    ],
                  ),
                ),
              ),
              new Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 80),
                  child: pageIndicator(_list_welcomePage.length),
                ),
              ),
              new Align(
                alignment: Alignment.bottomCenter,
                child: new Padding(
                  padding: const EdgeInsets.only(right: 12, left: 12, bottom: 12),
                    child: Transform.translate(
                      offset: const Offset(-130 , -20),
                      child: new Container(
                        width: double.infinity,
                        height: 70,
                        child:  new FloatingActionButton(
                          backgroundColor: Colors.white,
                            elevation: 10.0,
                            child: new Text(
                              "GET STARTED",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.red.shade900),
                            ),
                            onPressed: () {
                            Navigator.of(context).push<HomePage>(
                                MaterialPageRoute(builder:(_)=> HomePage()
                                ));
                            }),
                      ),
                    ),

                ),
              ),
            ],
          );
        },
        onPageChanged: (index){
          _valueNotifier.value = index ;
        },
        itemCount: _list_welcomePage.length,
      ),
    );
  }
  Widget pageIndicator (int length ){
    return new PageViewIndicator(
      pageIndexNotifier: _valueNotifier,
      length: length,
      normalBuilder: (animationController, index) => Circle(
        size: 12.0,
        color: Colors.black26,
      ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.ease,
        ),
        child: new Circle(
          size: 12.0,
          color: Colors.red.shade900,
        ),
      ),
    );

  }
}

class ClipperController extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height);
    var controllPoint = Offset(size.width, size.height);
    var endPoint = Offset(size.width/2, size.height-200 );
    path.quadraticBezierTo(controllPoint.dx,
        controllPoint.dy,
        endPoint.dx,
        endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
  return  true ;
  }
}
