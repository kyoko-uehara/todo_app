
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/todo_edit.dart';


class TodoList extends StatefulWidget {

  TodoList({Key key}) : super(key: key);

  @override
  _TodoList createState() => new _TodoList();
}

class _TodoList extends State<TodoList> {
  List<Widget> _items = <Widget>[];

  @override
  void initState(){
    super.initState();
    getItems();
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Dismissing Items';

    return Scaffold(
        appBar: AppBar(
          title: Text('TODO'),
        ),
        body: ListView(
          children: _items,
        ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              // ignore: deprecated_member_use
              title: Text('Home'),

          ),
          BottomNavigationBarItem(
              // ignore: deprecated_member_use
              title: Text('Add'),
              icon: Icon(Icons.add_circle_outlined)),
        ],
        onTap: (int value){
          if(value == 0)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          if(value == 1)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TodoEdit()),
            );
          },

        ),
      );

    }
    void getItems() async{
      List<Widget> list = <Widget>[];
      String dbPath = await getDatabasesPath();
      String path = join(dbPath,"mydata.db");

      Database database = await openDatabase(
          path,
          version: 1,
          onCreate: (Database db, int version) async {
            await db.execute(
                "CREATE TABLE IF NOT EXISTS mydata (id INTEGER PRIMARY KEY, name TEXT, mail TEXT, tel TEXT)");
          }
      );

      List<Map> result = await database.rawQuery('SELECT * FROM mydata');
      for (Map item in result){
        list.add(
          ListTile(
            title: Text(item['name']),
            subtitle: Text(item['mail'] + ' ' + item['tel']),
          )
        );
      }

      setState(() {
        _items = list;
      });
  }
}