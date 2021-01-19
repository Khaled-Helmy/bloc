import 'package:flutter/material.dart';
enum PopUpMenuE {
  Help ,
  Options,
  Profile
}
class PopupMenu extends StatefulWidget {
  @override
  _PopupMenuState createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton (
      onSelected: (PopUpMenuE result) { setState(() {
        PopUpMenuE _select = result ;
      });},
      itemBuilder: (context) => <PopupMenuEntry<PopUpMenuE>>[
        PopupMenuItem(child: Text("Help") , value: PopUpMenuE.Help,),
        PopupMenuItem(child: Text("Options") , value: PopUpMenuE.Options,),
        PopupMenuItem(child: Text("Profile") , value: PopUpMenuE.Profile,),


      ],
    );
  }
}