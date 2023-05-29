import 'package:flutter/material.dart';
import '../util/todo_tile.dart';
import '../util/dialogue_box.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = TextEditingController();

  List todoList = [
    ["Go through the tutorial", false],
    ["Do some exercise", false],
  ];

  void changeValue(bool? value, int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
    });
  }

  void saveNewTask() {
    setState(() {
      todoList.add([_controller.text, false]);
      _controller.clear();
    });
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DailogueBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        }
    );
  }

  void deleteTask(int index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Hello there!\nAdd your tasks bellow",
            style: TextStyle(
                fontFamily: 'IndieFlower'
            ),
          ),
          backgroundColor: Colors.red[200],
        ),
        body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: todoList[index][0],
              taskCompleted: todoList[index][1],
              onChanged: (value) => changeValue(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.red[600],
          onPressed: createNewTask,
        ),
      );
  }
}
