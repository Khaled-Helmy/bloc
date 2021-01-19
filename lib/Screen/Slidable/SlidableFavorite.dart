import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

enum SlideeAction{View , Remove}
class SlidableFavorite extends StatelessWidget {
  final Widget child ;
  final Function(SlideeAction action) onDismissed;
  const SlidableFavorite({Key key, this.child , this.onDismissed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
        child: child,
        actionPane: SlidableDrawerActionPane() ,
      secondaryActions: [
        IconSlideAction(
          caption: "View",
          color: Colors.redAccent,
          icon: Icons.remove_red_eye_sharp  ,
          onTap: ()=> onDismissed(SlideeAction.View),
        ),
        IconSlideAction(
          caption: "Remove",
          color: Colors.redAccent.shade200,
          icon: Icons.remove_circle,
          onTap: ()=> onDismissed(SlideeAction.Remove),
        ),
      ],
    );
  }
}
