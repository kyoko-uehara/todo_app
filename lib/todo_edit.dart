import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/todo_list.dart';
import 'package:intl/intl.dart';


class TodoEdit extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO'),
      ),
      body: _MyCustomForm(),
      bottomNavigationBar: MyCustomBottom(),
    );
  }
}

// Create a Form widget.
class _MyCustomForm extends StatefulWidget {

  @override
  _MyCustomFormState createState() {
    return _MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class _MyCustomFormState extends State<_MyCustomForm> {

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

  final TextStyle styleDate = TextStyle(
      fontSize: 26.0,
      color: Colors.black87
  );

  String _labelText = 'Select Date';

  DateTime _date = new DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2016),
        lastDate: new DateTime.now().add(new Duration(days: 360))
    );
    if(picked != null) setState(() {
      this._labelText = (DateFormat.yMMMd()).format(picked);
      //this._controllerB = this._labelText;

    }
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text('やること',style: styleTitle,),
        TextField(
          controller: _controllerA,
          style: styleInput,
        ),
        Text('完了する日',style: styleTitle,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget> [
            Text("$_labelText", style: styleDate,),

            IconButton(
              icon: Icon(Icons.date_range),
              onPressed: () => _selectDate(context),
            ),
          ],
        ),

        TextField(
          controller: _controllerB,
          style: styleInput,
        ),
        Text('メモ',style: styleTitle,),
        TextField(
          controller: _controllerC,
          style: styleInput,
        ),

      ],
    );

  }

   void saveData() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath,"mydata.db");

    String data1 = _controllerA.text;
    String data2 = _controllerB.text;
    String data3 = _controllerC.text;

    data1 = "Flutter";
    data2 = "Apr 30,2021";
    data3 = "今月中頑張る！";


    //String query = "INSERT INTO mydata(name, mail, tel) VALUES ('uehara','uehara@gmail.com','08012345678')";
    String query = "INSERT INTO mydata(name, mail, tel) VALUES ('$data1','$data2','$data3')";

    Database database = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE IF NOT EXISTS mydata (id INTEGER PRIMARY KEY, name TEXT, mail TEXT, tel TEXT)");
        }
    );

    await database.transaction((txn) async{
      int id = await txn.rawInsert(query);
      print ("insest : $id");
      print ("query : $query");

    });
  }
}
// Create a Form widget.
class MyCustomBottom extends StatefulWidget {
  @override
  MyCustomBottomState createState() {
    return MyCustomBottomState();
  }
}


class MyCustomBottomState extends State<MyCustomBottom> {
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return BottomNavigationBar(
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
          _MyCustomFormState().saveData();
      },

    );
  }
}