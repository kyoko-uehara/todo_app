import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:collection/collection.dart';
import 'package:path/path.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/todo_list.dart';

class TodoEdit extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO'),
      ),
      body: MyCustomForm(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            // ignore: deprecated_member_use
            title: Text('home'),

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            // ignore: deprecated_member_use
            title: Text('List'),

          ),
          BottomNavigationBarItem(
            // ignore: deprecated_member_use
              title: Text('Save'),
              icon: Icon(Icons.save)),
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
              MaterialPageRoute(builder: (context) => TodoList()),
            );
          if(value == 2)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TodoEdit()),
            );
        },

      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  final _controllerA = TextEditingController();
  final _controllerB = TextEditingController();
  final _controllerC = TextEditingController();

  final TextStyle styleTitle = TextStyle(
      fontSize: 28.0,
      color: Colors.black87
  );
  final TextStyle styleInput = TextStyle(
      fontSize: 26.0,
      color: Colors.black87
  );

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('Name:',style: styleTitle,),
          TextField(
            controller: _controllerA,
            style: styleInput,
          ),
          Text('Mail:',style: styleTitle,),
          TextField(
            controller: _controllerB,
            style: styleInput,
          ),
          Text('Tel:',style: styleTitle,),
          TextField(
            controller: _controllerC,
            style: styleInput,
          ),

        ],
      ),
    );

  }



  Future<void> saveData() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath,"mydata.db");

    String data1 = _controllerA.text;
    String data2 = _controllerB.text;
    String data3 = _controllerC.text;

    String query = 'INSERT INTO mydata(name, mail, tel) VALUES ("$data1","$data2","$data3")';

    Database database = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE IF NOT EXISTS mydata (id INTEGER PRIMARY KEY name TEXT mail TEXT, tel TEXT)");
        }
    );

    await database.transaction((txn) async{
      int id = await txn.rawInsert(query);
      print ("insest : $id");

    });
  }
}