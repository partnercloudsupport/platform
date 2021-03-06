import 'package:flutter/material.dart';
import 'count_bloc.dart';
import 'under_screen2.dart';

class UnderScreenPage extends StatefulWidget {
  final bloc;
  UnderScreenPage({this.bloc});

  UnderScreenPageState createState() => UnderScreenPageState();
}

class UnderScreenPageState extends State<UnderScreenPage>{
  CountBloc _bloc;

  @override
  void initState() {
    _bloc = widget.bloc;
    print(_bloc.value);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('子页面'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: _bloc.stream,
          initialData: _bloc.value,
          builder: (BuildContext context,AsyncSnapshot<int> snapshot){
            return Text('${snapshot.data}');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() => Navigator.push(context, MaterialPageRoute(builder: (context) => UnderScreenPage2(bloc: _bloc,))),
        child: Icon(Icons.forward),
      ),
    );
  }
}
