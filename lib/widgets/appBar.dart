//import 'package:flo/utils/Universal_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Widget title;
  final List<Widget> actions;
  final Widget leading;
  final bool centerTitle;

  const CustomAppBar({
    Key key,
    @required this.title,
    @required this.actions,
    @required this.leading,
    @required this.centerTitle,

  }) : super(key: key);
    


 @override
  Widget build(BuildContext context) {
      return Container(
        //padding: const EdgeInsets.all(1 .0),
        decoration: BoxDecoration(
          color: Colors.white70,
          border: Border(bottom: BorderSide(color: Colors.white70,
          width: 1,
          style: BorderStyle.solid,

          ),
          ),

        ),
        child: AppBar(backgroundColor: Colors.pink[900],
        
        elevation: 4,
        leading: leading,
        actions: actions,
        centerTitle: centerTitle,
        title: title,
        )  ,
      );
  }
  final Size preferredSize = const Size.fromHeight(kToolbarHeight+10);
}