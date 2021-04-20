
import 'package:flutter/material.dart';
import 'package:todo_app/todo_edit.dart';


class TodoList extends StatefulWidget {

  TodoList({Key key}) : super(key: key);

  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<TodoList> {
  final items = List<String>.generate(20, (i) => "Item ${i + 1}");

  // ignore: non_constant_identifier_names
  var ScaffoldMessenger;



  @override
  Widget build(BuildContext context) {
    final title = 'Dismissing Items';

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            return Dismissible(
              // Each Dismissible must contain a Key. Keys allow Flutter to
              // uniquely identify widgets.
              key: Key(item),
              // Provide a function that tells the app
              // what to do after an item has been swiped away.
              onDismissed: (direction) {
                // Remove the item from the data source.
                setState(() {
                  items.removeAt(index);
                });

                // Then show a snackbar.
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("$item dismissed")));
              },
              // Show a red background as the item is swiped away.
              background: Container(color: Colors.red),
              child: ListTile(title: Text('$item')),
            );
          },
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
          if(value == 0) Navigator.pop(context);
          if(value == 1)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TodoEdit()),
            );
          },

      ),
      );
  }
}