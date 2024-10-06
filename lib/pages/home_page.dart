import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../util/db.dart';
import '../util/dialog_box.dart';
import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();
  final db = ToDoDatabase();
  final _box = Hive.box("myBox");

  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.tasks[index][1] = !db.tasks[index][1];
    });
    db.updateData();
  }

  @override
  void initState() {
    if (!_box.containsKey("TODOLIST")) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void newTask() {
    setState(() {
      db.tasks.add([controller.text, false]);
      controller.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: controller,
            onSave: newTask,
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.tasks.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Center(child: Text("TODO")),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: () => createNewTask()),
      body: ListView.builder(
        itemCount: db.tasks.length,
        itemBuilder: (context, index) {
          final item = db.tasks[index];
          return TodoTile(
            status: item[1],
            task: item[0],
            onChanged: (value) => checkboxChanged(value, index),
            deleteFunc: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
