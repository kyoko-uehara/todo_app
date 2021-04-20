import 'package:flutter/material.dart';
import 'package:todo_app/todo_edit.dart';
import 'package:todo_app/todo_list.dart';

void main() {

  runApp(MaterialApp(
      title: 'TODO アプリ',

      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TODO'),
        ),
        body: Center(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '今日はなにをしようかな？',
              ),
              RaisedButton(
                child: Text('TODO LIST'),
                onPressed: (){
                   Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => TodoList()),
                   );
                },
              ),

            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TodoEdit()),
            );
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),

    );
  }
}

