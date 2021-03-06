import 'package:flutter/material.dart';

class ShowSelectTile extends StatelessWidget{
  String leadingText;
  String tralingText;
  Color tralingTextColor;
  ShowSelectTile({this.leadingText,this.tralingText,this.tralingTextColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Row(
        children: <Widget>[
          Expanded(child: Text(leadingText,style: TextStyle(fontSize: 16),),),
          tralingText != null ? Text(tralingText,style: TextStyle(color: tralingTextColor),) : Text(''),
          Icon(Icons.chevron_right,color: Colors.grey[600],),
        ],
      ),
    );
  }
}