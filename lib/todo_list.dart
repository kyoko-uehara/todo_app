
import 'package:flutter/material.dart';


class TodoList extends StatefulWidget {

  TodoList({Key key}) : super(key: key);

  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<TodoList> {
  final items = List<String>.generate(20, (i) => "Item ${i + 1}");

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
      );
  }
}