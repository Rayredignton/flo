import 'package:flo/models/slide.dart';
import 'package:flutter/material.dart';



class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 800,
          height: 700,
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
            shape: BoxShape.rectangle,
            image: DecorationImage(
              image: AssetImage(slideList[index].imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          slideList[index].title,
          style: TextStyle(
            fontSize: 22,
            color: Colors.pink[800]
          ),
        ),
        SizedBox(
          height: 10,
        ),
        // Text(
        //   slideList[index].description,
        //   textAlign: TextAlign.center,
        // ),
      ],
    );
  }
}