import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/controllers/todoController.dart';
import '../model/todo.dart';

class TodoItem extends StatelessWidget {
  final TodoController todoController;
  final Todo todo;
  //final onTodoChanged;
  // final onDeleteItem;
   const TodoItem({
    super.key,
     required this.todoController,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          onTap: () {
            print("item clicked");
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tileColor: Colors.white,
          leading: Icon(
            (todo.isCompleted! || false)
                ? Icons.check_box
                : Icons.check_box_outline_blank,
            color: tdBlue,
          ),
          title: Text(
            "${todo.todoText}",
            style: TextStyle(
                fontSize: 17,
                color: tdBlack,
                decoration: (todo.isCompleted! || false)
                    ? TextDecoration.lineThrough
                    : null),
          ),
          trailing: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                color: tdRed, borderRadius: BorderRadius.circular(5)),
            child: IconButton(
              color: Colors.white,
              iconSize: 18,
              icon: const Icon(Icons.delete),
              onPressed: () {
                print("delete item click id is: ${todo.id}");
                todoController.deleteTodo(todo.id);

              },
            ),
          ),
        ));
  }
}
