import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  // ignore: unused_field
  final _box = Hive.box("myBox");

  List tasks = [];

  // create defaults
  void createInitialData() {
    tasks = [
      ["Make tutorial", false],
      ["Do Exercise", false],
    ];
    updateData();
  }

  // load data
  void loadData() {
    tasks = _box.get("TODOLIST");
  }

  // update data
  void updateData() {
    _box.put("TODOLIST", tasks);
  }
}
