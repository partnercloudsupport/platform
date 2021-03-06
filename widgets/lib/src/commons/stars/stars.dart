import 'package:flutter/material.dart';

//星级
class Stars extends StatelessWidget {
  const Stars(
      {Key key,
      this.starLevel = 1,
      this.color = Colors.orange,
      this.highlightOnly = true,
      this.size=20})
      : super(key: key);

  final int starLevel;
  final Color color;
  final double size;

  //是否只显示亮的星
  final bool highlightOnly;

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];

    for (int i = 0; i < starLevel; i++) {
      stars.add(Container(
        padding: EdgeInsets.fromLTRB(1, 2, 1, 2),
        child: Icon(
          Icons.star,
          color: color,
          size: size,
        ),
      ));
    }

    if (!highlightOnly) {
      for (int i = 0; i < 5 - starLevel; i++) {
        stars.add(Container(
          padding: EdgeInsets.fromLTRB(1, 2, 1, 2),
          child: Icon(
            Icons.star,
            color: Colors.grey[300],
            size: size,
          ),
        ));
      }
    }

    return Container(
      child: Row(
        children: stars,
      ),
    );
  }
}
