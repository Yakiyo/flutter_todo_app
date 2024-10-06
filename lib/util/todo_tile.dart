import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final bool status;
  final String task;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunc;
  TodoTile({
    super.key,
    required this.status,
    required this.task,
    required this.onChanged,
    required this.deleteFunc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: deleteFunc,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(12),
          )
        ]),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.blue[400], borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Checkbox(
                  value: status,
                  checkColor: const Color.fromARGB(255, 2, 5, 7),
                  activeColor: Colors.blue[100],
                  onChanged: onChanged),
              Text(
                task,
                style: TextStyle(
                    decoration: status
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
