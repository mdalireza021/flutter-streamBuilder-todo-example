import 'dart:async';
import '../model/todo.dart';

class TodoController {
  final StreamController<List<Todo>> _todoStreamController =
      StreamController<List<Todo>>();

  final List<Todo> _todoList = [
    Todo(id: 1, todoText: "Learning Angular", isCompleted: false),
    Todo(id: 2, todoText: "Buy some fruits", isCompleted: false),
    Todo(id: 3, todoText: "Create a todo list", isCompleted: true)
  ];

  int listItemCount() {
    return _todoList.length;
  }
  TodoController() {
    todoSink.add(_todoList);
  }

  StreamSink<List<Todo>> get todoSink => _todoStreamController.sink;

  Stream<List<Todo>> get todoStream => _todoStreamController.stream;

  Future addTodo(Todo newItem) async {
    _todoList.add(newItem);
    todoSink.add(_todoList);
  }

  Future deleteTodo(int id) async {


     _todoList.removeWhere((todo) => todo.id == id );

    todoSink.add(_todoList);

  }
}
